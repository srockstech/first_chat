import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseGoogleAuth {
  FirebaseAuth _auth = FirebaseAuth.instance;

  final googleSignIn =
      GoogleSignIn(); //creating an object of GoogleSignIn class

  GoogleSignInAccount?
      _user; //for storing the user account fetched from google (details like profile image, name, email, etc.)

  GoogleSignInAccount get user =>
      _user!; //Getter for accessing the user outside the class

  Future<bool> signIn() async {
    try {
      final googleUser = await googleSignIn
          .signIn(); //triggering the pop up of google authentication and storing the chosen account
      if (googleUser == null)
        return false; //if no account was chosen, terminate the function

      _user =
          googleUser; //if an account was chosen, storing it to the '_user' variable

      //for fetching credential, accessToken and idToken are used. They are accessed using 'authentication' getter from the 'GoogleSignInAuthentication' class of the 'google_sign_in' file.
      final googleAuth = await googleUser.authentication;

      //creating credential using the accessToken and idToken
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      //signing the user in using the credential fetched
      await _auth.signInWithCredential(credential);
      // notifyListeners();
      return true;
    } catch (e) {
      print(e.toString());
    }
    return true;
  }

  Future signOut() async {
    // await googleSignIn.signOut();
    // await googleSignIn.disconnect();
    await _auth.signOut();
  }
}

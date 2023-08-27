import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FirebaseFacebookAuth {
  FirebaseAuth _auth = FirebaseAuth.instance;

  final facebookSignIn = FacebookAuth.instance; //getting facebook auth instance

  UserCredential?
      _user; //for storing the user account fetched from google (details like profile image, name, email, etc.)

  UserCredential get user =>
      _user!; //Getter for accessing the user outside the class

  Future<bool> signIn() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await facebookSignIn.login();

    //Return false if sign-in cancelled or failed
    if (loginResult.status == LoginStatus.cancelled ||
        loginResult.status == LoginStatus.failed) {
      return false;
    }

    // Create a credential from the access token
    final facebookAuthCredential = FacebookAuthProvider.credential(
      loginResult.accessToken!.token,
    );

    // //signing the Firebase user in using the credential created
    _user = await _auth.signInWithCredential(facebookAuthCredential);
    await facebookSignIn.logOut();
    return true;
  }

  Future signOut() async {
    await facebookSignIn.logOut();
    await _auth.signOut();
  }
}

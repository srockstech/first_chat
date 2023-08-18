import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_chat/components/circular_icon_button.dart';
import 'package:first_chat/components/quote_bubble_text_field.dart';
import 'package:first_chat/components/rounded_button.dart';
import 'package:first_chat/constants.dart';
import 'package:first_chat/design/custom_box_decoration.dart';
import 'package:first_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../services/firebase_google_auth.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'RegistrationScreen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String? email;
  String? password;
  String? name;
  bool showSpinner = false;
  bool hiddenPassword = true;
  List<TextInputType> emailTextInputTypes = [
    TextInputType.emailAddress,
    TextInputType.multiline
  ];
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kPink,
      body: ModalProgressHUD(
        opacity: 0.4,
        progressIndicator: RefreshProgressIndicator(
          color: Colors.white,
          strokeWidth: 3,
          backgroundColor: kLightBrown,
        ),
        color: Colors.black,
        inAsyncCall: showSpinner,
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: screenHeight * 0.06,
                  right: screenHeight * 0.06,
                  top: screenHeight * 0.1,
                  bottom: screenHeight * 0.08),
              decoration:
                  CustomBoxDecoration.bottomLeftRoundCornerShadow(screenHeight),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: Container(
                      height: screenHeight * 0.22,
                      child: Image.asset('images/logo_4.png'),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  QuoteBubbleTextField(
                    screenHeight: screenHeight,
                    keyboardType: TextInputType.name,
                    prefixIcon: Icon(
                      Icons.person,
                      color: kBlack,
                    ),
                    label: 'Name',
                    onChanged: (value) {
                      name = value;
                    },
                  ),
                  SizedBox(
                    height: screenHeight * 0.019,
                  ),
                  QuoteBubbleTextField(
                    screenHeight: screenHeight,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icon(
                      Icons.email_rounded,
                      color: kBlack,
                    ),
                    label: 'Email',
                    onChanged: (value) {
                      email = value;
                    },
                  ),
                  SizedBox(
                    height: screenHeight * 0.019,
                  ),
                  QuoteBubbleTextField(
                    screenHeight: screenHeight,
                    obscureText: hiddenPassword,
                    prefixIcon: Icon(
                      Icons.lock,
                      color: kBlack,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (hiddenPassword == true) {
                          setState(() {
                            hiddenPassword = false;
                          });
                        } else {
                          setState(() {
                            hiddenPassword = true;
                          });
                        }
                      },
                      icon: (hiddenPassword == true)
                          ? Icon(
                              FontAwesomeIcons.eyeSlash,
                              size: screenHeight * 0.022,
                              color: kBlack,
                            )
                          : Icon(
                              FontAwesomeIcons.eye,
                              size: screenHeight * 0.022,
                              color: kBlack,
                            ),
                    ),
                    label: 'Password',
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                  SizedBox(
                    height: screenHeight * 0.04,
                  ),
                  RoundedButton(
                    topLeftSharpCorner: true,
                    color: kLightBrown,
                    shadowColor: kLightBrownShadow,
                    text: 'Register',
                    textColor: Colors.white,
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                          email: email!,
                          password: password!,
                        );
                        if (newUser != null) {
                          Navigator.pushNamed(context, ChatScreen.id);
                        }
                        setState(() {
                          showSpinner = false;
                        });
                      } catch (e) {
                        await Fluttertoast.showToast(
                            msg: e.toString(), toastLength: Toast.LENGTH_LONG);
                        setState(() {
                          showSpinner = false;
                        });
                      }
                    },
                  ),
                  SizedBox(
                    height: screenHeight * 0.025,
                  ),
                  SizedBox(
                    height: screenHeight * 0.012,
                    width: screenHeight * 0.4,
                    child: Divider(
                      height: 0,
                      color: Colors.grey,
                      thickness: screenHeight * 0.001,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularIconButton(
                        screenHeight: screenHeight,
                        icon: Image.asset('images/google_logo.png'),
                        onPressed: () async {
                          setState(() {
                            showSpinner = true;
                          });
                          final provider = Provider.of<FirebaseGoogleAuth>(
                              context,
                              listen: false);
                          bool loggedin = await provider.signIn();
                          if (loggedin) {
                            int flag =
                                1; //So that it listens only once for one call of this function
                            _auth.authStateChanges().listen((user) {
                              if (user != null && flag == 1) {
                                Navigator.pushNamed(context, ChatScreen.id);
                                flag = 0;
                                setState(() {
                                  showSpinner = false;
                                });
                              }
                            });
                          } else {
                            setState(() {
                              showSpinner = false;
                            });
                          }
                        },
                      ),
                      CircularIconButton(
                        screenHeight: screenHeight,
                        icon: Image.asset('images/facebook_logo.png'),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

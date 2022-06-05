import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/quote_bubble_text_field.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'LoginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  bool hiddenPassword = true;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: kOrange,
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: screenHeight * 0.06,
                    right: screenHeight * 0.06,
                    top: screenHeight * 0.16,
                    bottom: screenHeight * 0.04),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black87,
                        offset:
                            Offset(screenHeight * 0.02, screenHeight * 0.005),
                        blurRadius: screenHeight * 0.025,
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.elliptical(
                          screenHeight * 0.1, screenHeight * 0.07),
                    )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Hero(
                      tag: 'logo',
                      child: Container(
                        height: 200.0,
                        child: Image.asset('images/logo_3.png'),
                      ),
                    ),
                    SizedBox(
                      height: 48.0,
                    ),
                    QuoteBubbleTextField(
                      screenHeight: screenHeight,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Icon(
                        Icons.email_rounded,
                        color: kDarkBlue,
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
                        color: kDarkBlue,
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
                                color: kDarkBlue,
                              )
                            : Icon(
                                FontAwesomeIcons.eye,
                                size: screenHeight * 0.022,
                                color: kDarkBlue,
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
                      color: kOrange,
                      shadowColor: kOrangeShadow,
                      text: 'Login',
                      textColor: Colors.white,
                      onPressed: () async {
                        setState(() {
                          showSpinner = true;
                        });
                        try {
                          final user = await _auth.signInWithEmailAndPassword(
                              email: email, password: password);
                          if (user != null) {
                            Navigator.pushNamed(context, ChatScreen.id);
                          }
                          setState(() {
                            showSpinner = false;
                          });
                        } catch (e) {
                          print(e);
                        }
                      },
                    ),
                    SizedBox(
                      height: screenHeight * 0.025,
                    ),
                    Divider(
                      color: Colors.grey[400],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(screenHeight * 0.1),
                            border: Border.all(
                                color: kDarkBlue, width: screenHeight * 0.001),
                          ),
                          margin: EdgeInsets.all(screenHeight * 0.01),
                          height: screenHeight * 0.055,
                          width: screenHeight * 0.055,
                          child: IconButton(
                            icon: Icon(
                              FontAwesomeIcons.google,
                            ),
                            iconSize: screenHeight * 0.03,
                            color: kDarkBlue,
                            onPressed: () {},
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(screenHeight * 0.1),
                            border: Border.all(
                                color: kDarkBlue, width: screenHeight * 0.001),
                          ),
                          margin: EdgeInsets.all(screenHeight * 0.01),
                          height: screenHeight * 0.055,
                          width: screenHeight * 0.055,
                          child: IconButton(
                            icon: Icon(FontAwesomeIcons.facebookF),
                            iconSize: screenHeight * 0.03,
                            color: kDarkBlue,
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: screenHeight * 0.1,
                color: Colors.transparent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

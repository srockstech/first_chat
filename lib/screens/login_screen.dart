import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/circular_icon_button.dart';
import 'package:flash_chat/components/quote_bubble_text_field.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/design/custom_box_decoration.dart';
import 'package:flash_chat/screens/chat_screen.dart';
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
  bool hiddenPassword = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: kPink,
      body: SafeArea(
        child: ModalProgressHUD(
          opacity: 0.4,
          progressIndicator: RefreshProgressIndicator(
            color: kDarkBlue,
            strokeWidth: 3,
            backgroundColor: kPinkShadow,
          ),
          color: Colors.black,
          inAsyncCall: showSpinner,
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: screenHeight * 0.06,
                    right: screenHeight * 0.06,
                    top: screenHeight * 0.16,
                    bottom: screenHeight * 0.04),
                decoration: CustomBoxDecoration.bottomLeftRoundCornerShadow(
                    screenHeight),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Hero(
                      tag: 'logo',
                      child: Container(
                        height: screenHeight * 0.22,
                        child: Image.asset('images/logo_3.png'),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.05,
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
                      topLeftSharpCorner: true,
                      color: kPink,
                      shadowColor: kPinkShadow,
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
                        CircularIconButton(
                          screenHeight: screenHeight,
                          icon: Icon(
                            FontAwesomeIcons.google,
                          ),
                          onPressed: () {},
                        ),
                        CircularIconButton(
                          screenHeight: screenHeight,
                          icon: Icon(
                            FontAwesomeIcons.facebookF,
                          ),
                          onPressed: () {},
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

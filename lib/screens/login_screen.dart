import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_chat/components/circular_icon_button.dart';
import 'package:first_chat/components/quote_bubble_text_field.dart';
import 'package:first_chat/components/rounded_button.dart';
import 'package:first_chat/constants.dart';
import 'package:first_chat/styles/custom_box_decoration.dart';
import 'package:first_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../services/firebase_facebook_auth.dart';
import '../services/firebase_google_auth.dart';
import '../styles/custom_shadow.dart';
import '../styles/custom_text_style.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'LoginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;
  String? password;
  bool showSpinner = false;
  bool hiddenPassword = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // NavigatorState? _navigator;

  // late PageController _pageController;
  // double _dragStartX = 0.0;

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   _navigator = Navigator.of(context);
  // }
  //
  // @override
  // void initState() {
  //   _pageController = PageController();
  //   super.initState();
  // }
  //
  // @override
  // void dispose() {
  //   _pageController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: kPink,
      body: SafeArea(
        child: ModalProgressHUD(
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
                    top: screenHeight * 0.14,
                    bottom: screenHeight * 0.02),
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
                        child: Image.asset('images/logo_4.png'),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.05,
                    ),
                    QuoteBubbleTextField(
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: screenHeight * 0.012),
                        child: Icon(
                          Icons.email_rounded,
                          color: kBlack,
                        ),
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
                      obscureText: hiddenPassword,
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: screenHeight * 0.012),
                        child: Icon(
                          Icons.lock,
                          color: kBlack,
                        ),
                      ),
                      suffixIcon: IconButton(
                        padding: EdgeInsets.only(right: screenHeight * 0.012),
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
                      child: Text(
                        'Logout',
                        style: CustomTextStyle.secondaryTextStyle(context, screenHeight),
                      ),
                      shadow: CustomShadow.primaryCTAShadow(),
                      onPressed: () async {
                        setState(() {
                          showSpinner = true;
                        });
                        try {
                          await _auth.signInWithEmailAndPassword(
                              email: email!, password: password!);
                            Navigator.pushNamed(context, ChatScreen.id);
                          setState(() {
                            showSpinner = false;
                          });
                        } catch (e) {
                          await Fluttertoast.showToast(
                            timeInSecForIosWeb: 5,
                              msg: e.toString(),
                              toastLength: Toast.LENGTH_LONG);
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
                      height: screenHeight * 0.032,
                      width: screenHeight * 0.4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            color: Colors.grey[300],
                            height: 1.5,
                            width: screenHeight * 0.12,
                          ),
                          Text('   OR   ',
                              style: TextStyle(
                                color: kBlack,
                                fontSize: screenHeight * 0.02,
                                fontWeight: FontWeight.w600,
                              )),
                          Container(
                            color: Colors.grey[300],
                            height: 1.5,
                            width: screenHeight * 0.12,
                          ),
                        ],
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
                            final provider = FirebaseGoogleAuth();
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
                          icon: Image.asset('images/facebook_logo.png', height: screenHeight * 0.03,),
                          onPressed: () async {
                            setState(() {
                              showSpinner = true;
                            });
                            final provider = FirebaseFacebookAuth();
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
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

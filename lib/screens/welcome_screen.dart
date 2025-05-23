import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_chat/components/circular_icon_button.dart';
import 'package:first_chat/components/rounded_button.dart';
import 'package:first_chat/constants.dart';
import 'package:first_chat/styles/custom_box_decoration.dart';
import 'package:first_chat/styles/custom_text_style.dart';
import 'package:first_chat/screens/phone_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../styles/custom_shadow.dart';
import '../services/firebase_facebook_auth.dart';
import '../services/firebase_google_auth.dart';
import 'chat_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'WelcomeScreen';
  final bool passedForAnimation;

  WelcomeScreen({required this.passedForAnimation});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool showSpinner = false;


  @override
  void initState() {

    super.initState();
  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kPink, //animation.value
      body: ModalProgressHUD(
        opacity: 0.4,
        progressIndicator: RefreshProgressIndicator(
          color: Colors.white,
          strokeWidth: 3,
          backgroundColor: kLightBrown,
        ),
        color: Colors.black,
        inAsyncCall: showSpinner,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 8,
              child: Container(
                color: kPink, //animation.value
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Hero(
                      transitionOnUserGestures: true,
                      tag: 'logo',
                      child: Container(
                        child: Image.asset('images/logo_4.png'),
                        height: screenHeight * 0.1,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'first',
                          style: CustomTextStyle.appLogoNameTextStyle(context, screenHeight),
                        ),
                        Text(
                          'chat',
                          style: CustomTextStyle.appLogoNameTextStyle(context, screenHeight)
                              .copyWith(color: kDarkBrown),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                decoration: CustomBoxDecoration.topRightRoundCornerShadow(
                    screenHeight),
                padding: EdgeInsets.only(
                    left: screenHeight * 0.06, right: screenHeight * 0.06),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: screenHeight * 0.04,
                    ),
                    Visibility(
                      visible: (Platform.isAndroid) ? !widget.passedForAnimation : true,
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      child: Hero(
                        tag: (widget.passedForAnimation) ? 'noMainCta' : 'mainCta',
                        transitionOnUserGestures: true,
                        child: RoundedButton(
                            topLeftSharpCorner: true,
                            color: kLightBrown,
                            child: Text(
                              'Get Started',
                              style: CustomTextStyle.secondaryTextStyle(context, screenHeight),
                            ),
                            shadow: CustomShadow.primaryCTAShadow(),
                            onPressed: () {
                              Navigator.pushNamed(context, PhoneLoginScreen.id);
                            }),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    RoundedButton(
                        topLeftSharpCorner: true,
                        bordered: true,
                        borderColor: kBlack,
                        color: Colors.white,
                        child: Text(
                          'Already a member? Login',
                          style: CustomTextStyle.secondaryTextStyle(context, screenHeight).copyWith(color: kBlack),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, PhoneLoginScreen.id);
                        }),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    SizedBox(
                      height: screenHeight * 0.04,
                      width: screenHeight * 0.4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
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
            ),
          ],
        ),
      ),
    );
  }
}

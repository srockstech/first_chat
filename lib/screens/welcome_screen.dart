import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'WelcomeScreen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 1,
      ),
    );
    animation = ColorTween(
      begin: kPink,
      end: kPink,
    ).animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: animation.value,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Container(
              color: animation.value,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: 'logo',
                    child: Container(
                      child: Image.asset('images/logo_3.png'),
                      height: screenHeight * 0.1,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // SizedBox(width: 19),
                      AnimatedTextKit(
                        isRepeatingAnimation: false,
                        animatedTexts: [
                          TyperAnimatedText(
                            'See',
                            textStyle: TextStyle(
                              fontSize: 60.0,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                            speed: Duration(milliseconds: 500),
                          ),
                        ],
                      ),
                      AnimatedTextKit(
                        isRepeatingAnimation: false,
                        animatedTexts: [
                          TyperAnimatedText(
                            'chat',
                            textStyle: TextStyle(
                              fontSize: 60.0,
                              fontWeight: FontWeight.w900,
                              color: kDarkBlue,
                            ),
                            speed: Duration(milliseconds: 500),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height * 0.1,
                  // ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(screenHeight * 0.1),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[700],
                    offset: Offset(0, 10),
                    blurStyle: BlurStyle.normal,
                    blurRadius: 30,
                  ),
                ],
                color: Colors.white,
              ),
              padding: EdgeInsets.only(left: 50, right: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: screenHeight * 0.04,
                  ),
                  RoundedButton(
                      bordered: true,
                      color: kDarkBlue,
                      text: 'Login with email',
                      textColor: kDarkBlue,
                      shadowColor: kLightBlueShadow,
                      onPressed: () {
                        Navigator.pushNamed(context, LoginScreen.id);
                      }),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  RoundedButton(
                      color: kPink,
                      text: 'Get Started',
                      shadowColor: kPinkShadow,
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.pushNamed(context, RegistrationScreen.id);
                      }),
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
          ),
        ],
      ),
    );
  }
}

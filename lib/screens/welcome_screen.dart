import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
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
    // controller = AnimationController(
    //   vsync: this,
    //   duration: Duration(
    //     seconds: 1,
    //   ),
    // );
    // animation = ColorTween(
    //   begin: kOrange,
    //   end: kOrange,
    // ).animate(controller);
    // controller.forward();
    // controller.addListener(() {
    //   setState(() {});
    // });
    super.initState();
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
      backgroundColor: kPink, //animation.value
      body: Column(
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
                    tag: 'logo',
                    child: Container(
                      child: Image.asset('images/logo_3.png'),
                      height: screenHeight * 0.1,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'See',
                        style: TextStyle(
                          fontSize: screenHeight * 0.08,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'chat',
                        style: TextStyle(
                          fontSize: screenHeight * 0.08,
                          fontWeight: FontWeight.w900,
                          color: kDarkBlue,
                        ),
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.elliptical(
                      screenHeight * 0.1, screenHeight * 0.07),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black87,
                    offset: Offset(screenHeight * -0.02, screenHeight * 0.005),
                    spreadRadius: screenHeight * 0.005,
                    blurRadius: screenHeight * 0.025,
                  ),
                ],
                color: Colors.white,
              ),
              padding: EdgeInsets.only(
                  left: screenHeight * 0.06, right: screenHeight * 0.06),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: screenHeight * 0.04,
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
                    height: screenHeight * 0.03,
                  ),
                  RoundedButton(
                      bordered: true,
                      color: kDarkBlue,
                      text: 'Already a member? Login',
                      textColor: kDarkBlue,
                      onPressed: () {
                        Navigator.pushNamed(context, LoginScreen.id);
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

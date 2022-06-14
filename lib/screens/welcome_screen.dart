import 'package:flash_chat/components/circular_icon_button.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/design/custom_box_decoration.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';

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
                      child: Image.asset('images/logo_4.png'),
                      height: screenHeight * 0.1,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'first',
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
                          color: kDarkBrown,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              decoration:
                  CustomBoxDecoration.topRightRoundCornerShadow(screenHeight),
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
                      topLeftSharpCorner: true,
                      color: kLightBrown,
                      text: 'Get Started',
                      shadowColor: kLightBrownShadow,
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.pushNamed(context, RegistrationScreen.id);
                      }),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  RoundedButton(
                      topLeftSharpCorner: true,
                      bordered: true,
                      color: kBlack,
                      text: 'Already a member? Login',
                      textColor: kBlack,
                      onPressed: () {
                        Navigator.pushNamed(context, LoginScreen.id);
                      }),
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
                        onPressed: () {},
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
          ),
        ],
      ),
    );
  }
}

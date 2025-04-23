import 'dart:io';

import 'package:first_chat/constants.dart';
import 'package:first_chat/styles/custom_shadow.dart';
import 'package:first_chat/styles/custom_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../components/quote_bubble_text_field.dart';
import '../components/rounded_button.dart';

class PhoneLoginScreen extends StatefulWidget {
  static const String id = 'PhoneLoginScreen';

  const PhoneLoginScreen({Key? key}) : super(key: key);

  @override
  State<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen> {
  String? phoneNumber;
  TextEditingController? controller;
  FocusNode? phoneNumberFocusNode;


  @override
  void initState() {
    controller = TextEditingController();
    phoneNumberFocusNode = FocusNode();
      if(!Platform.isIOS) {
        controller!.addListener(() {
          print('Phone number: ${controller!.text}');
        if (controller!.text.length == 10) {
          phoneNumberFocusNode!.unfocus();
        }
        });
      }
      // else{
      //   controller!.addListener(() {
      //     print('Phone number: ${controller!.text}');
      //     if (controller!.text.length == 10 && phoneNumberFocusNode!.hasFocus) {
      //       phoneNumberFocusNode!.unfocus();
      //     }
      //   });
      // }
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    phoneNumberFocusNode!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kPink,
      body: SafeArea(
          child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                  child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.03),
                // progress indicator bar
                Stack(
                  children: [
                    Divider(
                      height: 4,
                      color: kBlack.withOpacity(0.25),
                      thickness: 4,
                    ),
                    Divider(
                      height: 4,
                      color: kBlack,
                      thickness: 4,
                      endIndent: screenWidth * 0.66,
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.09),
                // Country code and phone number input field
                Row(
                  children: [
                    // Country code
                    RoundedButton(
                      borderColor: Colors.white,
                      shadow: [
                        (Platform.isAndroid) ? BoxShadow(
                          color: kDarkBrown,
                          offset: Offset(3, 3),
                          blurRadius: 3,
                          spreadRadius: 0.5,
                        ) : BoxShadow(
                          color: kDarkBrown,
                          offset: Offset(4, 3),
                          blurRadius: 14.4,
                        ),
                      ],
                      bordered: true,
                      color: kPink,
                      bottomLeftSharpCorner: true,
                      contentPadding: EdgeInsets.only(
                        top: screenHeight * 0.02,
                        bottom: screenHeight * 0.02,
                        left: screenWidth * 0.03,
                        right: screenWidth * 0.01
                      ),
                      child: Row(
                        children: [
                          Text(
                            '+91',
                            style: CustomTextStyle.secondaryTextStyle(context, screenHeight),
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            color: kLightBrown,
                          ),
                        ],
                      ),
                      onPressed: () {},
                    ),
                    SizedBox(width: 10),
                    // Phone number input field
                    Expanded(
                      child: QuoteBubbleTextField(
                        focusNode: phoneNumberFocusNode,
                        controller: controller,
                        shadow: [
                          (Platform.isAndroid) ? BoxShadow(
                            color: kDarkBrown,
                            offset: Offset(4, 4),
                            blurRadius: 4,
                          ) : BoxShadow(
                            color: kDarkBrown,
                            offset: Offset(4, 3),
                            blurRadius: 14.4,
                          ),
                        ],
                        contentPadding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.02,
                            horizontal: screenWidth * 0.083),
                        enabledBorderWidth: screenHeight * 0.002,
                        focusedBorderWidth: screenHeight * 0.002,
                        enabledBorderColor: kDarkBrown,
                        focusedBorderColor: kDarkBrown,
                        haveSharpCorner: true,
                        textColor: Colors.white,
                        hintText: 'Mobile Number',
                        hintTextColor: Colors.white,
                        cursorColor: kDarkBrown,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.done,
                        maxLines: 1,
                        fontSize: screenWidth * 0.043,
                        fillColor: kPink,
                        onChanged: (value) {
                          phoneNumber = value;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.065),
                RichText(text: TextSpan(
                  text: 'Your\nnumber\n',
                  style: CustomTextStyle.appLogoNameTextStyle(context, screenHeight).copyWith(color: kDarkBrown, height: 0.9,),
                  children: [
                    TextSpan(
                      text: 'please ',
                      style: CustomTextStyle.appLogoNameTextStyle(context, screenHeight).copyWith(height: 0.9,),
                    ),
                    TextSpan(
                      text: ':)',
                      style:  CustomTextStyle.appLogoNameTextStyle(context, screenHeight).copyWith(color: kDarkBrown, height: 0.9,),
                    ),
                  ],
                ),),
              ],
            ),
            // CTA
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // proceed button using the RoundedButton widget
                Hero(
                  tag: 'mainCta',
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.07),
                    child: RoundedButton(
                      shadow: CustomShadow.primaryCTAShadow(),
                      topLeftSharpCorner: true,
                      onPressed: () {},
                      color: Colors.white,
                      child: Text(
                        'Proceed',
                        style: CustomTextStyle.secondaryTextStyle(context, screenHeight).copyWith(color: kDarkBrown),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.06),
              ],
            ),
          ],
                  ),
                )),
    );
  }
}

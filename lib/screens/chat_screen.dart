import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_chat/components/circular_icon_button.dart';
import 'package:first_chat/components/quote_bubble_text_field.dart';
import 'package:first_chat/components/rounded_button.dart';
import 'package:first_chat/constants.dart';
import 'package:first_chat/styles/custom_box_decoration.dart';
import 'package:first_chat/screens/welcome_screen.dart';
import 'package:first_chat/services/firebase_facebook_auth.dart';
import 'package:first_chat/services/firebase_google_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../styles/custom_text_style.dart';

final _firestore = FirebaseFirestore.instance;
User? loggedInUser;
int messageSerial = 0;

class ChatScreen extends StatefulWidget {
  static const String id = 'ChatScreen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  String? message;

  final messageTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser!.email);
      }
    } catch (e) {
      print(e);
    }
  }

  void setMessageSerialToLast() async {
    final messages =
        await _firestore.collection('messages').orderBy('serialNumber').get();
    for (var message in messages.docs) {
      messageSerial = message.get('serialNumber');
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration(seconds: 0),
      () => setMessageSerialToLast(),
    );
    final screenHeight = MediaQuery.of(context).size.height;
    return PopScope(
      canPop: false,
      onPopInvoked: (value) async {
        await SystemNavigator.pop();
      },
      child: Scaffold(
        backgroundColor: kDarkBrown,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    top: screenHeight * 0.01, bottom: screenHeight * 0.01),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RoundedButton(
                        color: Colors.transparent,
                        child: Text(
                          'Logout',
                          style: CustomTextStyle.secondaryTextStyle(context, screenHeight).copyWith(color: kCream),
                        ),
                        onPressed: () async {
                          try {
                            print('Logged in user: ${loggedInUser!.email}');
                            var signInMethod =
                            await _auth.fetchSignInMethodsForEmail(
                                loggedInUser!.email!);
                            print('SignIn method: ${signInMethod[0]}');
                            switch (signInMethod[0]) {
                              case 'facebook.com':
                                await FirebaseFacebookAuth().signOut();
                                print('facebook.com');
                                break;
                              case 'google.com':
                                await FirebaseGoogleAuth().signOut();
                                print('google.com');
                                break;
                              default:
                                await _auth.signOut();
                            }
                          } catch (e) {
                            print('Exception in fetchSignInMethods: $e');
                          }
                          if(_auth.currentUser == null) {
                            Navigator.pushNamed(context, WelcomeScreen.id);
                          }
                        },
                      ),
                      RoundedButton(
                        color: Colors.transparent,
                        child: Text(
                          'Search',
                          style: CustomTextStyle.secondaryTextStyle(context, screenHeight).copyWith(color: kCream),
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
              MessagesStream(screenHeight: screenHeight),
              SizedBox(
                child: Divider(
                  height: 0,
                  thickness: 1,
                  color: Colors.grey[300],
                ),
              ),
              Container(
                decoration: kMessageContainerDecoration,
                child: Padding(
                  padding: EdgeInsets.all(screenHeight * 0.01),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: QuoteBubbleTextField(
                            controller: messageTextController,
                            textColor: kLightBrown,
                            cursorColor: kLightBrown,
                            haveSharpCorner: false,
                            maxLines: 5,
                            minLines: 1,
                            keyboardType: TextInputType.multiline,
                            enabledBorderColor: Colors.transparent,
                            focusedBorderColor: Colors.transparent,
                            fillColor: kCream,
                            focusColor: Colors.white,
                            prefixIcon: IconButton(
                              icon: Icon(
                                FontAwesomeIcons.faceSmileBeam,
                                color: kLightBrown,
                                size: 24,
                              ),
                              splashRadius: screenHeight * 0.03,
                              onPressed: () {},
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                FontAwesomeIcons.paperclip,
                                color: Colors.grey[600],
                                size: 20,
                              ),
                              splashRadius: screenHeight * 0.03,
                              onPressed: () {},
                            ),
                            hintText: 'Type your message...',
                            hintTextColor: Colors.grey[600],
                            onChanged: (value) {
                              message = value;
                            }),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: screenHeight * 0.01,
                            top: screenHeight * 0.004),
                        height: screenHeight * 0.06,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: kLightBrown),
                        child: IconButton(
                          padding: EdgeInsets.only(right: screenHeight * 0.003),
                          splashRadius: 1,
                          icon: Icon(FontAwesomeIcons.solidPaperPlane,
                              color: Colors.white, size: 20),
                          onPressed: () async {
                            message = message!.trim();
                            if (message!.isNotEmpty) {
                              messageTextController.clear();
                              await Future.delayed(
                                Duration(seconds: 0),
                                () => setMessageSerialToLast(),
                              );
                              await _firestore.collection('messages').add({
                                'serialNumber': ++messageSerial,
                                'text': message,
                                'sender': loggedInUser!.email,
                              });
                              message = null;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  final screenHeight;

  MessagesStream({this.screenHeight});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('messages')
          .orderBy('serialNumber', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: kBlack,
              color: Colors.white,
            ),
          );
        }
        final messages = snapshot.data!.docs;
        List<Widget> messageWidgets = [];
        for (var message in messages) {
          final messageText = message.get('text');
          final messageSender = message.get('sender');
          final messageWidget = MessageBubble(
            onPressed: () {},
            screenHeight: screenHeight,
            messageText: messageText,
            messageSender: messageSender,
            isMe: messageSender == loggedInUser!.email,
          );
          messageWidgets.add(messageWidget);
        }
        return Expanded(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Container(
              decoration:
                  CustomBoxDecoration.topRightRoundCornerShadow(screenHeight),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: screenHeight * 0.04,
                        right: screenHeight * 0.04,
                        top: screenHeight * 0.01,
                        bottom: screenHeight * 0.003),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            'Anonymous Grp',
                            style: TextStyle(
                                color: kDarkBrown,
                                fontSize: screenHeight * 0.023,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: screenHeight * 0.06,
                        ),
                        Row(
                          children: [
                            CircularIconButton(
                              screenHeight: screenHeight,
                              height: screenHeight * 0.045,
                              width: screenHeight * 0.045,
                              onPressed: () {},
                              icon: Icon(
                                FontAwesomeIcons.phone,
                                color: kDarkBrown,
                                size: screenHeight * 0.02,
                              ),
                            ),
                            CircularIconButton(
                              screenHeight: screenHeight,
                              height: screenHeight * 0.045,
                              width: screenHeight * 0.045,
                              onPressed: () {},
                              icon: Icon(
                                FontAwesomeIcons.video,
                                color: kDarkBrown,
                                size: screenHeight * 0.02,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.012,
                    width: screenHeight * 0.4,
                    child: Divider(
                      height: 0,
                      thickness: 1,
                      color: Colors.grey[300],
                    ),
                  ),
                  Flexible(
                    child: ListView(
                      reverse: true,
                      children: messageWidgets,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    required this.screenHeight,
    required this.messageText,
    required this.messageSender,
    required this.isMe,
    required this.onPressed,
  });

  final double screenHeight;
  final String messageText;
  final String messageSender;
  final bool isMe;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: screenHeight * 0.005,
          left: screenHeight * 0.01,
          right: screenHeight * 0.01),
      child: Row(
        mainAxisAlignment:
            (isMe) ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Flexible(flex: 2, child: SizedBox()),
          Flexible(
            flex: 10,
            child: TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
              padding: EdgeInsets.all(screenHeight * 0.02),
              backgroundColor: (isMe) ? kLightBrown : kCream,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(screenHeight * 0.04),
                  topLeft: (isMe) ? Radius.circular(screenHeight * 0.04) : Radius.circular(0),
                  bottomLeft: Radius.circular(screenHeight * 0.04),
                  bottomRight: (isMe) ? Radius.circular(0) : Radius.circular(screenHeight * 0.04),
                ),
              ),
            ),
            child: Text(
              '$messageText',
              style: TextStyle(
                fontSize: screenHeight * 0.02,
                color: (isMe) ? Colors.white : Colors.grey[800],
                letterSpacing: 0.5,
              ),
            ),
          ),
          ),
        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/quote_bubble_text_field.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'ChatScreen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  User loggedInUser;
  String message;

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
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  void messagesStream() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var document in snapshot.docs) {
        print(document.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kDarkBlue,
      appBar: AppBar(
        elevation: 0,
        leading: null,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              _auth.signOut();
              Navigator.pop(context);
            },
          ),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: kDarkBlue,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('messages').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: kDarkBlue,
                    ),
                  );
                }
                final messages = snapshot.data.docs;
                List<Text> messageWidgets = [];
                for (var message in messages) {
                  final messageText = message.get('text');
                  final messageSender = message.get('sender');
                  final messageWidget = Text(
                    '$messageText from $messageSender',
                    style: TextStyle(fontSize: 45),
                  );
                  messageWidgets.add(messageWidget);
                }
                return Expanded(
                  child: Container(
                    color: Colors.white,
                    child: ListView(
                      children: messageWidgets,
                    ),
                  ),
                );
              },
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
                          textColor: kPink,
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
                              color: kPink,
                              size: 24,
                            ),
                            splashRadius: screenHeight * 0.03,
                            onPressed: () {},
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              FontAwesomeIcons.paperclip,
                              color: kLightPink,
                              size: 20,
                            ),
                            splashRadius: screenHeight * 0.03,
                            onPressed: () {},
                          ),
                          screenHeight: screenHeight,
                          hintText: 'Type your message...',
                          hintTextColor: kLightPink,
                          onChanged: (value) {
                            message = value;
                          }),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: screenHeight * 0.01, top: screenHeight * 0.004),
                      height: screenHeight * 0.06,
                      decoration:
                          BoxDecoration(shape: BoxShape.circle, color: kPink),
                      child: IconButton(
                        padding: EdgeInsets.only(right: screenHeight * 0.003),
                        splashRadius: 1,
                        icon: Icon(FontAwesomeIcons.solidPaperPlane,
                            color: Colors.white, size: 20),
                        onPressed: () async {
                          await _firestore.collection('messages').add({
                            'text': message,
                            'sender': loggedInUser.email,
                          });
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
    );
  }
}

import 'dart:async';

import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Chatbot {
  String url = 'https://discord-ro.tk:5000/v1/chat';

  Future<String> makeRequest(zice, uid) async {
    var querystring = {'zice': zice};
    var uri = Uri.parse(url);
    var resp = await http.get(
      uri.replace(queryParameters: querystring),
    );
    print('What comes back is ${resp.body.split('"')[3]}');
    return resp.body.split('"')[3];
  }
}

class Chat extends StatefulWidget {
  const Chat({Key key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

ChatUser botic = ChatUser(
  name: 'Andrei',
  firstName: 'Andrei',
  lastName: 'Taranu',
  uid: '12345678',
);
List<ChatMessage> messages = [
  ChatMessage(
      text: '''
Hi, I'm the Autonet Natural Language Processor set on purposeless chat mode. Feel free to Turing-test me.''',
      user: botic)
];

class _ChatState extends State<Chat> {
  final GlobalKey<DashChatState> _chatViewKey = GlobalKey<DashChatState>();

  Chatbot bot = Chatbot();

  List<ChatMessage> m = [];
  var i = 0;

  void systemMessage() {
    Timer(
      const Duration(milliseconds: 300),
      () {
        if (i < 6) {
          setState(() {
            messages = [...messages, m[i++]];
          });
          i++;
        }
        Timer(
          const Duration(milliseconds: 300),
          () => _chatViewKey.currentState.scrollController
            ..animateTo(
              _chatViewKey
                  .currentState.scrollController.position.maxScrollExtent,
              curve: Curves.easeOut,
              duration: const Duration(milliseconds: 300),
            ),
        );
      },
    );
  }

  void trimite(ChatMessage message) async {
    setState(() {
      messages.add(message);
    });
    var zice = message.text;
    var raspuns = await bot.makeRequest(zice, 'site');
    print(raspuns);
    var mesajBot = ChatMessage(text: raspuns, user: botic);
    setState(() {
      m.add(mesajBot);
      messages.add(mesajBot);
    });

    // if (i == 0) {
    //   systemMessage();
    //   Timer(Duration(milliseconds: 600), () {
    //     systemMessage();
    //   });
    // } else {
    //   systemMessage();
    // }
  }

  @override
  Widget build(BuildContext context) {
    final otherUser = ChatUser(
      name: 'Mrfatty',
      uid: '25649654',
    );

    return SizedBox(
        height: 400,
        width: 600,
        child: DashChat(
            inputCursorColor: Theme.of(context).highlightColor,
            inputContainerStyle:
                BoxDecoration(color: Theme.of(context).cardColor),
            inputDecoration: InputDecoration(
                hoverColor: Theme.of(context).cardColor,
                fillColor: Theme.of(context).cardColor),
            avatarMaxSize: 30,
            inputMaxLines: 1,
            scrollToBottom: true,
            height: 300,
            maxInputLength: 140,
            user: otherUser,
            key: _chatViewKey,
            messages: messages,
            onSend: (message) {
              trimite(message);
            }));
  }
}

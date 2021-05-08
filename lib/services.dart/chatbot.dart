import 'package:http/http.dart' as http;
import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

class Chatbot {
  String url =
      "http://ec2-35-178-211-27.eu-west-2.compute.amazonaws.com:5000/v1/chat";

  Future<String> makeRequest(zice, uid) async {
    var querystring = {"zice": zice};
    Uri uri = Uri.parse(url);
    http.Response resp = await http.get(
      uri.replace(queryParameters: querystring),
    );
    print('What comes back is ${resp.body.split('"')[3]}');
    return resp.body.split('"')[3];
  }
}

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

ChatUser botic = ChatUser(
  name: "Andrei",
  firstName: "Andrei",
  lastName: "Taranu",
  uid: "12345678",
);
List<ChatMessage> messages = [
  ChatMessage(
      text:
          "Hi, I'm the Autonet Natural Language Processor. I only have 41.7 million parameters, so don't expect any utility from me yet, but I am using the mining nodes to grow. Tell me something, anything.",
      user: botic)
];

class _ChatState extends State<Chat> {
  final GlobalKey<DashChatState> _chatViewKey = GlobalKey<DashChatState>();

  Chatbot bot = Chatbot();

  List<ChatMessage> m = [];
  var i = 0;

  void systemMessage() {
    Timer(Duration(milliseconds: 300), () {
      if (i < 6) {
        setState(() {
          messages = [...messages, m[i]];
        });
        i++;
      }
      Timer(Duration(milliseconds: 300), () {
        _chatViewKey.currentState.scrollController
          ..animateTo(
            _chatViewKey.currentState.scrollController.position.maxScrollExtent,
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 300),
          );
      });
    });
  }

  void trimite(ChatMessage message) async {
    setState(() {
      messages.add(message);
      print(messages.length);
    });
    String zice = message.text;
    String raspuns = await bot.makeRequest(zice, "site");
    print(raspuns);
    ChatMessage mesajBot = ChatMessage(text: raspuns, user: botic);
    setState(() {
      messages.add(mesajBot);
    });

    if (i == 0) {
      systemMessage();
      Timer(Duration(milliseconds: 600), () {
        systemMessage();
      });
    } else {
      systemMessage();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ChatUser otherUser = ChatUser(
      name: "Mrfatty",
      uid: "25649654",
    );

    return Container(
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

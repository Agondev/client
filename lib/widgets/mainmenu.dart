import 'package:app2/main.dart';
import 'package:app2/services.dart/chatbot.dart';
import 'package:flutter/material.dart';

class MainMenu extends StatefulWidget {
  Chat chat = Chat();
  MyAppState appstate;
  String care;
  Widget porc;
  MainMenu({this.porc, this.appstate, this.care});
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton:
            ChatWidget(chat: widget.chat),
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(38.0),
            child: AppBar(
                automaticallyImplyLeading: false,
                elevation: 1.5,
                actions: [
                  Row(children: [
                    Icon(
                      Icons.wb_sunny,
                      color: Theme.of(context).primaryColorLight,
                    ),
                    Switch(
                        value: widget.appstate.lumina,
                        onChanged: (context) {
                          widget.appstate.bypass = true;
                          widget.appstate.lumina
                              ? widget.appstate.setState(() {
                                  widget.appstate.lumina = false;
                                })
                              : widget.appstate.setState(() {
                                  widget.appstate.lumina = true;
                                });
                        })
                  ])
                ],
                title: Row(children: [
                  SizedBox(
                      height: 38,
                      width: 145,
                      child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed("/home");
                          },
                          child: Opacity(
                            opacity: widget.care == "landing" ? 0.9 : 0.6,
                            child: Image.network(
                              widget.appstate.lumina
                                  ? "https://i.ibb.co/Zgw89rQ/logo-normal.png"
                                  : "https://i.ibb.co/PZcWWsD/logo-white.png",
                              height: 19,
                            ),
                          ))),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                      height: 38,
                      width: 130,
                      child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed("/market");
                            setState(() {
                              widget.care = "market";
                            });
//                              showDialog(
//                       context: context,
//                       builder: (context) => AlertDialog(
//                           content: Container(width:300,height:300,child:
//                        Center(child:    Column(
//                          crossAxisAlignment: CrossAxisAlignment.center,
//                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
// Text("Soon...",style:TextStyle(fontSize: 27)), 
// Text("We've waited for so long, we can wait a bit longer. Help is on the way.")
//                           ],)
//                          ))));
                          },
                          child: Text("MARKET",
                              style: TextStyle(
                                  fontWeight: widget.care == "market"
                                      ? FontWeight.bold
                                      : FontWeight.w100,
                                  fontSize: widget.care == "market" ? 17 : 16,
                                  fontFamily: "Roboto Mono",
                                  letterSpacing: 3)))),
                  SizedBox(
                      height: 38,
                      width: 130,
                      child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed("/assets");
                            setState(() {
                              widget.care = "assets";
                            });
//                             showDialog(
//                       context: context,
//                       builder: (context) => AlertDialog(
//                           content: Container(width:300,height:300,child:
//                        Center(child:    Column(
//                          crossAxisAlignment: CrossAxisAlignment.center,
//                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
// Text("Soon...",style:TextStyle(fontSize: 27)), 
// Text("We've waited for so long, we can wait a bit longer. Help is on the way.")
//                           ],)
//                          ))));
                          },
                          child: Text("MY ASSETS",
                              style: TextStyle(
                                  fontSize: widget.care == "assets" ? 17 : 16,
                                  fontWeight: widget.care == "assets"
                                      ? FontWeight.bold
                                      : FontWeight.w100,
                                  fontFamily: "Roboto Mono",
                                  letterSpacing: 1.3)))),
                  SizedBox(
                      height: 38,
                      width: 130,
                      child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed("/node");
                            setState(() {
                              widget.care = "node";
                            });
//                              showDialog(
//                       context: context,
//                       builder: (context) => AlertDialog(
//                           content: Container(width:300,height:300,child:
//                        Center(child:    Column(
//                          crossAxisAlignment: CrossAxisAlignment.center,
//                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
// Text("Soon...",style:TextStyle(fontSize: 27)), 
// Text("We've waited for so long, we can wait a bit longer. Help is on the way.")
//                           ],)
//                          ))));
                          },
                          child: Text("NODE",
                              style: TextStyle(
                                  fontWeight: widget.care == "node"
                                      ? FontWeight.bold
                                      : FontWeight.w100,
                                  fontSize: widget.care == "node" ? 17 : 16,
                                  fontFamily: "Roboto Mono",
                                  letterSpacing: 2)))),
                ]))),
        body: widget.porc);
  }
}

class ChatWidget extends StatefulWidget {
  Chat chat;
  ChatWidget({this.chat});
  bool expanded = false;
  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  double height;
  double width;
  @override
  void initState() {
    widget.expanded = false;
    height = 70;
    width = 70;
    super.initState();
  }

  expand() {
    setState(() {
      height = MediaQuery.of(context).size.height - 18;
      width = 500;
      widget.expanded = true;
    });
  }

  compact() {
    setState(() {
      height = 70;
      width = 70;
      widget.expanded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        height: height,
        duration: Duration(milliseconds: 300),
        child: widget.expanded ? big() : chatBtn());
  }

  Widget big() {
    return Container(
      height: MediaQuery.of(context).size.height - 18,
      width: 500,
      child: Stack(children: [
        Positioned(
            bottom: 83,
            right: 0,
            child: AnimatedContainer(
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  border: Border.all(
                      color: Theme.of(context).cardColor, width: 1.5),
                ),
                duration: Duration(milliseconds: 300),
                height: height,
                width: width,
                child: widget.chat)),
        Positioned(bottom: 5, right: 3, child: chatBtn())
      ]),
    );
  }

  Widget chatBtn() {
    return Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Theme.of(context).backgroundColor,
            blurRadius: 5.0, // soften the shadow
            spreadRadius: 2, //extend the shadow
            offset: Offset(
              0,
              0,
            ),
          )
        ], borderRadius: BorderRadius.all(Radius.circular(50))),
        child: TextButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ))),
          onPressed: () {
            widget.expanded ? compact() : expand();
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
                "https://i.ibb.co/0n1c7ry/ezgif-com-gif-maker-1.gif"),
          ),
        ));
  }
}

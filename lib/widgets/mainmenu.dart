import 'package:app2/main.dart';
import 'package:flutter/material.dart';

class MainMenu extends StatefulWidget {
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
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(38.0), // here the desired height
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

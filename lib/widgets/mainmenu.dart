import 'package:app2/main.dart';
import 'package:flutter/material.dart';

class MainMenu extends StatefulWidget {
  MyAppState appstate;
  Widget porc;
  MainMenu({this.porc, this.appstate});
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
                elevation: 2,
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
                          onPressed: () {},
                          child: Opacity(
                            opacity: 0.7,
                            child: Image.network(
                              widget.appstate.lumina
                                  ? "https://i.ibb.co/Zgw89rQ/logo-normal.png"
                                  : "https://i.ibb.co/PZcWWsD/logo-white.png",
                              height: 20,
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
                          },
                          child: Text("MARKET",
                              style: TextStyle(
                                  fontFamily: "OCR-A", letterSpacing: 3)))),
                  SizedBox(
                      height: 38,
                      width: 130,
                      child: TextButton(
                          onPressed: () {},
                          child: Text("MY ASSETS",
                              style: TextStyle(
                                  fontFamily: "OCR-A", letterSpacing: 2)))),
                ]))),
        body: widget.porc);
  }
}

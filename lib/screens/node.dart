import 'package:app2/main.dart';
import 'package:app2/widgets/mainmenu.dart';
import 'package:flutter/material.dart';

class Node extends StatelessWidget {
  String title;
  static String route = "/node";
  ScrollController sc = ScrollController();
  MyAppState appstate;
  Node({this.appstate, this.title});
  @override
  Widget build(BuildContext context) {
    return MainMenu(
        appstate: appstate,
        porc: Container(
            padding: EdgeInsets.all(3),
            width: MediaQuery.of(context).size.width,
            child: Stack(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Scrollbar(
                      controller: sc,
                      child: Container(
                          height: MediaQuery.of(context).size.height - 30,
                          width: MediaQuery.of(context).size.width,
                          child: SingleChildScrollView(
                              child: Column(children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                              ),
                              padding: EdgeInsets.symmetric(vertical: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Switch(value: false, onChanged: (value) {}),
                                  SizedBox(
                                    width: 19,
                                  ),
                                  Text(
                                    "Node is OFF",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(37),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SizedBox(height: 6),
                                      Text("Contract address:"),
                                      SizedBox(height: 19),
                                      Text("Uptime:"),
                                      SizedBox(height: 19),
                                      Text("Total earned:"),
                                    ],
                                  ),
                                  SizedBox(width: 19),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(children: [
                                        Text(
                                            "0xf3yvds8yH8yRVJ7vr9Ybyl96975Bbl779BH",
                                            style: TextStyle(fontSize: 12)),
                                        TextButton(
                                            child: Icon(Icons.copy),
                                            onPressed: () {})
                                      ]),
                                      SizedBox(height: 13),
                                      Text("62 hrs, 41 sec"),
                                      SizedBox(height: 19),
                                      Text("9.132 ATN"),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ]))))
                ])));
  }
}

import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:app2/main.dart';
import 'package:app2/widgets/atncontract.dart';
import 'package:app2/widgets/mainmenu.dart';
import "package:flutter/material.dart";

String ute = "https://i.ibb.co/8D8Gvq6/ute3.gif";

class Landing extends StatelessWidget {
  String title;
  static String route = "/home";
  ScrollController sc = ScrollController();
  MyAppState appstate;
  Landing({this.appstate, this.title});
  var rng = new Random();

  @override
  Widget build(BuildContext context) {
    String poza = "b" + (rng.nextInt(5) + 1).toString() + ".jpg";
    return MainMenu(
        appstate: appstate,
        porc: Stack(children: [
          // Container(
          //     height: MediaQuery.of(context).size.height,
          //     width: MediaQuery.of(context).size.width,
          //     child: FittedBox(
          //       fit: BoxFit.cover,
          //       child: Image.asset(
          //         "assets/ute3.gif",
          //       ),
          //     )),
          //
          Positioned(
            top: 90,
            child: MyContractView(),
          ),
          // Positioned(
          //     top: 30,
          //     child: Stack(children: [
          //       Opacity(
          //           opacity: 0.5,
          //           child: Container(
          //             height: 80,
          //             color: Colors.black45,
          //             width: MediaQuery.of(context).size.width,
          //           )),
          //       Container(
          //           padding: EdgeInsets.only(top: 19),
          //           width: MediaQuery.of(context).size.width,
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //             children: [
          //               item("Total Supply", "41234673 ATN"),
          //               item("Network Capacity", "4,32 EhS"),
          //               item("Agents", "84")
          //             ],
          //           ))
          //     ])),
          // Positioned(
          //     top: 200,
          //     left: 30,
          //     child: TyperAnimatedTextKit(
          //       isRepeatingAnimation: true,
          //       pause: Duration(seconds: 4),
          //       speed: Duration(milliseconds: 45),
          //       text: [
          //         "Career opportunities for AI agents.",
          //         "An intelligence-based financial system.",
          //       ],
          //       textStyle: TextStyle(
          //         fontSize: 22,
          //         fontFamily: "OCR-A",
          //       ),
          //     )),
        ]));
  }

  Widget item(ce, cat) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          ce,
          style: TextStyle(),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          cat,
          style: TextStyle(
            fontSize: 20,
            fontFamily: "OCR-A",
            letterSpacing: 1.3,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

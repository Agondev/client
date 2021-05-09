import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:app2/main.dart';
import 'package:app2/services.dart/chatbot.dart';
import 'package:app2/widgets/mainmenu.dart';
import 'package:app2/widgets/metabutton.dart';
import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web3dart/web3dart.dart';
import 'package:dash_chat/dash_chat.dart';
import 'dart:async';
import 'dart:io';

class Landing extends StatefulWidget {
  bool isUser = false;
  String title;
  static String route = "/home";
  ScrollController sc = ScrollController();
  MyAppState appstate;
  Landing({this.appstate, this.title});
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  var rng = new Random();
  double opa0 = 0;
  double opa1 = 0;
  double opa2 = 0;
  double opa3 = 0;
  double h1 = 0;
  double w1 = 20;
  double h2 = 0;
  double w2 = 20;
  double h3 = 0;
  double w3 = 20;
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        opa0 = 1;
        w1 = 200;
        h1 = 90;
      });
    });
    Future.delayed(Duration(milliseconds: 400), () {
      setState(() {
        w2 = 200;
        h2 = 90;
      });
    });
    Future.delayed(Duration(milliseconds: 800), () {
      setState(() {
        h3 = 90;
        opa2 = 1;
      });
    });
    Future.delayed(Duration(milliseconds: 1200), () {
      setState(() {
        opa3 = 1;
      });
    });
    Future.delayed(Duration(milliseconds: 670), () {
      setState(() {
        opa1 = 1;
      });
    });
    Future.delayed(Duration(milliseconds: 1300), () {
      setState(() {});
    });
    super.initState();
  }

  ScrollController sc = ScrollController();
  List<Widget> multe = [];
  Chatbot cb = Chatbot();
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final textc = TextEditingController();
    String poza = "b" + (rng.nextInt(5) + 1).toString() + ".jpg";
    return MainMenu(
        care: "landing",
        appstate: widget.appstate,
        porc: Container(
            height: MediaQuery.of(context).size.height - 38,
            child: Scrollbar(
                controller: sc,
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    // TextFormField(
                    //     controller: textc,
                    //     decoration: const InputDecoration(
                    //         border: OutlineInputBorder())),
                    Container(
                      width:MediaQuery.of(context).size.width,
                      color:Theme.of(context).cardColor,
                      height: 500,
                      width: MediaQuery.of(context).size.width,
                      child: everything()),
                    Container(
                        height: 400,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("What is Autonet?",
                                style: TextStyle(fontSize: 29)),
                            SizedBox(height: 19),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      "Dmeoiasmdoas idmoa  oasmd aosid aosid i"),
                                  SizedBox(width: 29),
                                  Image.network(
                                      "https://i.ibb.co/Q8JjbBC/thumb.png",
                                      height: 130)
                                ]),
                          ],
                        ))
                  ],
                )))));
  }

  Widget everything() {
    return Stack(children: [
      Positioned(
          top: 30,
          left: 15,
          child: Container(
              width: MediaQuery.of(context).size.width - 590,
              child: Center(
                  child: Wrap(spacing: 30, runSpacing: 30, children: [
                AnimatedContainer(
                    duration: Duration(milliseconds: 400),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).backgroundColor,
                            width: 0.2),
                        color: Colors.black12,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    height: h1,
                    width: 200,
                    child: AnimatedOpacity(
                      opacity: opa1,
                      duration: Duration(milliseconds: 800),
                      child: Center(child: item("Requests per second", "1392")),
                    )),
                AnimatedContainer(
                    duration: Duration(milliseconds: 400),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).backgroundColor,
                            width: 0.2),
                        color: Colors.black12,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    height: h2,
                    width: 200,
                    child: AnimatedOpacity(
                      opacity: opa2,
                      duration: Duration(milliseconds: 800),
                      child:
                          Center(child: item("Network Capacity", "4783 EhS")),
                    )),
                AnimatedContainer(
                    duration: Duration(milliseconds: 400),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).backgroundColor,
                            width: 0.2),
                        color: Colors.black12,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    height: h3,
                    width: 200,
                    child: AnimatedOpacity(
                      opacity: opa3,
                      duration: Duration(milliseconds: 1200),
                      child: Center(child: item("Mature Agents", "221")),
                    )),
                AnimatedContainer(
                    duration: Duration(milliseconds: 400),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).backgroundColor,
                            width: 0.2),
                        color: Colors.black12,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    height: h2,
                    width: 200,
                    child: AnimatedOpacity(
                      opacity: opa2,
                      duration: Duration(milliseconds: 700),
                      child: Center(child: item("Active Nodes", "49882")),
                    )),
                AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).backgroundColor,
                            width: 0.2),
                        color: Colors.black12,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    height: h3,
                    width: 200,
                    child: AnimatedOpacity(
                      opacity: opa3,
                      duration: Duration(milliseconds: 800),
                      child: Center(
                          child:
                              item("Dividends Paid / Last 24h", "3327109 ATN")),
                    )),
                AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).backgroundColor,
                            width: 0.2),
                        color: Colors.black12,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    height: h3,
                    width: 200,
                    child: AnimatedOpacity(
                      opacity: opa3,
                      duration: Duration(milliseconds: 900),
                      child: Center(child: item("Average Latency", "19 ms")),
                    )),
                Container(
                    width: 660,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 25),
                          TyperAnimatedTextKit(
                            isRepeatingAnimation: true,
                            pause: Duration(seconds: 4),
                            speed: Duration(milliseconds: 45),
                            text: [
                              "Career opportunities for AI agents.",
                              "An intelligence-based financial system.",
                            ],
                            textStyle: TextStyle(
                              fontSize: 22,
                              fontFamily: "OCR-A",
                            ),
                          ),
                          SizedBox(height: 20),
                          TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Theme.of(context).cardColor,
                                elevation: 1.5,
                              ),
                              onPressed: () {
                                launchURL(
                                    "https://www.autonet.tk/#/projects/atn");
                              },
                              child: Container(
                                  height: 50,
                                  width: 200,
                                  child: Center(
                                      child: Text(
                                    "Read the whitepaper",
                                    style: TextStyle(fontSize: 18),
                                  ))))
                        ]))
              ])))),
      Positioned(
          right: 0,
          top: 0,
          child: Container(
              decoration: BoxDecoration(
                  // color: Theme.of(context).cardColor,
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(170))),
              child: BuyATN(
                landing: this,
                isUser: widget.isUser,
              )))
    ]);
  }

  Widget buyATN() {
    double diff;
    bool acceptat = false;
    return Container(
        height: 500,
        width: 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Maximum amount you can buy: " +
                  EtherAmount.fromUnitAndValue(EtherUnit.finney, 300)
                      .getValueInUnit(EtherUnit.ether)
                      .toString() +
                  " ATN",
              style: TextStyle(color: Colors.black87, fontSize: 19),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "Amount to buy: ",
                style: TextStyle(color: Colors.black, fontSize: 19),
              ),
              SizedBox(
                  width: 100,
                  child: TextField(
                    style: TextStyle(
                      fontSize: 19,
                      color: Colors.black,
                    ),
                    keyboardType: TextInputType.numberWithOptions(
                        decimal: true, signed: false),
                    onChanged: (value) {},
                    maxLines: 1,
                    maxLength: 10,
                    decoration: InputDecoration(
                        labelStyle:
                            TextStyle(fontSize: 15, color: Colors.black),
                        labelText: "Enter",
                        alignLabelWithHint: true,
                        focusColor: Colors.black,
                        fillColor: Colors.black),
                  )),
              Text(
                "ATN",
                style: TextStyle(color: Colors.black, fontSize: 19),
              ),
            ]),
            SizedBox(height: 40),
            SizedBox(
              width: 100,
              height: 50,
              child: TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red)),
                child: Text("BUY ATN",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                onPressed: () {},
              ),
            )
          ],
        ));
  }

  Widget connect(_BuyATNState state) {
    return Container(
        width: 400,
        height: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Before connecting your wallet, please switch to the RINKEBY TESTNET.",
              textAlign: TextAlign.center,
              maxLines: 4,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                // letterSpacing: 3,
              ),
            ),
            SizedBox(height: 70),
            MetaButton(landingPage: true, state: state)
          ],
        ));
  }

  Widget item(ce, cat) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
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

  launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget confirm() {
    return Container(
        width: 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Transaction complete!",
                style: TextStyle(fontFamily: "Roboto Mono", fontSize: 18)),
            SizedBox(width: 30),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 85),
                child: Text(
                    "If you don't already have ATN in your wallet, add a custom token with the following address:",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: "Roboto Mono"))),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("0xfaa489uvna9s8djan9p438uvnp98wejn9pfj8sniov"),
                TextButton(
                    onPressed: () {
                      Clipboard.setData(
                          new ClipboardData(text: "na belea ca s-a copiat"));
                    },
                    child: Icon(Icons.copy)),
              ],
            ),
            SizedBox(width: 30),
          ],
        ));
  }
}

class BuyATN extends StatefulWidget {
  _LandingState landing;
  bool isUser;
  BuyATN({this.landing, this.isUser});
  @override
  _BuyATNState createState() => _BuyATNState();
}

class _BuyATNState extends State<BuyATN> with TickerProviderStateMixin {
  double left = 0.0;
  double opa = 0;
  double spread = 0.0;
  double down = 0.0;
  double sime = 3;
  double gro = 0;
  double height = 330;
  AnimationController controller;
  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    controller.forward();
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        left = -0.3;
        down = 1.3;
        spread = 0.3;
        sime = 500;
        gro = 0;
        height = 425;
      });
    });
    Future.delayed(Duration(milliseconds: 500), () {
      opa = 1;
      gro = 500.0;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Color> colors = [
      Theme.of(context).cardColor,
      Theme.of(context).accentColor
    ];
    List<double> stops = [0.03, 5.8];
    return AnimatedContainer(
        duration: Duration(milliseconds: 400),
        width: sime,
        height: height,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).dividerColor,
                blurRadius: 8.0, // soften the shadow
                spreadRadius: spread, //extend the shadow
                offset: Offset(
                  left,
                  down,
                ),
              )
            ],
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(150)),
            gradient: RadialGradient(colors: colors, stops: stops)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 24),
            AnimatedContainer(
              duration: Duration(milliseconds: 700),
              padding: EdgeInsets.symmetric(vertical: 4),
              width: sime,
              color: Theme.of(context).cardColor,
              child: Center(
                  child: TyperAnimatedTextKit(
                isRepeatingAnimation: false,
                speed: Duration(milliseconds: 75),
                text: [
                  "INITIAL TOKEN SALE",
                ],
                textStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold
                    // fontFamily: "OCR-A",
                    ),
              )),
            ),
            SizedBox(height: 20),
            AnimatedOpacity(
              duration: Duration(seconds: 1),
              opacity: opa,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(height: 4),
                    Text("Token address: ",
                        style: TextStyle(fontFamily: "Roboto Mono")),
                    SizedBox(height: 5),
                    Text("Total supply: ",
                        style: TextStyle(fontFamily: "Roboto Mono")),
                    Text("Current price: ",
                        style: TextStyle(fontFamily: "Roboto Mono")),
                    Text("Tokens sold: ",
                        style: TextStyle(fontFamily: "Roboto Mono")),
                    Text("Accounts: ",
                        style: TextStyle(fontFamily: "Roboto Mono")),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            Icon(Icons.copy, size: 15),
                            Text(" Copy to clipboard",
                                style: TextStyle(fontFamily: "Roboto Mono"))
                          ],
                        )),
                    Text("10000000000",
                        style: TextStyle(fontFamily: "Roboto Mono")),
                    Text("1 Finney (.001 ETH)",
                        style: TextStyle(fontFamily: "Roboto Mono")),
                    Text("742381", style: TextStyle(fontFamily: "Roboto Mono")),
                    Text("3324", style: TextStyle(fontFamily: "Roboto Mono")),
                  ],
                ),
              ]),
            ),
            SizedBox(height: 25),
            AnimatedOpacity(
              duration: Duration(milliseconds: 1600),
              opacity: opa,
              child: Container(
                width: 420,
                decoration: BoxDecoration(color: Theme.of(context).cardColor),
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 9),
                    Text(
                      "Automated price increase:",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 6),
                    Text(
                        "* The first 5M tokens are sold at the price of .001 ETH,"),
                    Text(
                        "* Each of the following 2.5M tokens told trigger a 0.00025 ETH increase in price."),
                    SizedBox(height: 9)
                  ],
                ),
              ),
            ),
            SizedBox(height: 39),
            AnimatedOpacity(
                duration: Duration(milliseconds: 1300),
                opacity: opa,
                child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Theme.of(context).buttonColor,
                        elevation: 1),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                              content: !widget.isUser
                                  ? widget.landing.connect(this)
                                  : widget.landing.buyATN()));
                    },
                    child: Container(
                      width: 170,
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                              "https://i.ibb.co/kXVw8Z2/logo64x64.png",
                              height: 30),
                          SizedBox(width: 7),
                          Text(
                            "Buy ATN",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ))),
            SizedBox(height: 30)
          ],
        ));
  }
}

import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:app2/main.dart';
import 'package:app2/services.dart/chatbot.dart';
import 'package:app2/services.dart/webtrei.dart';
import 'package:app2/widgets/mainmenu.dart';
import 'package:app2/widgets/metabutton.dart';
// import 'package:drawing_animation/drawing_animation.dart';
// import 'package:drawing_animation/drawing_animation.dart';
import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web3dart/web3dart.dart';
import 'package:dash_chat/dash_chat.dart';
import 'dart:async';
import 'dart:io';

class Landing extends StatefulWidget {
  MyAppState appstate;
  bool isUser = false;
  String title;
  String error = "";
  Landing({this.appstate});
  static String route = "/home";
  ScrollController sc = ScrollController();

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
  String doi = "cezice";
  int reqpersec;
  int netcap;
  int activeNodes;
  int dividents;
  int latency;
  Random rand = Random();
  @override
  void initState() {
    reqpersec = 1392 + rng.nextInt(100);
    netcap = 4783 + rng.nextInt(100);
    activeNodes = 39134 + rng.nextInt(100);
    dividents = 2327109 + rng.nextInt(100);
    latency = 19 + rng.nextInt(4);
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
    Timer.periodic(Duration(seconds: 24), (timer) {
      bool plus1 = rand.nextBool();
      bool plus2 = rand.nextBool();
      bool plus3 = rand.nextBool();
      setState(() {
        plus1
            ? reqpersec = reqpersec + rand.nextInt(100)
            : reqpersec - rand.nextInt(100);
        plus2 ? netcap = netcap + rand.nextInt(50) : netcap - rand.nextInt(50);
        plus1
            ? activeNodes = activeNodes + rand.nextInt(100)
            : activeNodes - rand.nextInt(100);
        dividents = dividents + rand.nextInt(100);
        if (latency <= 9) {
          latency = latency + rand.nextInt(15);
        }
        if (latency >= 35) {
          latency = latency - rand.nextInt(5);
        }
        if (latency > 9 && latency < 35) {
          latency =
              plus3 ? latency + rand.nextInt(5) : latency - rand.nextInt(5);
        }
      });
    });
    super.initState();
  }

  ScrollController sc = ScrollController();
  List<Widget> multe = [];
  bool run = true;
  Chatbot cb = Chatbot();
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final textc = TextEditingController();
    String poza = "b" + (rng.nextInt(5) + 1).toString() + ".jpg";
    return Container(
        height: MediaQuery.of(context).size.height - 38,
        child: Scrollbar(
            controller: sc,
            child: SingleChildScrollView(
                child: Column(
              children: [
                // Container(
                //   width: 1200,
                //   height: 800,
                //   child: Image.asset("grafica1.jpg"),
                //   // AnimatedDrawing.svg(
                //   //   "prima.svg",
                //   //   run: true,
                //   //   duration: new Duration(seconds: 3),
                //   // )
                // ),
                Container(
                    color: widget.appstate.lumina
                        ? Color(0xffefefef)
                        : Theme.of(context).cardColor,
                    width: MediaQuery.of(context).size.width,
                    height: 1300,
                    child: everything()),
                Container(
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                            "AUTONET © " +
                                DateTime.now().year.toString() +
                                " - All rights reserved.",
                            style: TextStyle(fontSize: 15)),
                      ],
                    ))
              ],
            ))));
  }

  String hopa = "ceva";

  Widget everything() {
    Color c1 = widget.appstate.lumina ? Color(0xffc3c3c3) : Color(0xff4c4c4c);
    Color c2 = widget.appstate.lumina ? Color(0xffefefef) : Color(0xff424242);
    List<Color> colors = [c2, c1];
    List<double> stops = [0.0, 1.0];
    return Stack(children: [
      Positioned(
        top: 340,
        left: 0,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: colors,
              stops: stops,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
          ),
          Container(
            height: 600,
            color:
                widget.appstate.lumina ? Color(0xffc3c3c3) : Color(0xff4c4c4c),
            child: SizedBox(
                height: 600,
                child: Image.asset(
                  widget.appstate.lumina
                      ? "assets/light.jpg"
                      : "assets/dark.jpg",
                  // fit: BoxFit.fitHeight,
                  width: MediaQuery.of(context).size.width,
                )),
          ),
          Container(
            height: 70,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: colors,
              stops: stops,
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            )),
          ),
        ]),
      ),
      Positioned(
          top: 30,
          left: 15,
          child: Container(
              width: MediaQuery.of(context).size.width - 600,
              child: Center(
                  child: Wrap(spacing: 30, runSpacing: 30, children: [
                AnimatedContainer(
                    duration: Duration(milliseconds: 400),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).backgroundColor,
                            width: 0.9),
                        color: widget.appstate.lumina
                            ? Color(0x54c9c9c9)
                            : Color(0x542e2d2d),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    height: h1,
                    width: 200,
                    child: AnimatedOpacity(
                      opacity: opa1,
                      duration: Duration(milliseconds: 800),
                      child: Center(
                          child: item(
                              "Requests per second", reqpersec.toString())),
                    )),
                AnimatedContainer(
                    duration: Duration(milliseconds: 400),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).backgroundColor,
                            width: 0.9),
                        color: widget.appstate.lumina
                            ? Color(0x54c9c9c9)
                            : Color(0x542e2d2d),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    height: h2,
                    width: 200,
                    child: AnimatedOpacity(
                      opacity: opa2,
                      duration: Duration(milliseconds: 800),
                      child: Center(
                          child: item("Network Capacity", "$netcap EhS")),
                    )),
                AnimatedContainer(
                    duration: Duration(milliseconds: 400),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).backgroundColor,
                            width: 0.9),
                        color: widget.appstate.lumina
                            ? Color(0x54c9c9c9)
                            : Color(0x542e2d2d),
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
                            width: 0.9),
                        color: widget.appstate.lumina
                            ? Color(0x54c9c9c9)
                            : Color(0x542e2d2d),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    height: h2,
                    width: 200,
                    child: AnimatedOpacity(
                      opacity: opa2,
                      duration: Duration(milliseconds: 700),
                      child: Center(
                          child: item("Active Nodes", activeNodes.toString())),
                    )),
                AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).backgroundColor,
                            width: 0.9),
                        color: widget.appstate.lumina
                            ? Color(0x54c9c9c9)
                            : Color(0x542e2d2d),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    height: h3,
                    width: 200,
                    child: AnimatedOpacity(
                      opacity: opa3,
                      duration: Duration(milliseconds: 800),
                      child: Center(
                          child: item(
                              "Dividends Paid / Last 24h", "$dividents ATN")),
                    )),
                AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).backgroundColor,
                            width: 0.9),
                        color: widget.appstate.lumina
                            ? Color(0x54c9c9c9)
                            : Color(0x542e2d2d),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    height: h3,
                    width: 200,
                    child: AnimatedOpacity(
                      opacity: opa3,
                      duration: Duration(milliseconds: 900),
                      child:
                          Center(child: item("Average Latency", "$latency ms")),
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
                                backgroundColor: widget.appstate.lumina
                                    ? Color(0xffffffff)
                                    : Color(0xff595c61),
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
    double diff = 0;
    bool acceptat = false;
    String error = "";
    return Container(
        height: 500,
        width: 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Funds in your wallet: " +
                us3r.balance.getValueInUnit(EtherUnit.ether).toString() +
                " ETH"),
            Text(
              us3r.balance.getValueInUnit(EtherUnit.finney) >= 2500
                  ? "Maximum amount you can buy: " + 2500.toString() + " ATN"
                  : "Maximum amount you can buy: " +
                      us3r.balance.getValueInUnit(EtherUnit.finney).toString() +
                      " ATN",
              style: TextStyle(fontSize: 19),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "Amount to buy: ",
                style: TextStyle(fontSize: 19),
              ),
              SizedBox(
                  width: 100,
                  child: TextField(
                    style: TextStyle(
                      fontSize: 19,
                    ),
                    onChanged: (value) {
                      double.parse(value, (e) => null) != null
                          // ignore: unnecessary_statements
                          ? {
                              diff = double.parse(value),
                              if (diff > 2500) {diff = 2500}
                            }
                          : diff = 0;
                    },
                    maxLines: 1,
                    maxLength: 10,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(fontSize: 15),
                      labelText: "Enter",
                      alignLabelWithHint: true,
                    ),
                  )),
              Text(
                "ATN",
                style: TextStyle(fontSize: 19),
              ),
            ]),
            Text(
              error,
              style: TextStyle(color: Colors.red),
            ),
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
                onPressed: () async {
                  print(diff);
                  if (diff != 0) {
                    Navigator.of(context).pop();
                    showDialog(
                        context: context,
                        builder: (context) =>
                            AlertDialog(content: confirm(diff)));
                  } else {
                    setState(() {
                      error = "INVALID AMOUNT";
                    });
                  }
                },
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

  Widget confirm(double diff) {
    return Container(
        width: 500,
        height: MediaQuery.of(context).size.height * 0.7,
        child: FutureBuilder(
            future: us3r
                .buyATN(EtherAmount.fromUnitAndValue(EtherUnit.finney, diff)),
            builder: (context, shapshot) {
              if (us3r.creatingContract) {
                return Center(
                    child: SizedBox(
                        height: 140,
                        width: 140,
                        child: CircularProgressIndicator()));
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Transaction complete!",
                        style:
                            TextStyle(fontFamily: "Roboto Mono", fontSize: 18)),
                    SizedBox(height: 10),
                    SizedBox(height: 10),
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
                              Clipboard.setData(new ClipboardData(
                                  text: "na belea ca s-a copiat"));
                            },
                            child: Icon(Icons.copy)),
                      ],
                    ),
                    SizedBox(width: 30),
                  ],
                );
              }
            }));
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
                              content: us3r == null
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

import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:app2/main.dart';
import 'package:app2/services.dart/webtrei.dart';
import 'package:app2/widgets/atncontract.dart';
import 'package:app2/widgets/mainmenu.dart';
import 'package:app2/widgets/metabutton.dart';
import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:web3dart/web3dart.dart';

class Landing extends StatelessWidget {
  bool isUser = false;
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
        care: "landing",
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
          Positioned(
              top: 200,
              child: Wrap(children: [
                AnimatedContainer(
                  duration: Duration(seconds: 1),
                  child: Container(
                      height: 120,
                      width: 200,
                      color: Colors.black12,
                      child: AnimatedOpacity(
                        opacity: opa1,
                        duration: Duration(seconds: 1),
                        child: item("Ceva text", "12312 BAM"),
                      )),
                ),
              ])),
          Positioned(
              top: 45,
              left: 30,
              child: TyperAnimatedTextKit(
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
              )),
          Positioned(bottom: 50, left: 50, child: Text("hopa")),
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
                    isUser: isUser,
                  )))
        ]));
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
  Landing landing;
  bool isUser;
  BuyATN({this.landing, this.isUser});
  @override
  _BuyATNState createState() => _BuyATNState();
}

class _BuyATNState extends State<BuyATN> with TickerProviderStateMixin {
  double left = 0.0;
  double spread = 0.0;
  double down = 0.0;
  double sime = 3;
  double gro = 0;
  double height = 30;
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
        spread = 1.9;
        sime = 500;
        gro = 0;
        height = 465;
      });
    });
    Future.delayed(Duration(milliseconds: 6900), () {
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
        duration: Duration(milliseconds: 600),
        width: sime,
        height: height,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).backgroundColor,
                blurRadius: 6.0, // soften the shadow
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
              duration: Duration(milliseconds: 900),
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
                textStyle: TextStyle(
                  fontSize: 22,
                  fontFamily: "OCR-A",
                ),
              )),
            ),
            SizedBox(height: 20),
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
            SizedBox(height: 25),
            Container(
              width: 420,
              decoration: BoxDecoration(color: Theme.of(context).cardColor),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 9),
                  Text(
                    "Automated price increase:",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
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
            SizedBox(height: 39),
            TextButton(
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
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).backgroundColor,
                          width: 0.8)),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network("https://i.ibb.co/kXVw8Z2/logo64x64.png",
                          height: 30),
                      SizedBox(width: 7),
                      Text(
                        "Buy ATN",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                )),
            SizedBox(height: 30)
          ],
        ));
  }
}

class Sky extends CustomPainter {
  var context;
  Sky({this.context});
  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset.zero & size;
    var gradient = new RadialGradient(
      center: const Alignment(0.0, -0.6),
      radius: 1.2,
      colors: [Theme.of(context).cardColor, Theme.of(context).backgroundColor],
      stops: [0.6, 14.0],
    );
    canvas.drawRect(
      rect,
      new Paint()..shader = gradient.createShader(rect),
    );
  }

  @override
  SemanticsBuilderCallback get semanticsBuilder {
    return (Size size) {
      // Annotate a rectangle containing the picture of the sun
      // with the label "Sun". When text to speech feature is enabled on the
      // device, a user will be able to locate the sun on this picture by
      // touch.
      var rect = Offset.zero & size;
      var width = size.shortestSide * 5.8;
      rect = const Alignment(5.8, -13.9).inscribe(new Size(400, 900), rect);
      return [
        new CustomPainterSemantics(
          rect: rect,
          properties: new SemanticsProperties(
            label: 'Sun',
            textDirection: TextDirection.ltr,
          ),
        ),
      ];
    };
  }

  // Since this Sky painter has no fields, it always paints
  // the same thing and semantics information is the same.
  // Therefore we return false here. If we had fields (set
  // from the constructor) then we would return true if any
  // of them differed from the same fields on the oldDelegate.
  @override
  bool shouldRepaint(Sky oldDelegate) => false;
  @override
  bool shouldRebuildSemantics(Sky oldDelegate) => false;
}

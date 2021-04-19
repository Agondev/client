import 'dart:ui';

import 'package:app2/contracts/project.dart';
import 'package:app2/contracts/source.dart';
import 'package:app2/screens/projectview.dart';
import 'package:app2/services.dart/chain.dart';
import 'package:app2/widgets/agent_card.dart';
import 'package:app2/widgets/agent_details.dart';
import 'package:app2/widgets/mainmenu.dart';
import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';

Chain chain = new Chain();
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }

  bool lumina = false;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeData light = ThemeData(
      brightness: Brightness.light,
      primaryColor: createMaterialColor(Color(0xffefefef)),
      primarySwatch: createMaterialColor(Color(0xff4d4d4d)),
      highlightColor: Color(0xff6e6e6e),
    );
    ThemeData dark = ThemeData(
      brightness: Brightness.dark,
      primaryColor: createMaterialColor(Color(0xff4d4d4d)),
      primarySwatch: createMaterialColor(Color(0xffefefef)),
      highlightColor: Color(0xff6e6e6e),
    );

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          ProjectView.route: (context) => ProjectView(
                appstate: this,
              ),
          Market.route: (context) => Market(
                appstate: this,
              ),
        },
        title: 'Autonet',
        theme: lumina ? light : dark,
        home: Market(title: 'AUTONET', appstate: this));
  }
}

// ignore: must_be_immutable
class Market extends StatefulWidget {
  static String route = "/market";
  Market({Key key, this.title, this.appstate}) : super(key: key);
  final String title;
  MyAppState appstate;
  @override
  _MarketState createState() => _MarketState();
}

class _MarketState extends State<Market> {
  var apiUrl = "https://rinkeby.infura.io/v3/e697a6a0ac0a4a7b94b09c88770f14e6";
  final EthereumAddress sourceAddr =
      EthereumAddress.fromHex('0x6af227B1d0B976a71eb21f21Dc4C22218257a0C8');
  final EthereumAddress projAddr =
      EthereumAddress.fromHex('0x0670C0357432Ac4812463A73907Da8f94E34Ab78');
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("lungimea la proiecte ${chain.projects.length}");
    List<Widget> proiectili = [];
    ScrollController sc = ScrollController();
    return MainMenu(
        appstate: widget.appstate,
        porc: Container(
          padding: EdgeInsets.all(3),
          width: MediaQuery.of(context).size.width,
          child: Stack(children: [
            Scrollbar(
              controller: sc,
              child: Container(
                  height: MediaQuery.of(context).size.height - 30,
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                      child: Container(
                          alignment: Alignment.topCenter,
                          child: Column(
                            children: [
                              SizedBox(height: 50),
                              FutureBuilder(
                                  future: chain.populate(),
                                  builder: (context, snapshot) {
                                    if (chain.populating == true) {
                                      return Center(
                                          child: Container(
                                              padding: EdgeInsets.all(100),
                                              child:
                                                  CircularProgressIndicator()));
                                    } else {
                                      proiectili = [];
                                      for (Project p in chain.projects) {
                                        print("hai cu primul");
                                        proiectili.add(
                                          ProjectCard(
                                            p: p,
                                            appstate: widget.appstate,
                                          ),
                                        );
                                      }
                                      return Wrap(children: proiectili);
                                    }
                                  }),
                            ],
                          )))),
            ),
            Opacity(
                opacity: 0.91,
                child: Container(
                  height: 40,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    border: Border(
                        bottom: BorderSide(
                            width: 0.3, color: Theme.of(context).primaryColor)),
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: Text("Production",
                              style: TextStyle(
                                fontFamily: "OCR-A",
                              ))),
                      TextButton(
                          onPressed: () {},
                          child: Text("Training",
                              style: TextStyle(
                                fontFamily: "OCR-A",
                              ))),
                      TextButton(
                          onPressed: () {},
                          child: Text("Developers",
                              style: TextStyle(
                                fontFamily: "OCR-A",
                              ))),
                      TextButton(
                          onPressed: () {},
                          child: Row(
                            children: [
                              Text(
                                "FILTER",
                                style: TextStyle(fontSize: 12),
                              ),
                              Icon(Icons.sort)
                            ],
                          )),
                    ],
                  )),
                )),
          ]),
        ));
  }
}

import 'dart:ui';

import 'package:app2/contracts/project.dart';
import 'package:app2/contracts/source.dart';
import 'package:app2/services.dart/chain.dart';
import 'package:app2/widgets/agent_card.dart';
import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  Chain chain = new Chain();
  @override
  State<StatefulWidget> createState() {
    chain.populate();
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

  bool lumina = true;
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
      title: 'Autonet',
      theme: lumina ? light : dark,
      home: MyHomePage(title: 'AUTONET', appstate: this),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.appstate}) : super(key: key);
  final String title;
  MyAppState appstate;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
    var httpClient = new Client();
    var ethClient = new Web3Client(apiUrl, httpClient);
    final contract =
        DeployedContract(ContractAbi.fromJson(sourceAbi, 'Source'), sourceAddr);
    EtherAmount catam;
    String total;
    var sefufunction = contract.function('allProjects');
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
                        onPressed: () {},
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AgentCard(),
            // FutureBuilder(
            //     future: ethClient.call(
            //         contract: contract, function: sefufunction, params: []),
            //     builder: (context, snapshot) {
            //       if (snapshot.connectionState == ConnectionState.done) {
            //         return Text("Done" + snapshot.data.toString());
            //       } else {
            //         return Text("Not done");
            //       }
            //     }),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:ui';
import 'package:app2/screens/landing.dart';
import 'package:app2/screens/myassets.dart';
import 'package:app2/screens/node.dart';
import 'package:app2/services.dart/chain.dart';
import 'package:app2/widgets/agent_card.dart';
import 'package:app2/widgets/mainmenu.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:web3dart/web3dart.dart';
// import 'package:http/http.dart';
// import 'package:fps_widget/fps_widget.dart';
// import 'package:intl/date_time_patterns.dart';

Chain chain = Chain();
bool mining = false;
void main() {
  setPathUrlStrategy();
  runApp(const MyApp());
}

Map<String, Widget> routes = {};

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  DateTime now = DateTime.now();

  MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map swatch = <int, Color>{};
    final r = color.red, g = color.green, b = color.blue;

    for (var i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }

    // ignore: avoid_function_literals_in_foreach_calls
    strengths.forEach(
      (strength) {
        final ds = 0.5 - strength;
        // ignore: avoid_dynamic_calls
        swatch[(strength * 1000).round()] = Color.fromRGBO(
          r + ((ds < 0 ? r : (255 - r)) * ds).round(),
          g + ((ds < 0 ? g : (255 - g)) * ds).round(),
          b + ((ds < 0 ? b : (255 - b)) * ds).round(),
          1,
        );
      },
    );
    return MaterialColor(color.value, swatch);
  }

  bool lumina = false;
  bool bypass = false;

  @override
  void initState() {
    super.initState();
    chain.populate(this);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (!bypass) {
      now.hour < 7 || now.hour >= 21 ? lumina = false : lumina = true;
    }

    var light = ThemeData(
        brightness: Brightness.light,
        dividerColor: createMaterialColor(const Color(0xff445423)),
        hintColor: Colors.black87,
        primaryColor: createMaterialColor(const Color(0xffffffff)),
        primarySwatch: createMaterialColor(const Color(0xff4d4d4d)),
        highlightColor: const Color(0xff6e6e6e),
        backgroundColor: createMaterialColor(const Color(0xeecacaca)),
        accentColor: const Color(0xffe0deda),
        canvasColor: const Color(0xfff0f0f0));

    var dark = ThemeData(
      buttonColor: createMaterialColor(const Color(0xff505663)),
      dividerColor: createMaterialColor(const Color(0xffcfc099)),
      brightness: Brightness.dark,
      hintColor: Colors.white70,
      accentColor: createMaterialColor(const Color(0xff383736)),
      primaryColor: createMaterialColor(const Color(0xff4d4d4d)),
      primarySwatch: createMaterialColor(const Color(0xffefefef)),
      highlightColor: const Color(0xff6e6e6e),
    );

    return MaterialApp(
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/node':
            return PageTransition(
                child: Node(
                  appstate: this,
                ),
                type: PageTransitionType.fade);

          case '/market':
            return PageTransition(
                child: Market(
                  appstate: this,
                ),
                type: PageTransitionType.fade);
          case '/assets':
            return PageTransition(
                child: MyAssets(appstate: this), type: PageTransitionType.fade);
          case '/home':
            return PageTransition(
              child: MainMenu(
                care: 'landing',
                appstate: this,
                porc: Landing(appstate: this),
              ),
              type: PageTransitionType.fade,
            );
          default:
            return PageTransition(
              type: PageTransitionType.fade,
              child: routes[settings.name],
            );
        }
      },
      debugShowCheckedModeBanner: false,
      title: 'Autonet',
      theme: lumina ? light : dark,
      home: MainMenu(
        care: '/landing',
        appstate: this,
        porc: Landing(
          appstate: this,
        ),
      ),
    );
  }
}

class Market extends StatefulWidget {
  const Market({Key key, this.title, this.appstate}) : super(key: key);
  static String route = '/market';
  final String title;
  final MyAppState appstate;
  @override
  _MarketState createState() => _MarketState();
}

class _MarketState extends State<Market> {
  var apiUrl = 'https://rinkeby.infura.io/v3/e697a6a0ac0a4a7b94b09c88770f14e6';
  final EthereumAddress sourceAddr =
      EthereumAddress.fromHex('0x6af227B1d0B976a71eb21f21Dc4C22218257a0C8');
  final EthereumAddress projAddr =
      EthereumAddress.fromHex('0x0670C0357432Ac4812463A73907Da8f94E34Ab78');

  @override
  Widget build(BuildContext context) {
    var proiectili = <Widget>[];
    var sc = ScrollController();
    proiectili = [];
    for (var p in chain.projects) {
      proiectili.add(
        ProjectCard(
          p: p,
          appstate: widget.appstate,
        ),
      );
    }
    return MainMenu(
      care: 'market',
      appstate: widget.appstate,
      porc: Container(
        padding: const EdgeInsets.all(3),
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Scrollbar(
              controller: sc,
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 30,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        const SizedBox(height: 50),
                        Wrap(children: proiectili),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Opacity(
              opacity: 0.91,
              child: Container(
                height: 40,
                padding: const EdgeInsets.all(5),
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
                        onPressed: () => null,
                        child: const Text(
                          'Production',
                          style: TextStyle(
                            fontFamily: 'OCR-A',
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Training',
                          style: TextStyle(
                            fontFamily: 'OCR-A',
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Developers',
                          style: TextStyle(
                            fontFamily: 'OCR-A',
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Row(
                          children: const [
                            Text(
                              'FILTER',
                              style: TextStyle(fontSize: 12),
                            ),
                            Icon(Icons.sort)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

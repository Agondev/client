import 'package:app2/main.dart';
// import 'package:app2/services.dart/webtrei.dart';
import 'package:app2/widgets/mainmenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

// import 'package:flutter/foundation.dart';
bool mineaza = false;
String miningAddress = '(not set)';
bool setpressed = false;

class Node extends StatefulWidget {
  const Node({Key key, this.appstate, this.title}) : super(key: key);

  static String route = '/node';

  final String title;
  final MyAppState appstate;
  final bool status = false;

  @override
  State<StatefulWidget> createState() => NodeState();
}

class NodeState extends State<Node> {
  ScrollController sc = ScrollController();
  @override
  Widget build(BuildContext context) {
    return MainMenu(
        care: 'node',
        appstate: widget.appstate,
        porc: Container(
            padding: const EdgeInsets.all(3),
            width: MediaQuery.of(context).size.width,
            child: Stack(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Scrollbar(
                      controller: sc,
                      child: SizedBox(
                          height: MediaQuery.of(context).size.height - 30,
                          width: MediaQuery.of(context).size.width,
                          child: SingleChildScrollView(
                              child: Column(children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Mining Node',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 19,
                                  ),
                                  FlutterSwitch(
                                    width: 100.0,
                                    height: 34.0,
                                    valueFontSize: 15.0,
                                    activeColor: Colors.green,
                                    toggleSize: 34.0,
                                    value: mineaza,
                                    borderRadius: 30.0,
                                    padding: 8.0,
                                    showOnOff: true,
                                    onToggle: (val) {
                                      if (miningAddress != '(not set)') {
                                        setState(() {
                                          mineaza = val;
                                        });
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(37),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: const [
                                      SizedBox(height: 11),
                                      Text('Contract address:'),
                                      SizedBox(height: 29),
                                      Text('Uptime:'),
                                      SizedBox(height: 19),
                                      Text('Total earned:'),
                                    ],
                                  ),
                                  const SizedBox(width: 19),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(children: [
                                        setpressed == false
                                            ? TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    setpressed = true;
                                                  });
                                                },
                                                child: const Icon(Icons.edit))
                                            : const SizedBox(),
                                        setpressed
                                            ? SizedBox(
                                                width: 340,
                                                child: TextField(
                                                  maxLength: 42,
                                                  maxLines: 1,
                                                  onChanged: (val) {
                                                    if (val.length > 41) {
                                                      setState(
                                                        () {
                                                          miningAddress = val;
                                                          setpressed = false;
                                                        },
                                                      );
                                                    }
                                                  },
                                                  decoration: const InputDecoration(
                                                      labelText:
                                                          'Paste contract address'),
                                                ),
                                              )
                                            : Text(miningAddress,
                                                style: const TextStyle(
                                                    fontSize: 12)),
                                      ]),
                                      const SizedBox(height: 27),
                                      const Text('-- hrs, -- sec'),
                                      const SizedBox(height: 19),
                                      const Text('-- ATN'),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ]))))
                ])));
  }
}

import 'package:app2/main.dart';
// import 'package:app2/services.dart/chain.dart';
// import 'package:app2/widgets/agent_details.dart';
import 'package:app2/widgets/atncontract.dart';
import 'package:app2/widgets/mainmenu.dart';
import 'package:app2/widgets/metabutton.dart';
import 'package:app2/services.dart/webtrei.dart';
import 'package:flutter/material.dart';
// import 'package:web3dart/web3dart.dart';

// ignore: must_be_immutable
//
class MyAssets extends StatelessWidget {
  MyAssets({Key key, this.appstate, this.title}) : super(key: key);

  static String route = '/assets';

  final String title;
  final ScrollController sc = ScrollController();
  final MyAppState appstate;
  @override
  Widget build(BuildContext context) {
    return MainMenu(
      appstate: appstate,
      care: 'assets',
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
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        us3r == null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                    const SizedBox(height: 100),
                                    const Text(
                                      'Web3 provider not connected',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    const SizedBox(height: 100),
                                    MetaButton(landingPage: false)
                                  ])
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Connected with address   ${us3r.address}',
                                        ),
                                        const SizedBox(width: 40),
                                        // TextButton(
                                        //     onPressed: () {
                                        //       us3r.buyATN(EtherAmount
                                        //           .fromUnitAndValue(
                                        //               EtherUnit.finney,
                                        //               8));
                                        //     },
                                        //     child: Text("BUY ATN"))
                                      ]),
                                  us3r.contract == null
                                      ? const CreateContractBTN()
                                      : MyContractView(appstate: appstate)
                                ],
                              )
                      ],
                    ),
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

class CreateContractBTN extends StatefulWidget {
  const CreateContractBTN({Key key}) : super(key: key);

  @override
  _CreateContractBTNState createState() => _CreateContractBTNState();
}

class _CreateContractBTNState extends State<CreateContractBTN> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: us3r.creatingContract
          ? const CircularProgressIndicator()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                const Text(
                  'Autonet contract not initialized',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 100),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: TextButton(
                    onPressed: () async {
                      setState(() => us3r.creatingContract = true);
                      await us3r.createContract(this);
                      await Navigator.pushNamed(context, '/assets');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network('https://i.ibb.co/kXVw8Z2/logo64x64.png',
                            height: 40),
                        const Text(
                          'CREATE ATN CONTRACT',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

import 'package:app2/main.dart';
import 'package:app2/services.dart/chain.dart';
import 'package:app2/widgets/agent_details.dart';
import 'package:app2/widgets/atncontract.dart';
import 'package:app2/widgets/mainmenu.dart';
import 'package:app2/widgets/metabutton.dart';
import 'package:app2/services.dart/webtrei.dart';
import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';

// ignore: must_be_immutable
//
class MyAssets extends StatelessWidget {
  String title;
  static String route = "/assets";
  ScrollController sc = ScrollController();
  MyAppState appstate;
  MyAssets({this.appstate});
  @override
  Widget build(BuildContext context) {
    return MainMenu(
        appstate: appstate,
        care: "assets",
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
                          child: Container(
                              alignment: Alignment.topCenter,
                              child: Column(
                                children: [
                                  SizedBox(height: 20),
                                  us3r == null
                                      ? Column(children: [
                                          Text(
                                            "Web3 provider not connected",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          SizedBox(height: 20),
                                          MetaButton(landingPage: false)
                                        ])
                                      : Column(
                                          children: [
                                            Row(children: [
                                              Text("Connected with address " +
                                                  us3r.address),
                                              SizedBox(width: 40),
                                              TextButton(
                                                  onPressed: () {
                                                    us3r.buyATN(EtherAmount
                                                        .fromUnitAndValue(
                                                            EtherUnit.finney,
                                                            8));
                                                  },
                                                  child: Text("BUY ATN"))
                                            ]),
                                            us3r.contract == null
                                                ? CreateContractBTN()
                                                : MyContractView()
                                          ],
                                        )
                                ],
                              )))),
                ),
              ]),
        ));
  }
}

class CreateContractBTN extends StatefulWidget {
  @override
  _CreateContractBTNState createState() => _CreateContractBTNState();
}

class _CreateContractBTNState extends State<CreateContractBTN> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: us3r.creatingContract
          ? CircularProgressIndicator()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Autonet contract not initialized",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: TextButton(
                      onPressed: () async {
                        setState(() {
                          us3r.creatingContract = true;
                        });
                        await us3r.createContract(this);
                        Navigator.pushNamed(context, "/assets");
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                                "https://i.ibb.co/kXVw8Z2/logo64x64.png",
                                height: 40),
                            Text(
                              "CREATE ATN CONTRACT",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            )
                          ])),
                ),
              ],
            ),
    );
  }
}

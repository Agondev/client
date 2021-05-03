import 'dart:developer';
import 'dart:js_util';
import 'dart:ui';
import 'package:app2/contracts/project.dart';
import 'package:app2/services.dart/chain.dart';
import 'package:app2/services.dart/webtrei.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web3_provider/ethers.dart';
import 'package:web3dart/contracts.dart';
import 'package:web3dart/web3dart.dart';

class UserContract {
  Web3Provider web3user;
  Human user;
  String address;
  Map<String, double> assets;
  Map<String, Project> projects = {};

  UserContract({
    this.user,
    this.assets,
  }) {
    if (user.fetched == false) {
      assets.forEach((key, value) async {
        final EthereumAddress projAddr = EthereumAddress.fromHex(key);
        final contractProiect = DeployedContract(
            ContractAbi.fromJson(projectAbi, 'Project'), projAddr);
        var detailsf = contractProiect.function('details');
        var details = await user.web3infura
            .call(contract: contractProiect, function: detailsf, params: []);
        print(details);
        String name = details[0];
        String desc = details[1];
        String cat = details[2].toString().split("http")[0];
        String pic = "http" + details[2].toString().split("http")[1];
        String git = "http" + details[2].toString().split("http")[2];
        Project p = Project(
          address: key,
          name: details[0].toString(),
          description: details[1].toString(),
          picurl: pic,
          category: cat,
          github: git,
        );
        user.fetched = true;
        projects[key] = p;
      });
    }
  }
}

class MyContractView extends StatefulWidget {
  // UserContract contract;
  // MyContractView({this.contract});
  String address = "adaosijdoasdjfoasidjfpasodijfasd";
  String value = "12312 ATN";

  @override
  _MyContractViewState createState() => _MyContractViewState();
}

class _MyContractViewState extends State<MyContractView> {
  List<Widget> assets = [];
  // Human user = us3r;
  @override
  Widget build(BuildContext context) {
    assets = [];
    // print("how many projects ${user.contract.projects.values}");
    // user.contract.projects.forEach((k, v) {
    //   assets.add(asset(v, 100.0));
    // });
    return Container(
        padding: EdgeInsets.all(30),
        width: MediaQuery.of(context).size.width * 0.7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Text("Available Funds"),
                    SizedBox(
                      width: 14,
                    ),
                    Text("124123"),
                  ],
                ),
                Row(
                  children: [
                    TextButton(onPressed: () {}, child: Text("WITHDRAW")),
                    SizedBox(width: 40),
                    TextButton(onPressed: () {}, child: Text("ADD FUNDS")),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 19,
            ),
            Container(
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Theme.of(context).accentColor,
                )),
                child: Column(
                  children: [
                    Container(
                        height: 200,
                        color: Theme.of(context).accentColor,
                        child: Center(
                            child: Column(
                          children: [
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(width: 4),
                                Image.network(
                                    "https://i.ibb.co/kXVw8Z2/logo64x64.png",
                                    height: 40),
                                Spacer(),
                                Text(
                                  "ATN CONTRACT",
                                  style: TextStyle(
                                    color: Theme.of(context).canvasColor,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 19,
                                    fontFamily: "OCR-A",
                                    letterSpacing: 3,
                                  ),
                                ),
                                Spacer(),
                                Image.network(
                                    "https://i.ibb.co/kXVw8Z2/logo64x64.png",
                                    height: 40),
                                SizedBox(width: 4)
                              ],
                            ),
                            SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text("address:",
                                        style: TextStyle(
                                          fontFamily: "OCR-A",
                                          color: Theme.of(context).canvasColor,
                                        ))
                                  ],
                                ),
                                SizedBox(width: 18),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                            "0xFasdoja34dsf3fw98u34n98w3u4fnfe98uv43",
                                            style: TextStyle(
                                              fontFamily: "OCR-A",
                                              color:
                                                  Theme.of(context).canvasColor,
                                            )),
                                        TextButton(
                                            onPressed: () {
                                              Clipboard.setData(
                                                  new ClipboardData(
                                                      text:
                                                          "asdijaosidjaosidj"));
                                              final scaffold =
                                                  Scaffold.of(context);
                                              scaffold.showSnackBar(
                                                SnackBar(
                                                  duration: const Duration(
                                                      milliseconds: 1600),
                                                  content: Container(
                                                      height: 70,
                                                      child: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            'Contract address was copied to cliboard.',
                                                            style: TextStyle(
                                                                fontSize: 20),
                                                          ))),
                                                ),
                                              );
                                            },
                                            child: Icon(
                                              Icons.copy,
                                              color:
                                                  Theme.of(context).canvasColor,
                                            ))
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ))),
                    SizedBox(height: 19),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 30),
                        Text("AGENT NAME"),
                        SizedBox(width: 153),
                        Text("CATEGORY"),
                        SizedBox(width: 230),
                        Text("SHARES OWNED"),
                      ],
                    ),
                    SizedBox(height: 11),
                    Column(
                      children: assets,
                    ),
                    SizedBox(height: 11),
                  ],
                ))
          ],
        ));
  }

  Widget asset(Project p, percent) {
    return Container(
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 30),
          Container(
              width: 230,
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed("/project", arguments: [p]);
                    },
                    child: Text(p.name,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold)))
              ])),
          SizedBox(width: 11),
          Container(
              width: 290,
              child: Text(p.category, style: TextStyle(fontSize: 17))),
          SizedBox(width: 10),
          Container(
              width: 160,
              child: Text(percent.toString(), style: TextStyle(fontSize: 18))),
          Container(
              width: 100,
              child: Center(
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: Theme.of(context).accentColor)),
                      child: TextButton(
                          onPressed: () {},
                          child: Text("SELL",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold)))))),
        ],
      ),
    );
  }
}

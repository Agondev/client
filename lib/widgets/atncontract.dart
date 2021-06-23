import 'dart:ui';
import 'package:app2/contracts/project.dart';
import 'package:app2/services.dart/chain.dart';
import 'package:app2/services.dart/webtrei.dart';
import 'package:app2/widgets/new_project.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web3_provider/ethers.dart';
import 'package:web3dart/contracts.dart';
import 'package:web3dart/web3dart.dart';

class UserContract {
  UserContract({
    this.address,
    this.user,
    this.assets,
  }) {
    if (user.fetched == false) {
      assets.forEach(
        (key, value) async {
          final projAddr = EthereumAddress.fromHex(key);
          final contractProiect = DeployedContract(
              ContractAbi.fromJson(projectAbi, 'Project'), projAddr);
          var detailsf = contractProiect.function('details');
          var details = await user.web3infura
              .call(contract: contractProiect, function: detailsf, params: []);
          // String name = details[0];
          // String desc = details[1];
          var cat = details[2].toString().split('http')[0];
          var pic = 'http${details[2].toString().split('http')[1]}';
          var git = 'http${details[2].toString().split('http')[2]}';
          var p = Project(
            address: key,
            name: details[0].toString(),
            description: details[1].toString(),
            imgUrl: pic,
            category: cat,
            github: git,
          );
          user.fetched = true;
          projects[key] = p;
        },
      );
    }
  }

  Web3Provider web3user;
  Human user;
  EtherAmount valoare;
  String address;
  Map<String, double> assets;
  Map<String, Project> projects = {};
}

class MyContractView extends StatefulWidget {
  const MyContractView({Key key, this.appstate}) : super(key: key);

  // UserContract contract;
  // MyContractView({this.contract});
  // final String address = 'adaosijdoasdjfoasidjfpasodijfasd';
  // final String value = '12312 ATN';
  final dynamic appstate;

  @override
  _MyContractViewState createState() => _MyContractViewState();
}

class _MyContractViewState extends State<MyContractView> {
  List<Widget> assets = [];
  // Human user = us3r;
  @override
  Widget build(BuildContext context) {
    // print("how many projects ${user.contract.projects.values}");
    // user.contract.projects.forEach((k, v) {
    //   assets.add(asset(v, 100.0));
    // });
    print('test123: $us3r');
    print('test123: ${us3r.address}');
    print('test123: ${us3r.apiUrl}');
    print('test123: ${us3r.balance}');
    print('test123: ${us3r.contract}');
    print('test123: ${us3r.contract.address}');
    print('test123: ${us3r.contract.assets}');
    print('test123: ${us3r.contract.projects}');
    print('test123: ${us3r.contract.user}');
    print('test123: ${us3r.contract.valoare}');
    print('test123: ${us3r.contract.web3user}');
    print('test123: ${us3r.creatingContract}');
    print('test123: ${us3r.fetched}');
    print('test123: ${us3r.httpClient}');
    print('test123: ${us3r.sourceAbi}');
    print('test123: ${us3r.web3}');
    print('test123: ${us3r.web3infura}');
    return Container(
      padding: const EdgeInsets.all(30),
      width: MediaQuery.of(context).size.width * 0.7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 19),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: widget.appstate.lumina ? Colors.black54 : Colors.white54,
              ),
            ),
            child: Column(
              children: [
                Container(
                  height: 200,
                  color:
                      widget.appstate.lumina ? Colors.black54 : Colors.white54,
                  child: Center(
                    child: Column(
                      children: [
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(width: 4),
                            Image.network(
                              'https://i.ibb.co/kXVw8Z2/logo64x64.png',
                              height: 50,
                            ),
                            const Spacer(),
                            Text(
                              'ATN CONTRACT',
                              style: TextStyle(
                                color: Theme.of(context).canvasColor,
                                fontWeight: FontWeight.w900,
                                fontSize: 19,
                                fontFamily: 'Roboto Mono',
                                letterSpacing: 3,
                              ),
                            ),
                            const Spacer(),
                            Image.network(
                              'https://i.ibb.co/kXVw8Z2/logo64x64.png',
                              height: 50,
                            ),
                            const SizedBox(width: 4)
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const SizedBox(height: 2),
                                Text(
                                  'address:',
                                  style: TextStyle(
                                    fontFamily: 'Roboto Mono',
                                    color: Theme.of(context).canvasColor,
                                  ),
                                ),
                                const SizedBox(height: 13),
                                Text(
                                  'liquid funds:',
                                  style: TextStyle(
                                    fontFamily: 'Roboto Mono',
                                    color: Theme.of(context).canvasColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 18),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(us3r.contract.address,
                                        style: TextStyle(
                                          fontFamily: 'Roboto Mono',
                                          color: Theme.of(context).canvasColor,
                                        )),
                                    TextButton(
                                      onPressed: () {
                                        Clipboard.setData(
                                          ClipboardData(
                                            text: us3r.contract.address,
                                          ),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            duration:
                                                Duration(milliseconds: 1600),
                                            content: SizedBox(
                                              height: 70,
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  'Contract address was copied to cliboard.',
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      child: Icon(
                                        Icons.copy,
                                        color: Theme.of(context).canvasColor,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '${us3r.contract.valoare.getInEther} ATN',
                                  style: TextStyle(
                                    fontFamily: 'Roboto Mono',
                                    color: Theme.of(context).canvasColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Theme.of(context).canvasColor,
                                ),
                              ),
                              width: 210,
                              height: 40,
                              child: TextButton(
                                onPressed: () => showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    content: withdraw(),
                                  ),
                                ),
                                child: Text(
                                  'WITHDRAW',
                                  style: TextStyle(
                                    color: Theme.of(context).canvasColor,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Theme.of(context).canvasColor,
                                ),
                              ),
                              width: 210,
                              height: 40,
                              child: TextButton(
                                onPressed: () => showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    content: addFunds(),
                                  ),
                                ),
                                child: Text(
                                  'ADD FUNDS',
                                  style: TextStyle(
                                    color: Theme.of(context).canvasColor,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'PORTFOLIO',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .2,
                        child: const Text('AGENT NAME'),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .2,
                        child: const Text('CATEGORY'),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .2,
                        child: const Text('SHARES OWNED'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Column(
                  children: assets,
                ),
                const SizedBox(height: 40),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.transparent,
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: EditProject(
                          project: Project(
                            address: null,
                            description: null,
                            github: null,
                            name: null,
                            category: null,
                            imgUrl: null,
                          ),
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'Developing in TensorFlow? Add your project.',
                    style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(context).textTheme.bodyText2.color,
                    ),
                  ),
                ),
                const SizedBox(height: 7)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget withdraw() {
    // double diff;
    // bool acceptat = false;
    return SizedBox(
      height: 500,
      width: MediaQuery.of(context).size.width * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Contract is currently holding: ${us3r.contract.valoare.getInEther} ATN',
            style: const TextStyle(fontSize: 19),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Amount to withdraw: ',
                style: TextStyle(fontSize: 19),
              ),
              SizedBox(
                width: 100,
                child: TextField(
                  style: const TextStyle(fontSize: 19),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                    signed: false,
                  ),
                  onChanged: (value) {},
                  maxLines: 1,
                  maxLength: 10,
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(fontSize: 15),
                    labelText: 'Enter',
                    alignLabelWithHint: true,
                    focusColor: Colors.black,
                    fillColor: Colors.black,
                  ),
                ),
              ),
              const Text(
                'ATN',
                style: TextStyle(fontSize: 19),
              ),
            ],
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: 290,
            height: 50,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              onPressed: () {},
              child: const Text(
                'COMMIT TO BLOCKCHAIN',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget addFunds() {
    // double diff;
    // bool acceptat = false;
    return SizedBox(
      height: 500,
      width: MediaQuery.of(context).size.width * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            // ignore: prefer_adjacent_string_concatenation
            'Amount available in your wallet: ' +
                // EtherAmount.fromUnitAndValue(
                //         EtherUnit.finney, widget.sc.valoare)
                //     .getValueInUnit(EtherUnit.ether)
                //     .toString() +
                ' ATN',
            style: TextStyle(color: Colors.black87, fontSize: 19),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Amount to add: ',
                style: TextStyle(color: Colors.black, fontSize: 19),
              ),
              SizedBox(
                width: 100,
                child: TextField(
                  style: const TextStyle(
                    fontSize: 19,
                    color: Colors.black,
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                    signed: false,
                  ),
                  onChanged: (value) {},
                  maxLines: 1,
                  maxLength: 10,
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(fontSize: 15, color: Colors.black),
                    labelText: 'Enter',
                    alignLabelWithHint: true,
                    focusColor: Colors.black,
                    fillColor: Colors.black,
                  ),
                ),
              ),
              const Text(
                'ATN',
                style: TextStyle(color: Colors.black, fontSize: 19),
              ),
            ],
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: 290,
            height: 50,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              onPressed: () {},
              child: const Text(
                'COMMIT TO BLOCKCHAIN',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget asset(Project p, percent) => Container(
        color: Theme.of(context).primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 30),
            SizedBox(
              width: 230,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed('/project', arguments: [p]);
                    },
                    child: Text(
                      p.name,
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(width: 11),
            SizedBox(
              width: 290,
              child: Text(
                p.category,
                style: const TextStyle(fontSize: 17),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 160,
              child: Text(
                percent.toString(),
                style: const TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(
              width: 100,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 1, color: Theme.of(context).accentColor),
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'SELL',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}

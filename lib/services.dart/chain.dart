import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js_util';
import 'package:app2/contracts/project.dart';
import 'package:app2/contracts/source.dart';
import 'package:app2/main.dart';
import 'package:app2/services.dart/webtrei.dart';
import 'package:app2/widgets/atncontract.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_web3_provider/ethereum.dart';
import 'package:flutter_web3_provider/ethers.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';

const String _sourceAddress = '0x18A4d5A9039fd15A6576896cd7B445f9e4F3cff1';

class Chain {
  List<Project> projects = [];
  bool populating = false;
  bool populated = false;
  List addressesOfProjects;
  String tokenAddress;
  String chainID = '';
  var apiUrl = 'https://rinkeby.infura.io/v3/e697a6a0ac0a4a7b94b09c88770f14e6';
  final EthereumAddress sourceAddr = EthereumAddress.fromHex(_sourceAddress);
  Future populate(MyAppState state) async {
    populating = true;
    if (projects.isNotEmpty) {
      populating = false;
      return;
    } else {
      var httpClient = Client();
      var ethClient = Web3Client(apiUrl, httpClient);
      final contractSursa = DeployedContract(
          ContractAbi.fromJson(sourceAbi, 'Source'), sourceAddr);
      var tokaddress = contractSursa.function('tokenAddress');
      var raspunsLaTokenAddress = await ethClient
          .call(contract: contractSursa, function: tokaddress, params: []);
      tokenAddress = raspunsLaTokenAddress[0].toString();
      var proiectef = contractSursa.function('allProjects');
      var allProjects = await ethClient
          .call(contract: contractSursa, function: proiectef, params: []);
      addressesOfProjects = allProjects[0];
      for (var item in addressesOfProjects) {
        final projAddr = EthereumAddress.fromHex(item.toString());
        final contractProiect = DeployedContract(
            ContractAbi.fromJson(projectAbi, 'Project'), projAddr);
        var detailsf = contractProiect.function('details');
        var details = await ethClient
            .call(contract: contractProiect, function: detailsf, params: []);
        // String name = details[0];
        // String desc = details[1];
        var category = details[2].toString().split('http')[0];
        var imgUrl = 'http${details[2].toString().split('http')[1]}';
        var gitLink = 'http${details[2].toString().split('http')[2]}';
        var project = Project(
          address: item.toString(),
          name: details[0].toString(),
          description: details[1].toString(),
          imgUrl: imgUrl,
          category: category,
          github: gitLink,
        );
        projects.add(project);
        // routes['/market/${project.address}'] =
        //     ProjectView(address: project.address, appstate: state);
      }
      populated = true;
    }
  }
}

class Human {
  Human({this.address, this.web3}) {
    web3infura = Web3Client(apiUrl, httpClient);
  }

  var apiUrl = 'https://rinkeby.infura.io/v3/e697a6a0ac0a4a7b94b09c88770f14e6';
  var httpClient = Client();
  String address;
  bool fetched = false;
  bool creatingContract = false;
  UserContract contract;
  Web3Provider web3;
  Web3Client web3infura;
  EtherAmount balance;
  List<String> sourceAbi = [
    'function allProjects() view returns(address[])',
    'function projects(address) view returns (address)',
    'function users(address) view returns (address)',
    'function createUser() returns(address)',
    'function buy() payable'
  ];
  Future<String> buyATN(EtherAmount amount) async {
    creatingContract = true;
    var sourceContract = Contract(sursa, sourceAbi, web3);
    sourceContract = sourceContract.connect(web3user.getSigner());
    final transaction = await promiseToFuture(callMethod(
        sourceContract, 'buy', [TxParams(value: amount.getInWei.toString())]));
    final hash = json.decode(stringify(transaction))['hash'];
    final result =
        await promiseToFuture(callMethod(web3, 'waitForTransaction', [hash]));
    if (json.decode(stringify(result))['status'] == 0) {
      creatingContract = false;
      throw Exception('something went wrong.');
    } else {
      var a = json.decode(stringify(result));
      creatingContract = false;
      return a.toString();
    }
  }

  // ignore: always_declare_return_types
  createContract(State state) async {
    creatingContract = true;
    var sourceContract = Contract(sursa, sourceAbi, web3);
    sourceContract = sourceContract.connect(web3user.getSigner());
    final transaction =
        await promiseToFuture(callMethod(sourceContract, 'createUser', []));
    final hash = json.decode(stringify(transaction))['hash'];
    final result =
        await promiseToFuture(callMethod(web3, 'waitForTransaction', [hash]));
    if (json.decode(stringify(result))['status'] == 0) {
      throw Exception('something went wrong.');
    } else {
      // var first = await callMethod(sourceContract, 'users', [address]);
      // var ponse = await promiseToFuture(first);
      contract = UserContract(user: this, assets: {});
    }
    creatingContract = false;
    // state.setState(() {
    //   this.creatingContract = false;
    // });
  }
}

class Project {
  Project({
    this.address,
    this.name,
    this.description,
    this.imgUrl,
    this.github,
    this.category,
  }) {
    team = {'0xa9F8F9C0bf3188cEDdb9684ae28655187552bAE9': 100};
    shareholders = {'0xa9F8F9C0bf3188cEDdb9684ae28655187552bAE9': 5};
    investors = {};
    split = 5.0;
  }

  String address;
  Map<String, double> team;
  Map<String, double> shareholders;
  Map<String, double> investors;
  double split;
  String name;
  String description;
  String imgUrl;
  String github;
  String category;
}

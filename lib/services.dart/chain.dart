import 'dart:developer';
import 'dart:js_util';
import 'dart:convert';
import 'package:app2/contracts/project.dart';
import 'package:app2/contracts/source.dart';
import 'package:app2/services.dart/webtrei.dart';
import 'package:app2/widgets/agent_card.dart';
import 'package:app2/widgets/atncontract.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_web3_provider/ethereum.dart';
import 'package:flutter_web3_provider/ethers.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';

String sourceAddress = "0x18A4d5A9039fd15A6576896cd7B445f9e4F3cff1";

class Chain {
  List<Project> projects = [];
  bool populating = false;
  List adreseleProiectelor;
  String chainID = "";
  var apiUrl = "https://rinkeby.infura.io/v3/e697a6a0ac0a4a7b94b09c88770f14e6";
  final EthereumAddress sourceAddr = EthereumAddress.fromHex(sourceAddress);
  Future populate() async {
    populating = true;
    if (projects.length != 0) {
      populating = false;
      return;
    } else {
      var httpClient = new Client();
      var ethClient = new Web3Client(apiUrl, httpClient);
      final contractSursa = DeployedContract(
          ContractAbi.fromJson(sourceAbi, 'Source'), sourceAddr);
      var proiectef = contractSursa.function('allProjects');
      var allProjects = await ethClient
          .call(contract: contractSursa, function: proiectef, params: []);
      adreseleProiectelor = allProjects[0];
      print(adreseleProiectelor);
      for (var i in adreseleProiectelor) {
        final EthereumAddress projAddr = EthereumAddress.fromHex(i.toString());
        final contractProiect = DeployedContract(
            ContractAbi.fromJson(projectAbi, 'Project'), projAddr);
        var detailsf = contractProiect.function('details');
        var details = await ethClient
            .call(contract: contractProiect, function: detailsf, params: []);
        print(details);
        String name = details[0];
        String desc = details[1];
        String cat = details[2].toString().split("http")[0];
        String pic = "http" + details[2].toString().split("http")[1];
        String git = "http" + details[2].toString().split("http")[2];
        Project p = Project(
          address: i.toString(),
          name: details[0].toString(),
          description: details[1].toString(),
          picurl: pic,
          category: cat,
          github: git,
        );
        projects.add(p);
      }
      populating = false;
    }
  }
}

class Human {
  var apiUrl = "https://rinkeby.infura.io/v3/e697a6a0ac0a4a7b94b09c88770f14e6";
  var httpClient = new Client();
  String address;
  bool fetched = false;
  bool creatingContract = false;
  UserContract contract;
  Web3Provider web3;
  Web3Client web3infura;
  EtherAmount balance;
  Human({this.address, this.web3}) {
    this.web3infura = new Web3Client(apiUrl, httpClient);
  }
  List<String> sourceAbi = [
    "function allProjects() view returns(address[])",
    "function projects(address) view returns (address)",
    "function users(address) view returns (address)",
    "function createUser() returns(address)",
    "function buy() payable"
  ];
  Future<String> buyATN(EtherAmount amount) async {
    creatingContract = true;
    var sourceContract = Contract(sursa, sourceAbi, this.web3);
    sourceContract = sourceContract.connect(web3user.getSigner());
    final transaction = await promiseToFuture(callMethod(
        sourceContract, "buy", [TxParams(value: amount.getInWei.toString())]));
    final hash = json.decode(stringify(transaction))["hash"];
    print("hash " + hash.toString());
    final result = await promiseToFuture(
        callMethod(this.web3, "waitForTransaction", [hash]));
    if (json.decode(stringify(result))["status"] == 0) {
      creatingContract = false;
      throw Exception("something went wrong and life is misery.");
    } else {
      var a = json.decode(stringify(result));
      print(a);
      creatingContract = false;
      return a.toString();
    }
  }

  createContract(State state) async {
    creatingContract = true;
    var sourceContract = Contract(sursa, sourceAbi, this.web3);
    sourceContract = sourceContract.connect(web3user.getSigner());
    final transaction =
        await promiseToFuture(callMethod(sourceContract, "createUser", []));
    final hash = json.decode(stringify(transaction))["hash"];
    print("hash " + hash.toString());
    final result = await promiseToFuture(
        callMethod(this.web3, "waitForTransaction", [hash]));
    if (json.decode(stringify(result))["status"] == 0) {
      throw Exception("something went so fuckcing wrong.");
    } else {
      print(json.decode(stringify(result)));
      var first = await callMethod(sourceContract, "users", [this.address]);
      print("second " + first.toString());
      var ponse = await promiseToFuture(first);
      print("new contract address " + ponse.toString());
      this.contract = UserContract(user: this, assets: {});
    }
    state.setState(() {
      this.creatingContract = false;
    });
  }
}

class Project {
  String address;
  String developerAddress;
  String name;
  String description;
  String picurl;
  String github;
  String category;
  // Map<Human, double> shareholders;
  Project({
    this.address,
    this.name,
    this.description,
    this.picurl,
    this.github,
    this.category,
  }) {
    developerAddress = "xojpfoajepijoaijfd";
  }
}

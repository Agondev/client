import 'dart:convert';
import 'dart:js_util';
import 'package:app2/services.dart/chain.dart';
import 'package:app2/widgets/atncontract.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_web3_provider/ethereum.dart';
import 'package:flutter_web3_provider/ethers.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

String owner;
Web3Provider web3user;
bool data = false;
Client httpclient;
bool merge = false;
Human us3r;
String sursa = "0x8A4EF0f3e9F8AA6dDB2E153b9070f1EE8c25cd8c";

class Web3 extends ChangeNotifier {
  bool hopa = false;
  changeHopa(adresa) async {
    var balans = await promiseToFuture(web3user.getBalance(owner));
    print("iaca s-a intamplat");
  }

  List<String> sourceAbi = [
    "function allProjects() view returns(address[])",
    "function projects(address) view returns (address)",
    "function users(address) view returns (address)",
  ];

  List<String> userAbi = [
    "function getAssets() view returns (tuple(address,uint256)[])",
  ];
  List<String> projectAbi = ["function details() view returns(string[])"];

  web3sign() async {
    merge = true;
    print("etereum " + ethereum.toString());
    var accounts = await promiseToFuture(
        ethereum.request(RequestParams(method: 'eth_requestAccounts')));
    print(accounts);
    String se = ethereum.selectedAddress;
    print("selectedAddress: $se");
    web3user = Web3Provider(ethereum);
    owner = se;
    var sourceContract = Contract(sursa, sourceAbi, web3user);
    var first = await callMethod(sourceContract, "users", [se]);
    print("first" + first.toString());
    var ponse = await promiseToFuture(first);
    print("what comes back is literally " + ponse.toString());
    var userContract = Contract(ponse.toString(), userAbi, web3user);
    var second = await callMethod(userContract, "getAssets", []);
    var donse = await promiseToFuture(second);
    print("from donse we have $donse " + " |||and||| " + donse.toString());
    print("Amtrecut cu vine?");
    Map<String, double> assets = {};
    for (var asset in donse) {
      print("iteratia");
      print(asset[0].toString());
      assets[asset[0].toString()] = double.parse(asset[1].toString());
    }
    us3r = Human(address: se, web3: web3user);
    UserContract uc = UserContract(user: us3r, assets: assets);
    us3r.contract = uc;
    merge = false;
  }
}

import 'dart:developer';

import 'package:app2/contracts/project.dart';
import 'package:app2/contracts/source.dart';
import 'package:app2/widgets/agent_card.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';

class Chain {
  List<Project> projects = [];
  bool populating = false;
  List adreseleProiectelor;
  String chainID = "";
  var apiUrl = "https://rinkeby.infura.io/v3/e697a6a0ac0a4a7b94b09c88770f14e6";
  final EthereumAddress sourceAddr =
      EthereumAddress.fromHex('0x4C3ecDB8924890F6292CfBe2Af142DA21Aa60A8f');
  Future populate() async {
    populating = true;
    if (projects.length != 0) {
      print("cate proiects sunt daca sunt mai multe${projects.length}");
      populating = false;
      return;
    } else {
      print("cate proiects sunt daca sunt zero${projects.length}");
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
        print("am intrat in primul for");
        final EthereumAddress projAddr = EthereumAddress.fromHex(i.toString());
        final contractProiect = DeployedContract(
            ContractAbi.fromJson(projectAbi, 'Project'), projAddr);
        var detailsf = contractProiect.function('details');
        var details = await ethClient
            .call(contract: contractProiect, function: detailsf, params: []);
        print("chiar si aici");

        print(details);
        String name = details[0];
        String desc = details[1];
        String cat = details[2].toString().split("http")[0];
        String pic = "http" + details[2].toString().split("http")[1];
        String git = "http" + details[2].toString().split("http")[2];
        Project p = Project(
          name: details[0].toString(),
          description: details[1].toString(),
          picurl: pic,
          category: cat,
          github: git,
        );
        print("sau nu mai terminam?");
        projects.add(p);
      }
      print("suntem si noi aici?");
      populating = false;
    }
  }
}

class Human {
  String address;
}

class Project {
  String developerAddress;
  String name;
  String description;
  String picurl;
  String github;
  String category;
  // Map<Human, double> shareholders;
  Project({
    this.name,
    this.description,
    this.picurl,
    this.github,
    this.category,
  }) {
    developerAddress = "xojpfoajepijoaijfd";
  }
}

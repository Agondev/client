import 'package:app2/contracts/source.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';

class Chain {
  List<Project> projects;
  List adreseleProiectelor;
  String chainID = "";
  var apiUrl = "https://rinkeby.infura.io/v3/e697a6a0ac0a4a7b94b09c88770f14e6";
  final EthereumAddress sourceAddr =
      EthereumAddress.fromHex('0x6af227B1d0B976a71eb21f21Dc4C22218257a0C8');
  final EthereumAddress projAddr =
      EthereumAddress.fromHex('0x0670C0357432Ac4812463A73907Da8f94E34Ab78');
  populate() async {
    var httpClient = new Client();
    var ethClient = new Web3Client(apiUrl, httpClient);
    final contract =
        DeployedContract(ContractAbi.fromJson(sourceAbi, 'Source'), sourceAddr);
    var sefufunction = contract.function('allProjects');
    var allProjects = await ethClient
        .call(contract: contract, function: sefufunction, params: []);
    print(allProjects);
    adreseleProiectelor = allProjects[0];
    print(adreseleProiectelor);
    for (var i in adreseleProiectelor) {
      Project p = Project();
    }
  }
}

class Human {
  String address;
}

class Project {
  String name;
  String description;
  String picurl;
  Map<Human, double> shareholders;
  Project({this.name, this.description, this.picurl});
}

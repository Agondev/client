import 'package:app2/main.dart';
import 'package:app2/services.dart/chain.dart';
import 'package:app2/widgets/agent_details.dart';
import 'package:app2/widgets/mainmenu.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProjectView extends StatelessWidget {
  String address;
  ScrollController sc = ScrollController();
  MyAppState appstate;
  ProjectView({this.appstate,this.address});
  @override
  Widget build(BuildContext context) {
    var p;
   if (address==null){ p = (ModalRoute.of(context).settings.arguments as List)[0];}
   else{
     for (Project pr in chain.projects){
       if (address==pr.address){p=pr;}
     }if (p==null){return Container(child:Center(child:Text("No such resource on Autonet.")));}
   }
    print(p.name);
    return MainMenu(
        appstate: appstate,
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
                                  SizedBox(height: 50),
                                  ProjectDetails(p: p),
                                ],
                              )))),
                ),
                Opacity(
                    opacity: 0.91,
                    child: Container(
                      height: 40,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        border: Border(
                            bottom: BorderSide(
                                width: 0.3,
                                color: Theme.of(context).primaryColor)),
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                              onPressed: () {},
                              child: Text("Production",
                                  style: TextStyle(
                                    fontFamily: "OCR-A",
                                  ))),
                          TextButton(
                              onPressed: () {},
                              child: Text("Training",
                                  style: TextStyle(
                                    fontFamily: "OCR-A",
                                  ))),
                          TextButton(
                              onPressed: () {},
                              child: Text("Developers",
                                  style: TextStyle(
                                    fontFamily: "OCR-A",
                                  ))),
                          TextButton(
                              onPressed: () {},
                              child: Row(
                                children: [
                                  Text(
                                    "FILTER",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Icon(Icons.sort)
                                ],
                              )),
                        ],
                      )),
                    )),
              ]),
        ));
  }
}

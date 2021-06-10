import 'dart:convert';

import 'package:app2/services.dart/chain.dart';
import 'package:file_picker_cross/file_picker_cross.dart';
// import 'package:filesystem_picker/filesystem_picker.dart';
import "package:flutter/material.dart";
import 'package:flutter/painting.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:http/http.dart' as http;


class TeamMember extends StatelessWidget {
  String address;
  double percent;
  _EditProjectState state;
  Project p;
  TeamMember({this.p,this.address,this.percent,this.state});
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(address, style: TextStyle(fontSize: 13)),
        Row(children: [
          SizedBox(
              width: 300,
              child: Slider(
                value: p.team[address],min: 0,max: 100,
                onChanged: (value) {
                  int cati=p.team.keys.length-1;
                  double sum=0;
                  p.team.forEach((k, v) { sum=sum+v;});
                  if (p.team.keys.length>1&&value<=100-cati){
                  var diff=p.team[address]-value;
                  state.setState(() {
                    p.team[address]=value;
                   p.team.forEach((k, v) { 
                    if (k!=address){
                      if ((diff<0&&p.team[k]<1)||(diff>0&&p.team[k]>99)){cati=cati-1;}
                      if (diff<0&&p.team[k]>1||diff>0&&p.team[k]<99){
                      p.team[k]=p.team[k]+(diff/cati);
                      }
                    }
                   });
                  });}
                },
              )),
               Column(
                  children: [
                    Text("Team share"),
                    Text(
                        percent.toStringAsFixed(1),
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight:
                                FontWeight.bold)),
                        ],
                    ),
                    SizedBox(width:30),
                      Column(
                  children: [
                    Text("Total share"),
                    Text(
                        (percent*(p.split/100)).toStringAsFixed(2),
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight:
                                FontWeight.bold)),
                        ],
                    ),
        ]),
      ],
    ));
  
  
  }
}

class EditProject extends StatefulWidget {
  bool textfield = false;
  bool filepaste = false;
  bool socket = false;
  Project p;
  EditProject({this.p});
  String url = "https://discord-ro.tk:5000/v1/post_image";
  @override
  _EditProjectState createState() => _EditProjectState();
}

class _EditProjectState extends State<EditProject> {
  String rootPath;
  String state = "Stare1";
  List<Widget> ownership = [];
  @override
  Widget build(BuildContext context) {
    ownership=[];
    for (var stakeholder in widget.p.team.keys) {
      ownership.add(TeamMember(p:widget.p,percent: widget.p.team[stakeholder].toDouble(),state: this,address: stakeholder));
    }
    return Container(
      margin: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.8,
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.black)),
      padding: EdgeInsets.only(top: 30),
      child: Column(children: [
        Text("Add new AI project",
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
        SizedBox(height: 49),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                TextButton(
                    onPressed: () async {
                      FilePickerCross myFile =
                          await FilePickerCross.importFromStorage(
                              type: FileTypeCross.any,
                              fileExtension: 'txt, md');
                      var res = await uploadImage(myFile, widget.url);
                      setState(() {
                        widget.p.picurl = res;
                      });
                    },
                    child: Container(
                        height: 140,
                        width: 179,
                        child: widget.p.picurl==null? Column(
                          children: [
                            Image.network("https://i.ibb.co/2dphSM9/cogs.png",
                                                            height: 120),
                            Text("CHANGE ICON", style: TextStyle(fontSize: 15)),
                          ],
                        ):Image.network(widget.p.picurl)
                        )),
              ],
            ),
            SizedBox(width: 50),
            Column(
              children: [agentName(), agentDescription()],
            )
          ],
        ),
        SizedBox(height: 20),
        linkGit()
      ]),
    );
  }



  Widget linkGit() {
    List<Widget> team = [];
    widget.p.team.forEach((key, value) {
      team.add(TeamMember(address: key,percent: value.toDouble(),p: widget.p,state: this));
    });
    return widget.p.github == null
        ? TextButton(
            onPressed: () {},
            child: TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).buttonColor,
                    elevation: 1),
                onPressed: () {
                  setState(() {
                    widget.p.github = "https://github.com/openai/gpt-3";
                  });
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                          content: Container(child: Text("hello"))));
                },
                child: Container(
                  width: 290,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.code),
                      SizedBox(width: 7),
                      Text(
                        "Link Code Repository",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                )))
        : DefaultTabController(
            length: 3,
            child: Container(
              // height: 400,
              width: MediaQuery.of(context).size.width * 0.7,
              child: Column(children: [
                Container(
                    width: 400,
                    child: TabBar(tabs: [
                      Tab(text: "About"),
                      Tab(text: "Client I/O"),
                      Tab(text: "Ownership"),
                    ])),
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: TabBarView(
                    children: [
                      Container(
                        padding: EdgeInsets.all(50),
                        child: FutureBuilder(
                            future: http.get(Uri.https(
                                "raw.githubusercontent.com",
                                widget.p.github.split("github.com/")[1] +
                                    "/master/README.md")),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState !=
                                  ConnectionState.done) {
                                return Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                        padding: EdgeInsets.only(top: 20),
                                        width: 100,
                                        height: 120,
                                        child: CircularProgressIndicator()));
                              } else {
                                return SafeArea(
                                  child: Markdown(
                                    data: snapshot.data.body.toString(),
                                  ),
                                );
                              }
                            }),
                      ),
                      Container(
                        padding: EdgeInsets.all(30),
                        child: Column(
                          children: [
                            SizedBox(height: 18),
                            Container(
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        width: 500,
                                        child: Text("Your model will be invoked through RPC calls. " +
                                            "Select the additional in/out types to be made available" +
                                            " through the web and native clients.")),
                                    SizedBox(height: 35),
                                    Container(
                                        width: 390,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Checkbox(
                                                      value: widget.textfield,
                                                      checkColor:
                                                          Theme.of(context)
                                                              .errorColor,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          widget.textfield =
                                                              value;
                                                        });
                                                      }),
                                                  SizedBox(width: 10),
                                                  Text("Text field copy/paste")
                                                ]),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Checkbox(
                                                      checkColor:
                                                          Theme.of(context)
                                                              .errorColor,
                                                      value: widget.filepaste,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          widget.filepaste =
                                                              value;
                                                        });
                                                      }),
                                                  SizedBox(width: 10),
                                                  Text("File upload/download")
                                                ]),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Checkbox(
                                                      checkColor:
                                                          Theme.of(context)
                                                              .errorColor,
                                                      value: widget.socket,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          widget.socket = value;
                                                        });
                                                      }),
                                                  SizedBox(width: 10),
                                                  Text(
                                                      "Direct socket connection")
                                                ]),
                                          ],
                                        )),
                                    SizedBox(height: 20),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(children: [
                        Container(
                            margin: EdgeInsets.symmetric(vertical: 30),
                            width: 480,
                            child: Text(
                                "The dev/founding team can be allocated a maximum of 9% of the revenue generated by the mature agent, and that can be split between any number of Autonet contracts.")),
                        Container(
                            padding: EdgeInsets.all(25),
                            decoration:
                                BoxDecoration(border: Border.all(width: 1)),
                            child: Column(children: [
                              SizedBox(height:20),
                              Text(
                                  "Distribution of revenue between devs and miners:",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(height: 20),
                              SizedBox(
                                  width: 380,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            Text("Devs"),
                                            Text(
                                                widget.p.split.toStringAsFixed(1),
                                                style: TextStyle(
                                                    fontSize: 19,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                        SizedBox(
                                            width: 280,
                                            child: Slider(
                                              min: 0.1,
                                              max: 9.0,
                                              divisions: 90,
                                              value: widget.p.split,
                                              onChanged: (value) {
                                                setState(() {
                                                  widget.p.split = value;
                                                });
                                              },
                                            )),
                                        Column(
                                          children: [
                                            Text("Miners"),
                                            Text(
                                                (100.0 - widget.p.split)
                                                    .toStringAsFixed(1),
                                                style: TextStyle(
                                                    fontSize: 19,
                                                    fontWeight:FontWeight.bold)),
                                          ],
                                        )
                                      ])),
                            ])),
                        SizedBox(height: 14),
                        Container(
                            padding: EdgeInsets.all(25),
                            decoration:
                                BoxDecoration(border: Border.all(width: 1)),
                            child: Column(children: [
                              Text(
                                  "Distribution of revenue among founding team:",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                             SizedBox(height: 20),                        
                              Column(children: ownership),
                              TextButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                            content: Container(
                                                child: Container(
                                                    
                                                    height: 240,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.center,
                                                      children: [
                                                        SizedBox(height: 10),
                                                       
                                                        Text("Add team member",
                                                            style: TextStyle(fontWeight:FontWeight.bold,fontSize: 14)),
                                                        SizedBox(height: 40),
                                                        Container(padding: EdgeInsets.symmetric(horizontal:100),
                                                            child: TextField(
                                                              maxLength: 42,
                                                              decoration:InputDecoration(hintText:"Paste Ethereum wallet address (starting with 0x)"),
                                          maxLines: 1,
                                          onChanged:(address) {
                                            if (address.length >41) {
                                              setState(() {
                                                widget.p.team[address]=1;
                                                widget.p.team.forEach((k, v) { 
                                                  if (k!=address){
                                                    widget.p.team[k]=widget.p.team[k]-1/(widget.p.team.keys.length-1);
                                                  }
                                                });
                                                
                                                });
                                              Navigator.of(context).pop();
                                              }},
                                        )),
                                                      ],
                                                    )))));
                                  },
                                  child: Text("ADD TEAM MEMBER")),
                            ]))
                      ])
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  SizedBox(
                    height: 40,
                    width: 180,
                    child: TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black45)),
                        child: Text("DISCARD",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        onPressed: () {})),
                        SizedBox(width:120),
                         SizedBox(
                    height: 40,
                    width: 180,
                    child: TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red)),
                        child: Text("ADD PROJECT",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        onPressed: () {
                          
                        }))
                ],),
               
              ]),
            ));
  }
bool pressedName=false;
bool pressedDesc=false;
  Widget agentName() {
    Widget whatis=!pressedName?SizedBox(width:450, height:30,child:TextButton(
                onPressed: () {
                  setState(() {
                    pressedName=true;
                  });
                },
                child: Row(children: [
                  Icon(Icons.edit),
                  Text("Set name", style: TextStyle(fontSize: 21))
                ]))):TextField(
                  maxLength: 30,
                  style: TextStyle(fontSize: 21),
                  decoration: InputDecoration(
                    hintText: "Set project name") ,
                  onChanged:(value) {widget.p.name=value;},
                );
    return Container(
        width: 460,
        height: 30,
        child: widget.p.name == null
            ? whatis
            : Text(
                widget.p.name,
                style: TextStyle(fontSize: 21),
              ));
  }

  Widget agentDescription() {
     Widget whatis=!pressedDesc?SizedBox(width:470, height:90,child:TextButton(
                onPressed: () {setState(() {pressedDesc=true;});},
                child: Row(children: [
                  Icon(Icons.edit),
                  Text("Set description",)
                ]))):TextField(
                  maxLength: 141,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: "Describe value proposition or utility function.") ,
                  onChanged:(value) {widget.p.description=value;},
                );
    return Container(
        width: 470,
        height: 90,
        margin: EdgeInsets.only(top: 26),
        child: widget.p.description == null
            ? whatis:Text(
                widget.p.description,
                style: TextStyle(fontSize: 17),
              ));
  }

  Future<String> uploadImage(FilePickerCross fisier, String url) async {
    Map<String, String> map = {"image": fisier.toBase64()};
    http.Response resp = await http.post(widget.url, body: jsonEncode(map));
    var hopa = jsonDecode(resp.body);
    String picurl =
        jsonDecode(hopa["data"].substring(2, hopa['data'].length - 1))["data"]
                ["url"]
            .replaceAll(new RegExp('\\/'), '');
    String buna="https://i.ibb.co/"+picurl.replaceAll("\\","/").replaceAll("","/").split("ibb.co")[1];
    print(buna);
    return (buna);
  }
}
// SizedBox(
//             width: 190,
//             child: TextField(
//               style: TextStyle(
//                 fontSize: 19,
//               ),
//               onChanged: (value) {},
//               maxLines: 1,
//               maxLength: 30,
//               decoration: InputDecoration(
//                 labelStyle:
//                     TextStyle(fontSize: 15, color: Theme.of(context).hintColor),
//                 labelText: "Agent name",
//                 alignLabelWithHint: true,
//               ),
//             )),
//         SizedBox(width: 34),
//         SizedBox(height: 20),
//         SizedBox(
//             width: 290,
//             child: TextField(
//               style: TextStyle(
//                 fontSize: 19,
//               ),
//               onChanged: (value) {},
//               maxLines: 5,
//               maxLength: 140,
//               decoration: InputDecoration(
//                 labelStyle:
//                     TextStyle(fontSize: 15, color: Theme.of(context).hintColor),
//                 labelText: "Description",
//                 alignLabelWithHint: true,
//               ),
//             )),
//         SizedBox(width: 34)

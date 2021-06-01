import 'dart:convert';
import 'package:app2/services.dart/chain.dart';
import 'package:file_picker_cross/file_picker_cross.dart';
// import 'package:filesystem_picker/filesystem_picker.dart';
import "package:flutter/material.dart";
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:http/http.dart' as http;

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
    for (var stakeholder in widget.p.team.keys) {
      ownership.add(teamMember(stakeholder, widget.p.team[stakeholder]));
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
                        child: Column(
                          children: [
                            Image.network("https://i.ibb.co/2dphSM9/cogs.png",
                                height: 120),
                            Text("CHANGE ICON", style: TextStyle(fontSize: 15)),
                          ],
                        ))),
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

  Widget teamMember(address, percent) {
    return Container(
        child: Row(
      children: [
        Text(address, style: TextStyle(fontSize: 13)),
        Row(children: [
          SizedBox(
              width: 300,
              child: Slider(
                value: percent,
                min: 1,
                max: 100,
                onChanged: (value) {
                  setState(() {
                    value = percent;
                  });
                },
              )),
          Text(percent.toString())
        ]),
        TextButton(
          child: Icon(Icons.delete),
          onPressed: () {},
        )
      ],
    ));
  }

  Widget linkGit() {
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
                                            Text("3%",
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
                                              value: 4.0,
                                              onChanged: (value) {},
                                            )),
                                        Column(
                                          children: [
                                            Text("Miners"),
                                            Text("97%",
                                                style: TextStyle(
                                                    fontSize: 19,
                                                    fontWeight:
                                                        FontWeight.bold)),
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
                              Column(children: ownership),
                              SizedBox(height: 40),
                              TextButton(
                                  onPressed: () {},
                                  child: Text("ADD TEAM MEMBER")),
                            ]))
                      ])
                    ],
                  ),
                ),
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
                        onPressed: () {}))
              ]),
            ));
  }

  Widget agentName() {
    return Container(
        width: 460,
        height: 30,
        child: widget.p.name == null
            ? TextButton(
                onPressed: () {
                  setState(() {
                    widget.p.name = "veronica miclea";
                  });
                },
                child: Row(children: [
                  Icon(Icons.edit),
                  Text("Set name", style: TextStyle(fontSize: 21))
                ]))
            : Text(
                widget.p.name,
                style: TextStyle(fontSize: 21),
              ));
  }

  Widget agentDescription() {
    return Container(
        width: 470,
        height: 90,
        margin: EdgeInsets.only(top: 26),
        child: widget.p.description == null
            ? TextButton(
                onPressed: () {
                  setState(() {
                    widget.p.description =
                        "Dooj de saptamani care mai stau eu cu voi sa ma bata soarele la polul opus centrului de pod pe spatele calului am mers de fapt mai mult am stat si el mergea.";
                  });
                },
                child: Row(children: [
                  Icon(Icons.edit),
                  Text("Set description", style: TextStyle(fontSize: 17))
                ]))
            : Text(
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
    print(picurl);
    return (picurl);
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

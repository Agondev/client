import 'package:app2/services.dart/chain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:http/http.dart' as http;

class ProjectDetails extends StatefulWidget {
  ProjectDetails({
    this.p,
    this.gitSuffix,
    this.readme,
    this.github,
    this.size,
    this.earned,
    this.descriere,
  });

  final Project p;
  final String gitSuffix;
  final String readme;
  final int size;
  final int earned;
  final String descriere;
  final String github;

  @override
  _ProjectDetailsState createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {
  final bool seia = false;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            padding: EdgeInsets.all(12),
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              children: [
                SizedBox(height: 11),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 19),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(11.0),
                              child:
                                  Image.network(widget.p.picurl, height: 114),
                            )),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.p.name, style: TextStyle(fontSize: 28)),
                            SizedBox(height: 9),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text("Category"),
                                    Text("Developer:"),
                                    Text("Size Goal:"),
                                    Text("Earned:"),
                                  ],
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Natural Language"),
                                    Text("Alphabet inc"),
                                    Text("56BN params"),
                                    Text("-- ATN"),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    Container(
                        padding: EdgeInsets.only(right: 40),
                        child: Card(
                            elevation: 0.0,
                            child: Container(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Text("Price per call"),
                                  Text(
                                    "0.0031 ATN",
                                    style: TextStyle(fontSize: 28),
                                  )
                                ],
                              ),
                            )))
                  ],
                ),
                SizedBox(height: 30),
                DefaultTabController(
                    length: 3,
                    child: Container(
                      // height: 400,
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Column(children: [
                        Container(
                            width: 400,
                            child: TabBar(tabs: [
                              Tab(text: "About"),
                              Tab(text: "Invest"),
                              Tab(text: "Stats"),
                            ])),
                        Container(
                          height: MediaQuery.of(context).size.height,
                          child: TabBarView(
                            children: [
                              Container(
                                padding: EdgeInsets.all(50),
                                child: FutureBuilder(
                                    future: http.get(
                                      Uri.https(
                                          "raw.githubusercontent.com",
                                          widget.github
                                                  .split("github.com/")[1] +
                                              "/master/README.md"),
                                    ),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState !=
                                          ConnectionState.done) {
                                        return Align(
                                            alignment: Alignment.topCenter,
                                            child: Container(
                                                padding:
                                                    EdgeInsets.only(top: 20),
                                                width: 100,
                                                height: 120,
                                                child:
                                                    CircularProgressIndicator()));
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Text("Current value:"),
                                                    Text("Funding goal:"),
                                                    Text("Available shares:"),
                                                    Text("Price per share:"),
                                                    Text("Campaign deadline:"),
                                                  ],
                                                ),
                                                SizedBox(width: 15),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text("341 ATN"),
                                                    Text("449104 ATN"),
                                                    Text("9831103 (84.65%)"),
                                                    Text("0.022 ATN"),
                                                    Text("May 22, 2021"),
                                                  ],
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 20),
                                            Container(
                                                height: 55,
                                                width: 200,
                                                child: TextButton(
                                                  style: TextButton.styleFrom(
                                                      backgroundColor:
                                                          Theme.of(context)
                                                              .hoverColor),
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(Icons.school),
                                                        SizedBox(width: 10),
                                                        Text(
                                                          'INVEST IN TRAINING',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )
                                                      ]),
                                                  onPressed: () {
                                                    showDialog(
                                                        context: context,
                                                        builder:
                                                            (context) =>
                                                                AlertDialog(
                                                                  content:
                                                                      Container(
                                                                    width: 600,
                                                                    height: 600,
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            20),
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceEvenly,
                                                                      children: [
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Text("Available funds your contract:"),
                                                                            SizedBox(width: 9),
                                                                            Text(
                                                                              "3124 ATN",
                                                                              style: TextStyle(fontWeight: FontWeight.bold),
                                                                            )
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              30,
                                                                        ),
                                                                        SizedBox(
                                                                            width:
                                                                                110,
                                                                            child:
                                                                                TextFormField(
                                                                              style: TextStyle(
                                                                                fontSize: 19,
                                                                              ),
                                                                              keyboardType: TextInputType.numberWithOptions(decimal: true, signed: false),
                                                                              onChanged: (value) {},
                                                                              decoration: InputDecoration(
                                                                                labelStyle: TextStyle(
                                                                                  fontSize: 15,
                                                                                ),
                                                                                labelText: "Enter Value",
                                                                                alignLabelWithHint: true,
                                                                              ),
                                                                            )),
                                                                        SizedBox(
                                                                            height:
                                                                                30),
                                                                        Column(
                                                                          children: [
                                                                            Container(
                                                                              padding: EdgeInsets.symmetric(horizontal: 70),
                                                                              child: Text("You are acquiring shares in project GPT-3. This transaction is irrevocable. You may put up your shares for sale once the training is complete, and you will be reimbursed if the model doesn't achieve the targeted accuracy within the specified timeframe."),
                                                                            ),
                                                                            SizedBox(height: 30),
                                                                            SizedBox(
                                                                              width: 290,
                                                                              height: 50,
                                                                              child: TextButton(
                                                                                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xff851339))),
                                                                                  child: Text("COMMIT TO BLOCKCHAIN", style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
                                                                                  onPressed: () {
                                                                                    Navigator.pop(context);
                                                                                  }),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ));
                                                  },
                                                ))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(Icons.bar_chart_outlined, size: 350),
                            ],
                          ),
                        )
                      ]),
                    )),
              ],
            )));
  }
}

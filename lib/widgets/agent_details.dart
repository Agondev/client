import 'package:app2/services.dart/chain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:http/http.dart' as http;

class ProjectDetails extends StatelessWidget {
  Project p;
  String gitSuffix;
  String readme;
  String github;
  int size;
  int earned;
  bool seia = false;
  String descriere;
  ProjectDetails({this.p}) {
    this.github = this.p.github.split("github.com/")[1];
  }

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
                          child: Image.network(p.picurl, height: 114),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(p.name, style: TextStyle(fontSize: 28)),
                            SizedBox(height: 9),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text("Category"),
                                    Text("Developer:"),
                                    Text("Size:"),
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
                                    Text("3148321 ATN"),
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
                              Tab(text: "Run"),
                              Tab(text: "Stats"),
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
                                        github + "/master/README.md")),
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
                                    SizedBox(height: 100),
                                    Container(
                                        height: 55,
                                        width: 200,
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                              backgroundColor:
                                                  Theme.of(context).hoverColor),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.add),
                                                Text(
                                                  'ADD TO CONTRACT',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ]),
                                          onPressed: () {},
                                        ))
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

import 'package:app2/services.dart/chain.dart';
import 'package:app2/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
// ignore: unused_import
import 'package:http/http.dart' as http;

class ProjectDetails extends StatefulWidget {
  const ProjectDetails({
    Key key,
    this.project,
    this.gitSuffix,
    this.readme,
    this.github,
    this.size,
    this.earned,
    this.descriere,
  }) : super(key: key);

  final Project project;
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
        padding: const EdgeInsets.all(12),
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          children: [
            const SizedBox(height: 11),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 19),
                      child: ConstrainedBox(
                        constraints:
                            const BoxConstraints(maxHeight: 120, minWidth: 120),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(11.0),
                          child: isValidImageExtension(widget.project.picurl)
                              ? Image.network(
                                  widget.project.picurl,
                                )
                              : const Placeholder(),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.project.name,
                          style: const TextStyle(fontSize: 28),
                        ),
                        const SizedBox(height: 9),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: const [
                                Text('Category'),
                                Text('Developer:'),
                                Text('Size Goal:'),
                                Text('Earned:'),
                              ],
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('Natural Language'),
                                Text('Alphabet inc'),
                                Text('56BN params'),
                                Text('-- ATN'),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(right: 40),
                  child: Card(
                    elevation: 0.0,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: const [
                          Text('Price per call'),
                          Text(
                            '0.0031 ATN',
                            style: TextStyle(fontSize: 28),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 30),
            DefaultTabController(
              length: 3,
              child: SizedBox(
                // height: 400,
                width: MediaQuery.of(context).size.width * 0.7,
                child: Column(
                  children: [
                    const SizedBox(
                      width: 400,
                      child: TabBar(
                        tabs: [
                          Tab(text: 'About'),
                          Tab(text: 'Invest'),
                          Tab(text: 'Stats'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: TabBarView(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(50),
                            child: FutureBuilder(
                              // future: http.get(
                              //   Uri.https(
                              //     'raw.githubusercontent.com',
                              //     '${widget.github.split('github.com/')[1]}/master/README.md',
                              //   ),
                              // ),
                              future: Future.value(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState !=
                                    ConnectionState.done) {
                                  return const Align(
                                    alignment: Alignment.topCenter,
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 20),
                                      child: SizedBox(
                                        width: 100,
                                        height: 120,
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                  );
                                } else {
                                  return const SafeArea(
                                    child: Markdown(
                                      // data: snapshot.data.body.toString(),
                                      data: 'TEST1234',
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(30),
                            child: AgentProgress(),
                          ),
                          const Icon(Icons.bar_chart_outlined, size: 350),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AgentProgress extends StatelessWidget {
  const AgentProgress({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const SizedBox(height: 18),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Text('Current value:'),
                        Text('Funding goal:'),
                        Text('Available shares:'),
                        Text('Price per share:'),
                        Text('Campaign deadline:'),
                      ],
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('341 ATN'),
                        Text('449104 ATN'),
                        Text('9831103 (84.65%)'),
                        Text('0.022 ATN'),
                        Text('May 22, 2021'),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                    height: 55,
                    width: 200,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Theme.of(context).hoverColor),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  content: Container(
                                    width: 600,
                                    height: 600,
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Text(
                                                'Available funds your contract:'),
                                            SizedBox(width: 9),
                                            Text(
                                              '3124 ATN',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        SizedBox(
                                          width: 110,
                                          child: TextFormField(
                                            style:
                                                const TextStyle(fontSize: 19),
                                            keyboardType: const TextInputType
                                                    .numberWithOptions(
                                                decimal: true, signed: false),
                                            onChanged: (value) {},
                                            decoration: const InputDecoration(
                                              labelStyle: TextStyle(
                                                fontSize: 15,
                                              ),
                                              labelText: 'Enter Value',
                                              alignLabelWithHint: true,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 30),
                                        Column(
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 70),
                                              child: const Text(
                                                  "You are acquiring shares in project GPT-3. This transaction is irrevocable. You may put up your shares for sale once the training is complete, and you will be reimbursed if the model doesn't achieve the targeted accuracy within the specified timeframe."),
                                            ),
                                            const SizedBox(height: 30),
                                            SizedBox(
                                              width: 290,
                                              height: 50,
                                              child: TextButton(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                    const Color(0xff851339),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                  'COMMIT TO BLOCKCHAIN',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.school),
                          SizedBox(width: 10),
                          Text(
                            'INVEST IN TRAINING',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ],
      );
}

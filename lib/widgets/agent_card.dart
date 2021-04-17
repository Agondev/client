import 'package:flutter/material.dart';

class AgentCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4,
        child: TextButton(
            onPressed: () {},
            child: Container(
                width: 400,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 5, 5),
                      child: Row(
                        children: [
                          Image.network(
                            "https://i.ibb.co/Y2CYJBd/science-icon-18.png",
                            height: 90,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Agent title",
                                style: TextStyle(
                                    fontSize: 21, fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [Text("******"), Text("\u200d")],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(19),
                      child: Text(
                          "Description text goes here and I guess it's what we all are interested to read and find out etc"),
                    ),
                  ],
                ))));
  }
}

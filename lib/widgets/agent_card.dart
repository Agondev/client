import 'package:app2/main.dart';
import 'package:app2/services.dart/chain.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProjectCard extends StatelessWidget {
  ProjectCard({Key key, this.p, this.appstate}) : super(key: key);

  Project p;
  MyAppState appstate;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: TextButton(
        onPressed: () => Navigator.of(context)
            .pushNamed('/market/${p.address}', arguments: [p]),
        child: SizedBox(
          width: 400,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 5, 5),
                child: Row(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          p.picurl,
                          height: 90,
                        )),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          p.name,
                          style: const TextStyle(
                              fontSize: 21, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: const [Text('******'), Text('\\u200d')],
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(19),
                child: Text(p.description),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

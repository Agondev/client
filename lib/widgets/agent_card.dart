import 'package:app2/main.dart';
import 'package:app2/services.dart/chain.dart';
import 'package:flutter/material.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({Key key, this.project, this.appstate}) : super(key: key);

  final Project project;
  final MyAppState appstate;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: TextButton(
        onPressed: () => Navigator.of(context).pushNamed(
          '/market/${project.address}',
          arguments: [project],
        ),
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
                        project.picurl,
                        height: 90,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project.name,
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
                child: Text(project.description),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

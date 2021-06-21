import 'package:app2/main.dart';
import 'package:app2/services.dart/chain.dart';
import 'package:app2/widgets/agent_details.dart';
import 'package:app2/widgets/mainmenu.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProjectView extends StatelessWidget {
  ProjectView({Key key, this.appstate, this.address}) : super(key: key);

  final String address;
  final ScrollController sc = ScrollController();
  final MyAppState appstate;

  @override
  Widget build(BuildContext context) {
    Project project;
    if (address == null) {
      project = (ModalRoute.of(context).settings.arguments as List)[0];
    } else {
      for (var item in chain.projects) {
        if (address == item.address) {
          project = item;
        }
      }
      if (project == null) {
        return const SizedBox(
            child: Center(child: Text('No such resource on Autonet.')));
      }
    }
    return MainMenu(
      appstate: appstate,
      porc: Container(
        padding: const EdgeInsets.all(3),
        width: MediaQuery.of(context).size.width,
        child: Stack(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Scrollbar(
              controller: sc,
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 30,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        const SizedBox(height: 50),
                        ProjectDetails(p: project),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Opacity(
              opacity: 0.91,
              child: Container(
                height: 40,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  border: Border(
                      bottom: BorderSide(
                          width: 0.3, color: Theme.of(context).primaryColor)),
                ),
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      TextButtonPlaceholder(
                        text: 'Production',
                      ),
                      TextButtonPlaceholder(text: 'Training'),
                      TextButtonPlaceholder(
                        text: 'Developers',
                      ),
                      TextButtonPlaceholder(
                        text: 'FILTER',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextButtonPlaceholder extends StatelessWidget {
  const TextButtonPlaceholder({
    Key key,
    this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'OCR-A',
        ),
      ),
    );
  }
}

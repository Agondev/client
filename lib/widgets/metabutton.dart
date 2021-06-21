// ignore_for_file: avoid_dynamic_calls
// import 'package:app2/screens/landing.dart';
import 'package:app2/services.dart/webtrei.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_web3_provider/ethereum.dart';
// import 'package:flutter_web3_provider/ethers.dart';

class MetaButton extends StatefulWidget {
  MetaButton({Key key, this.context, this.landingPage, this.state})
      : super(key: key);

  final bool landingPage;
  final dynamic state;
  final Web3 webtrei = Web3();
  final BuildContext context;

  @override
  MetaButtonState createState() => MetaButtonState();
}

class MetaButtonState extends State<MetaButton> {
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      child: ElevatedButton(
        onPressed: () async {
          setState(() {
            _isProcessing = true;
          });
          if (!widget.landingPage) {
            widget.webtrei.web3sign();
            await Navigator.of(context).pushNamed('/assets');
          } else {
            if (us3r == null) {
              widget.webtrei.web3sign();
              widget.state.setState(() => widget.state.widget.isUser = true);
              Navigator.of(context).pop();
            }

            await showDialog(
                context: context,
                builder: (context) =>
                    AlertDialog(content: widget.state.widget.landing.buyATN()));
          }
          setState(() {
            _isProcessing = false;
          });
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(4, 10, 4, 10),
          child: _isProcessing
              ? const CircularProgressIndicator()
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    const SizedBox(width: 3),
                    Image.network(
                      'https://i.ibb.co/dphrBzn/metamask.png',
                      // "https://i.ibb.co/wSK0Lgb/metaicon.png",
                      height: 26,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        'CONNECT METAMASK  ',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

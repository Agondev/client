import 'package:app2/screens/landing.dart';
import 'package:app2/services.dart/webtrei.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web3_provider/ethereum.dart';
import 'package:flutter_web3_provider/ethers.dart';

class MetaButton extends StatefulWidget {
  bool landingPage;
  var state;
  Web3 webtrei = Web3();
  BuildContext context;
  MetaButton({this.context, this.landingPage, this.state});
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
      child: OutlineButton(
        onPressed: () async {
          setState(() {
            _isProcessing = true;
          });
          if (!widget.landingPage) {
            await widget.webtrei.web3sign();
            Navigator.of(context).pushNamed("/assets");
          } else {
            await Future.delayed(Duration(seconds: 2));
            widget.state.setState(() {
              widget.state.widget.isUser = true;
            });
            Navigator.of(context).pop();
            showDialog(
                context: context,
                builder: (context) =>
                    AlertDialog(content: widget.state.widget.landing.buyATN()));
          }
          setState(() {
            _isProcessing = false;
          });
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(width: 3, color: Theme.of(context).primaryColor)),
        highlightElevation: 0,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(4, 10, 4, 10),
          child: _isProcessing
              ? CircularProgressIndicator()
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    SizedBox(width: 3),
                    Image.network(
                      "https://i.ibb.co/HrMvRMC/metamask-icon.jpg",
                      // "https://i.ibb.co/wSK0Lgb/metaicon.png",
                      height: 26,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        'CONNECT METAMASK  ',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}

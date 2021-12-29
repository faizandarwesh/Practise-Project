import 'package:flutter/cupertino.dart';

class CupertinoLoaderDialog extends StatelessWidget {
  const CupertinoLoaderDialog({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return const CupertinoAlertDialog(
      title: Text('Loading..'),
      content:  Padding(
        padding: EdgeInsets.all(12.0),
        child: CupertinoActivityIndicator(radius: 16.0,),
      ),
    );
  }
}


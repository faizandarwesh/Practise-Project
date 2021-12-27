import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_camera/ui/home/home_screen.dart';

class CustomIosDialog extends StatelessWidget {
  final String _title;
  final String _msg;

   const CustomIosDialog({
    required String title,
    required String message
  })  : _msg = message,
        _title = title;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(_title),
      content:  Text(_msg),
      actions:  <Widget>[
        CupertinoDialogAction(
          isDefaultAction: true,
          child: const Text("Ok"),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                    (Route<dynamic> route) => false);
            if (Get.isDialogOpen!) {
              Get.back();
            } // dismisses only the dialog and returns nothing
          },
        ),
      ],
    );
  }
}

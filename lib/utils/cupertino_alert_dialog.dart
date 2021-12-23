import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_camera/ui/custom_camera/camera_landing_screen.dart';

import '../main.dart';

class CustomIosDialog extends StatelessWidget {
  final String _title;
  final String _msg;

   CustomIosDialog({
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
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CameraLandingScreen()));
            if (Get.isDialogOpen!) {
              Get.back();
            } // dismisses only the dialog and returns nothing
          },
        ),
      ],
    );
  }
}

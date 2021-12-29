import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:in_app_camera/main.dart';
import 'package:in_app_camera/model/driver_report.dart';
import 'package:in_app_camera/service/network_status_service.dart';
import 'package:provider/provider.dart';

import 'app_constants.dart';

class NetworkAwareWidget extends StatelessWidget {
  final Widget childWidget;

  const NetworkAwareWidget({Key? key, required this.childWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    NetworkStatus? networkStatus = Provider.of<NetworkStatus?>(context);
    reportsBox = Hive.box<DriverReport>(AppConstants.reportsBox);

    if (networkStatus == NetworkStatus.online && reportsBox.values.isNotEmpty) {
      print("Online");
      _showToastMessage("Online and local storage is filled");
      return childWidget;
    }else if(networkStatus == NetworkStatus.online){
      print("Online but local storage is empty");
      _showToastMessage("Online");

      return childWidget;
    }
    else {
      print("Offline");
      _showToastMessage("Offline");
      return childWidget;
    }
  }

  void _showToastMessage(String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:in_app_camera/model/driver_report.dart';
import 'package:in_app_camera/service/network_status_service.dart';
import 'package:in_app_camera/utils/app_constants.dart';
import 'package:in_app_camera/utils/helper_functions.dart';
import 'package:in_app_camera/utils/network_aware_widget.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'camera_screen.dart';
import '../../main.dart';
import '../../utils/custom_widgets/maps_web_view.dart';
import '../../utils/custom_widgets/offline_reports_screen.dart';


class CameraLandingScreen extends StatefulWidget {
  const CameraLandingScreen({Key? key}) : super(key: key);

  @override
  _CameraLandingScreenState createState() => _CameraLandingScreenState();
}

class _CameraLandingScreenState extends State<CameraLandingScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("In App Camera"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have to take picture before the service of bin',
            ),
            Text(
              'Take picture',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(
              height: 32,
            ),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 13),
                  ),
                  textStyle: MaterialStateProperty.all(
                    GoogleFonts.poppins(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                onPressed: () {
                  openCamera(context);
                },
                child: const Text(
                  'Open In App Camera',
                ),
              ),
            ),
          ],
        ),
      )
    );
  }

  void openCamera(BuildContext context) async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        Get.snackbar(
          'Permission Request',
          "Please turn on your location to proceed",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } else if (_serviceEnabled) {
      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted == PermissionStatus.granted) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CameraScreen(
                    cameras: cameras,
                  )));
        }
        if (_permissionGranted == PermissionStatus.grantedLimited) {
          print("grantedLimited");
        }
      } else if (_permissionGranted == PermissionStatus.granted) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CameraScreen(
                  cameras: cameras,
                )));
      }
    }
  }

  void checkInternet() async {
    await HelperFunctions.checkInternetConnection().then((value) {
      if (value) {
        //sync data to server
        print("Sync data to server");
        reportsBox = Hive.box<DriverReport>(AppConstants.reportsBox);

        mockData.addAll(reportsBox.values.toList() as List<DriverReport>);
        //mockData.add(mockBox.get("0"));
        for (DriverReport item in mockData) {
          print("Items : ${item.thumbnailImage}");
          filePath = item.thumbnailImage;
        }

        //mockData.addAll(mockBox.values.toList());
        // mockData.add(mockBox.values.toList());
        Get.snackbar(
          'Internet status',
          "Connected",
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        //sync data to server
        print("Save data to local storage");
        Get.snackbar(
          'Internet status',
          "Not Connected",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    });
  }
}
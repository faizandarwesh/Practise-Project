import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:in_app_camera/controller/reports_controller.dart';
import 'package:in_app_camera/utils/app_constants.dart';
import 'package:in_app_camera/utils/cupertino_alert_dialog.dart';
import 'package:in_app_camera/utils/helper_functions.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../model/driver_report.dart';

class DisplayPictureScreen extends StatefulWidget {
  final String imagePath;
  final int index;
  final double? latitude;
  final double? longitude;
  final String? currentTimeStamp;

  const DisplayPictureScreen(
      {Key? key,
      required this.imagePath,
      required this.index,
      this.latitude,
      this.longitude,
      this.currentTimeStamp})
      : super(key: key);

  @override
  _DisplayPictureScreenState createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  GlobalKey globalKey = GlobalKey();

  final _reportsController = Get.find<ReportsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Display the Picture'),
        actions: [
          IconButton(
              onPressed: _save, icon: const Icon(Icons.save_alt))
        ],
      ),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: SizedBox(
        width: double.infinity,
        child: RepaintBoundary(
          key: globalKey,
          child: Stack(
            children: [
              SizedBox(
                  width: double.infinity,
                  child: Image.file(
                    File(widget.imagePath),
                    fit: BoxFit.cover,
                  )),
              Positioned(
                  right: 4,
                  top: 4,
                  child: GestureDetector(
                    onTap: () async {
                      /* await MapLauncher.showMarker(
                      mapType: MapType.google,
                      coords: Coords(widget.latitude!,widget.longitude!),
                      title: "Genetech Solutions",
                      description: "My workplace",
                      );*/

                      await MapLauncher.showDirections(
                        destination: Coords(24.8845952, 67.0663169),
                        origin: Coords(widget.latitude!, widget.longitude!),
                        mapType: MapType.google,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      color: Colors.black.withOpacity(0.5),
                      child: Text(
                        "Latitude : ${widget.latitude} \n Longitude : ${widget.longitude} \n Timestamp : ${widget.currentTimeStamp}",
                        textAlign: TextAlign.right,
                        style: const TextStyle(color: Colors.blue),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  saveDataToLocalDb(String imagePath) {
    Box reportsBox = Hive.box<DriverReport>(AppConstants.reportsBox);

    reportsBox.put(
        _reportsController.reportsData.elementAt(widget.index).taskId,
        DriverReport(
            taskId: _reportsController.reportsData.elementAt(widget.index).taskId,
            driverId: "",
            barcode: _reportsController.reportsData.elementAt(widget.index).barcode,
            driverFullName: "",
            driverType: DriverType.employee.toString(),
            isUploadedToServer: false,
            taskStatus: TaskStatus.completed.toString(),
            thumbnailImage: _reportsController.reportsData.elementAt(widget.index).thumbnailImage,
            answerString: _reportsController.reportsData.elementAt(widget.index).answerString,
            startingTime: _reportsController.reportsData.elementAt(widget.index).startingTime));

    Get.dialog(
        CustomIosDialog(
          title: "Success",
          message: "Record added to the local storage",
        ),
        barrierDismissible: false);

    print("saveDataToLocalDb");
  }

  Future<void> _save() async {
    try {
      RenderRepaintBoundary? boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      //Request permissions if not already granted
      if (!(await Permission.storage.isGranted)) {
        await Permission.storage.request();
      }

      final result =
          await ImageGallerySaver.saveImage(Uint8List.fromList(pngBytes),
              quality: 100,
              // name: 'appName'.tr + DateTime.now().toString(),
              isReturnImagePathOfIOS: true);
      print("Stored image path : ${result.toString()}");
      final imagePath = result['filePath'].toString().replaceAll(RegExp('file://'), '');


      _reportsController.reportsData.elementAt(0).thumbnailImage = imagePath;

      print("Refactored image path : $imagePath");

      //Inorder to store imagePath in local DB

      await HelperFunctions.checkInternetConnection().then((value) {
        if(value){
          //Send data to server
          print("Sending data to server");
          //mockBox.deleteFromDisk(); //To remove data from box
          Get.snackbar(
            'Success',
            "Report submitted to server",
            snackPosition: SnackPosition.BOTTOM,
          );
        }
        else{
          saveDataToLocalDb(imagePath);
          Get.snackbar(
            'Image save status',
            "${result['isSuccess']}",
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      });
    } catch (e) {
      print(e);
    }
  }
}

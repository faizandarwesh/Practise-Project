import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'display_picture_screen.dart';
import 'package:get/get.dart';

class CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  final int index;

  const CameraScreen({required this.cameras,required this.index, Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController controller;
  late XFile file;
  late LocationData _locationData;
  bool _serviceEnabled = false;
  Location location = Location();

  @override
  void initState() {
    super.initState();
    getLocationData();
    controller = CameraController(widget.cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.bottomCenter,
          children: [
            CameraPreview(controller),
            Positioned(
              bottom: 16.0,
              child: FloatingActionButton(
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.black87,
                ),
                backgroundColor: Colors.white,
                onPressed: () async {
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
                    var lat = _locationData.latitude;
                    var lng = _locationData.longitude;

                    file = await controller.takePicture();
                    print("takePicture filePath : ${file.path}");
                    await Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => DisplayPictureScreen(
                            index : widget.index,
                            imagePath: file.path,
                            latitude: lat,
                            longitude: lng,
                            currentTimeStamp: DateFormat(
                                        'E, MMM dd, yyyy  h:mm:ss a')
                                    .format(DateTime.now()) +
                                " GMT ${DateTime.now().timeZoneOffset.inHours}"),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getLocationData() async {
    Location location = Location();
    _locationData = await location.getLocation();
  }
}

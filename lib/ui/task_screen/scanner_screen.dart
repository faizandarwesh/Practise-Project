import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:in_app_camera/controller/reports_controller.dart';
import 'package:in_app_camera/model/driver_report.dart';
import 'package:in_app_camera/model/task_model.dart';
import 'package:in_app_camera/ui/task_screen/questions_screen.dart';
import 'package:in_app_camera/utils/app_constants.dart';
import 'package:get/get.dart';
import '../../main.dart';


class ScannerScreen extends StatefulWidget {
  final int index;

  const ScannerScreen({required this.index, Key? key}) : super(key: key);


  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {


  // ScanMode.BARCODE //Numbers like tissue box code
  // ScanMode.QR //Card Image

  final _reportsController = Get.find<ReportsController>();

  String barcodeValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Code Scanner"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.forward),
        onPressed: (){

          if(barcodeValue.isNotEmpty){
            reportsBox.put(
                mockTasks.elementAt(widget.index).taskId,
                DriverReport(
                    taskId: mockTasks.elementAt(widget.index).taskId,
                    driverId: '',
                    barcode: barcodeValue,
                    driverFullName: '',
                    driverType: "Employee",
                    isUploadedToServer: false,
                    taskStatus: TaskStatus.inProgress.toString(),
                    thumbnailImage: '',
                    answerString: '',
                    startingTime: _reportsController.reportsData.elementAt(0).startingTime));

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>  QuestionsScreen(index: widget.index)));
          }
          else {
            Get.snackbar(
              'Something went wrong',
              "Please provide the QR/Barcode",
              snackPosition: SnackPosition.BOTTOM,
            );
          }


        },
      ),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have to tap for scanning the QR/Barcode',
            ),
            Text(
              'Take scan',
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
                onPressed: () async{
                  String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                      "#000000",
                      "Cancel",
                      true,
                      ScanMode.DEFAULT);

                  print("BARCODE : $barcodeScanRes");
                  if(barcodeScanRes.isNotEmpty && barcodeScanRes != "-1"){
                   setState(() {
                     barcodeValue = barcodeScanRes;
                     _reportsController.reportsData.elementAt(0).barcode = barcodeValue;
                   });
                  }
                },
                child: const Text(
                  'Scan Code',
                ),
              ),
            ),
            const SizedBox(height: 16,),
            barcodeValue != "" ? Text("Scan code value is : $barcodeValue") : const Center()
          ],
        ),
      )
    );
  }

  @override
  void initState() {
    Box reportsBox = Hive.box<DriverReport>(AppConstants.reportsBox);
    if(reportsBox.length > 0 && _reportsController.reportsData.isNotEmpty){
      var report = reportsBox.get(_reportsController.reportsData.elementAt(0).taskId) as DriverReport;
      barcodeValue =  report.barcode ?? "";
    }


    super.initState();
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';


class ScannerScreen extends StatefulWidget {
  const ScannerScreen({Key? key}) : super(key: key);

  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {


  // ScanMode.BARCODE //Numbers like tissue box code
  // ScanMode.QR //Card Image

  String barcodeValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Code Scanner"),
      ),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have to tap for scanning the QR/Barcode',
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
                onPressed: () async{
                  String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                      "#000000",
                      "Cancel",
                      true,
                      ScanMode.BARCODE);

                  print("BARCODE : $barcodeScanRes");
                  if(barcodeScanRes.isNotEmpty){
                   setState(() {
                     barcodeValue = barcodeScanRes;
                   });
                  }
                },
                child: const Text(
                  'Scan Code',
                ),
              ),
            ),
            const SizedBox(height: 16,),
            barcodeValue != "" ? Text("Barcode value is : $barcodeValue") : const Center()
          ],
        ),
      )
    );
  }

}
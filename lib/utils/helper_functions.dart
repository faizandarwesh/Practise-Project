import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class HelperFunctions {
  static Future<bool> checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected to Internet');
      }
      return true;
    } on SocketException catch (_) {
      print('not connected');
      return false;
    }
  }

  static void showSnackBar(String message,String status){
    Get.snackbar(
      '',
      '',
      snackPosition: SnackPosition.BOTTOM,
      snackStyle: SnackStyle.FLOATING,
      messageText: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
      titleText: Container(),
      margin: const EdgeInsets.only(bottom: kBottomNavigationBarHeight, left: 8, right: 8),
      padding: const EdgeInsets.only(bottom: 4, left: 16, right: 16),
      borderRadius: 4,
      backgroundColor: Colors.black54,
      colorText:Colors.white,
      mainButton: TextButton(
        child: Text(status),
        onPressed: () {},
      ),
    );
  }
}

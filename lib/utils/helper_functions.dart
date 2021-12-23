import 'dart:io';

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
}

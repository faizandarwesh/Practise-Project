import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MapsWebView extends StatefulWidget {
  const MapsWebView({Key? key}) : super(key: key);

  @override
  _MapsWebViewState createState() => _MapsWebViewState();
}

class _MapsWebViewState extends State<MapsWebView> {

  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Google Maps'),
        ),
        body: const SafeArea(
          child: WebView(
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: 'https://goo.gl/maps/5fF7uCvYtRpmbpXv6',
          ),
        ),
    );
  }
}

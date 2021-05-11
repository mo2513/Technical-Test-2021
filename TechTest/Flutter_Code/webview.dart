import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class webView extends StatefulWidget {


  @override
  _webViewState createState() => _webViewState();
}

class _webViewState extends State<webView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profiles!',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        shadowColor: Colors.red,
      ),
    body: WebView(
      initialUrl: 'https://saloneverywhere.com/sample-profiles',
    ),

    );
  }
}

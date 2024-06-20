import 'package:flutter/material.dart';
import 'package:fyp/components/custom_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  late WebViewController controller;

  @override
  void initState() {

    loadPage();

    super.initState();
  }

  void loadPage(){

    controller =  WebViewController()..setJavaScriptMode(JavaScriptMode.disabled)
      ..loadRequest(Uri.parse('https://www.freeprivacypolicy.com/live/f9897aaf-7579-485d-92d3-a98a9e69536e'));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'About Us',context: context),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: WebViewWidget(controller: controller),
      ),
    );
  }
}

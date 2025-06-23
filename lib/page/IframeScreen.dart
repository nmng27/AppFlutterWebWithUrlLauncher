import 'package:app_view/model/url.dart';
import 'package:app_view/widget/CardIframe.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class IframeScreen extends StatefulWidget{
  final List<Url> urls;
  const IframeScreen({Key? key, required this.urls}):super(key: key);

  @override
  State<StatefulWidget> createState() => _IframeScreen();
}

class _IframeScreen extends State<IframeScreen>{
  @override
  void initState() {
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Cardiframe(urls: widget.urls),
    );
  }
}
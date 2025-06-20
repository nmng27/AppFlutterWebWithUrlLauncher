// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app_view/controller/url_controller.dart';
import 'package:app_view/model/url.dart';
import 'package:app_view/model/url_json.dart';

class IframeWidget extends StatelessWidget {
  const IframeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      return const Center(
        child: Text("Este widget funciona apenas no Flutter Web."),
      );
    }

    final List<Url> urls = UrlController().transformJson(UrlJson);

    return ListView.builder(
      itemCount: urls.length,
      itemBuilder: (context, index) {
        final url = urls[index];
        final String viewId = 'iframe_$index';

        // ignore: undefined_prefixed_name
        ui.platformViewRegistry.registerViewFactory(
          viewId,
          (int viewId) => html.IFrameElement()
            ..src = url.url
            ..style.border = 'none'
            ..width = '100%'
            ..height = '100%',
        );

        

        if (index == 0) {
          return SizedBox(
            width: MediaQuery.of(context).size.width*1.0,
            height: MediaQuery.of(context).size.height*0.5,
            child: HtmlElementView(viewType: viewId),
          );
        } else if(index == 1 || index == 2){
          return Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width *0.5,
                height: MediaQuery.of(context).size.height * 0.5,
                child: HtmlElementView(viewType: viewId),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.5,
              )
            ],
          );
        }
      },
    );
  }
}

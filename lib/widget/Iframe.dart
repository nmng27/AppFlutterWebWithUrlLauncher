import 'package:app_view/controller/url_controller.dart';
import 'package:app_view/model/url.dart'; // Assuming this is your Url model
import 'package:app_view/model/url_json.dart'; // Assuming this is your JSON data source
import 'package:flutter/material.dart'; // Import material.dart for Column/Scaffold
import 'package:flutter/widgets.dart'; // Already imported, but good practice
import 'package:get/get.dart';
import 'dart:html' as html;

class IframeWidget extends StatefulWidget {
  const IframeWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _IframeWidget();
}

class _IframeWidget extends State<IframeWidget> {
  var urls = []; 
  bool _isLoading = true; 

  @override
  void initState() {
    super.initState(); 
    _loadUrls();
  }

  void _loadUrls() {
    
    UrlController controller = Get.put(UrlController());
    setState(() {
      urls = controller.transformJson(UrlJson);
      _isLoading = false; 
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // List to hold the generated iframe widgets
    List<Widget> iframeWidgets = [];

   
    if (urls.isNotEmpty) {
      // First iframe (item 0)
      iframeWidgets.add(
        SizedBox(
          width: size.width * 1.0,
          height: size.height * 0.5, 
          child: HtmlElementView.fromTagName(
            tagName: "iframe",
            onElementCreated: (element) {
              if (element is html.IFrameElement) {
                element.src = urls[0].url;
                element.allowFullscreen = true; 
                element.style.border = 'none'; 
              }
            },
          ),
        ),
      );
    }

    
    if (urls.length >= 3) { 
      iframeWidgets.add(
        Row(
          children: [
            Expanded( 
              child: SizedBox(
                height: size.height * 0.45, // Adjusted height
                child: HtmlElementView.fromTagName(
                  tagName: "iframe",
                  onElementCreated: (element) {
                    if (element is html.IFrameElement) {
                      element.src = urls[1].url;
                      element.allowFullscreen = true;
                      element.style.border = 'none';
                    }
                  },
                ),
              ),
            ),
            Expanded( 
              child: SizedBox(
                height: size.height * 0.45, 
                child: HtmlElementView.fromTagName(
                  tagName: "iframe",
                  onElementCreated: (element) {
                    if (element is html.IFrameElement) {
                      element.src = urls[2].url;
                      element.allowFullscreen = true;
                      element.style.border = 'none';
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      );
    } else if (urls.length == 2) {
      
    }


    
    return Column(
      children: iframeWidgets,
    );
  }
}
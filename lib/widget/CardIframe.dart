import 'package:flutter/widgets.dart';
import 'package:app_view/model/url.dart';
import 'dart:html' as html;

class Cardiframe extends StatefulWidget {
  final List<Url> urls;

  const Cardiframe({Key? key, required this.urls}) : super(key: key);

  @override
  State<Cardiframe> createState() => _CardiframeState();
}

class _CardiframeState extends State<Cardiframe> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ListView.builder(
      itemCount: widget.urls.length,
      itemBuilder: (context, index) {
        Url url = widget.urls[index];

        if (url.status == 1) {
          // Renderiza um iframe grande
          return HtmlElementView.fromTagName(
            tagName: 'iframe',
            onElementCreated: (element) {
              if (element is html.IFrameElement) {
                element.src = url.url;
                element.width = (size.width).toString();
                element.height = (size.height * 0.8).toString();
                element.allowFullscreen = true;
                element.style.border = 'none';
              }
            },
          );
        } else if (url.status == 2 && index + 1 < widget.urls.length) {
          // Renderiza dois iframes lado a lado com URLs diferentes
          Url url1 = widget.urls[index];
          Url url2 = widget.urls[index + 1];

          // Importante: ignorar o próximo item no loop para não repetir
          widget.urls.removeAt(index + 1);

          return Row(
            children: [
              Expanded(
                child: HtmlElementView.fromTagName(
                  tagName: 'iframe',
                  onElementCreated: (element) {
                    if (element is html.IFrameElement) {
                      element.src = url1.url;
                      element.width = (size.width * 0.5).toString();
                      element.height = (size.height * 0.4).toString();
                      element.allowFullscreen = true;
                      element.style.border = 'none';
                    }
                  },
                ),
              ),
              Expanded(
                child: HtmlElementView.fromTagName(
                  tagName: 'iframe',
                  onElementCreated: (element) {
                    if (element is html.IFrameElement) {
                      element.src = url2.url;
                      element.width = (size.width * 0.5).toString();
                      element.height = (size.height * 0.4).toString();
                      element.allowFullscreen = true;
                      element.style.border = 'none';
                    }
                  },
                ),
              ),
            ],
          );
        } else {
          // Se não atender nenhuma condição, retorna espaço vazio
          return const SizedBox.shrink();
        }
      },
    );
  }
}

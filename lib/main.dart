import 'package:app_view/controller/url_controller.dart';
import 'package:app_view/model/url.dart';
import 'package:app_view/page/IframeScreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<List<Url>> fetchUrls() async {
    UrlController controller = Get.put(UrlController());
    final dio = Dio();
    final response = await dio.get("http://127.0.0.1:8000/urls");
    return controller.transformJson(response.data);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Web Iframe',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder<List<Url>>(
        future: fetchUrls(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              body: Center(child: Text('Erro: ${snapshot.error}')),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Scaffold(
              body: Center(child: Text('Nenhuma URL encontrada')),
            );
          } else {
            return IframeScreen(urls: snapshot.data!);
          }
        },
      ),
    );
  }
}

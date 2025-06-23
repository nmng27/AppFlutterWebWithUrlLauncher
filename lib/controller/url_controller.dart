import 'package:app_view/model/url.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlController extends GetxController{
  Future<void> openUrl(String url) async {
    Uri uriParse = Uri.parse(url);
    if (await canLaunchUrl(uriParse)) {
      launchUrl(uriParse, mode: LaunchMode.externalApplication);
    }
  }

  List<Url> transformJson(List<Map<String, dynamic>> json) {
    return json.map((item) => Url(
      item["url"],
      item["status"]
      
    )).toList();
  }
}
import 'package:url_launcher/url_launcher.dart';

abstract class UrlHandler {
  void openchUrl(String uri);
}

class UrlLauncher extends UrlHandler {
  @override
  void openchUrl(String uri) {
    launchUrl(Uri.parse(uri), mode: LaunchMode.externalApplication);
  }
}

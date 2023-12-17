import 'package:url_launcher/url_launcher.dart';

abstract class UrlHandler {
  Future<void> openUrl(String uri);
}

class UrlLauncher extends UrlHandler {
  @override
  Future<void> openUrl(String url) async {
    launchUrl(Uri.parse(url), mode: LaunchMode.inAppWebView);
  }
}

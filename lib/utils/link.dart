import 'package:url_launcher/url_launcher.dart';

class Link {
  static privacy() {
    openLink(
        "https://wholesale-grape-f4f.notion.site/Privacy-Policy-63704be7796f45b599359c0ef8218b50");
  }

  static terms() {
    openLink(
        "https://wholesale-grape-f4f.notion.site/Terms-and-conditions-fe31123de7ea42069ea732ddb53a0e90");
  }

  static assistance() {
    openLink("mailto:beyondx.team@gmail.com?subject=xplore help&body=");
  }

  static openLink(String link) async {
    final Uri _url = Uri.parse(link);

    if (await canLaunchUrl(_url)) {
      await launchUrl(_url);
    }
  }
}

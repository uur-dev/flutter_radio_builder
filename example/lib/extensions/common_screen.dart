import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

mixin CommonScreen {
  Scaffold getScreen({
    required String title,
    required Widget body,
    bool includeWaterMark = false,
  }) {
    final link = "https://uur-dev.com/";
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: body,
      floatingActionButton: includeWaterMark
          ? TextButton(onPressed: () async {
            await _openLink(link);
          }, child: Text(link))
          : null,
    );
  }

  final List<String> options = const [
    "Option 1",
    "Option 2",
    "Option 3",
    "Option 4",
  ];

  Future<void> navigatePage({
    required BuildContext context,
    required Widget page,
  }) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );

    return;
  }

  Future<void> _openLink(String url) async {
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication, // ✅ Mobile pe default browser
    )) {
      /// Do Nothing in case of error
    }
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

void _downloadFile() async {
  String fileUrl = 'hari.pdf';
  Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
  String filePath = 'file://${appDocumentsDirectory.path}/$fileUrl';
  launchUrl(
    Uri.parse(filePath),
    mode: LaunchMode.platformDefault,
  );
}

ElevatedButton elevatedButton =
    ElevatedButton(onPressed: _downloadFile, child: Text('Download File'));

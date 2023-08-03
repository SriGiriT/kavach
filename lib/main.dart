import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_aws_s3_client/flutter_aws_s3_client.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

void aws() async {
  final AwsS3Client s3client = AwsS3Client(
      region: 'ap-south-1',
      // host: 'cyberuser',
      bucketId: 'securelykavach',
      accessKey: 'AKIA33FHZNAJ3OOWXWXB',
      secretKey: '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');
  // final listBucketResult =
  //     await s3client.listObjects(prefix: "dir/dir2/", delimiter: "/");
  // print(listBucketResult.toString());

  final response = await s3client.getObject("ex.json");
  s3client
      .getObject('ex.json')
      .then((value) => print('done'))
      .onError((error, stackTrace) => print('cannot fetch '));
}

void main() async {
  // aws();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kavach',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const MainDashboard(title: 'Vulnerability Management Dashboard'),
    );
  }
}

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key, required this.title});
  final String title;

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
    );
  }
}

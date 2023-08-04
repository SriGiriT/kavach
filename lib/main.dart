import 'dart:convert';
import 'dart:io';

import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:kavach/util/aws_function.dart';
import 'package:fl_chart/fl_chart.dart';

void main() async {
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

List<String> colors = [
  "BLUE",
  "LIGHT_GREY",
  "RED",
  "YELLOW",
  "RED",
  "GREEN",
  "BLUE",
  "MAGENTA",
  "LIGHT_GREY",
  "LIGHT_GREY",
  "LIGHT_GREY",
  "GREEN",
  "YELLOW",
  "BLUE",
  "LIGHT_GREY",
  "GREEN",
  "YELLOW",
  "BLUE",
  "LIGHT_GREY",
  "GREEN",
  "YELLOW",
  "BLUE",
  "LIGHT_GREY",
  "GREEN",
  "YELLOW",
  "BLUE",
  "BLUE",
  "BLUE",
  "BLUE",
  "GREEN",
  "BLUE",
  "GREEN",
  "BLUE",
  "GREEN",
  "BLUE",
  "GREEN",
  "BLUE",
  "GREEN",
  "BLUE",
  "GREEN",
  "BLUE",
  "GREEN",
  "BLUE",
  "GREEN",
  "BLUE",
  "GREEN",
  "BLUE",
  "GREEN",
  "BLUE",
  "BLUE",
  "BLUE",
  "BLUE",
  "BLUE",
  "BLUE",
  "BLUE",
  "BLUE",
  "BLUE"
];
Map<String, int> calculateWordFrequency(List<String> words) {
  // List<String> words = text.split(' ');
  Map<String, int> count = {};

  for (String word in words) {
    // Remove any punctuation marks or special characters from the word
    word = word.replaceAll(RegExp(r'[^\w\s]'), '');

    if (word.isNotEmpty) {
      if (count.containsKey(word)) {
        count[word] = count[word]! + 1;
      } else {
        count[word] = 1;
      }
    }
  }

  return count;
}

Color convertColorStringToColor(String colorString) {
  switch (colorString.toLowerCase()) {
    case 'red':
      return Colors.red;
    case 'green':
      return Colors.green;
    case 'blue':
      return Colors.blue;
    case 'light_grey':
      return Colors.grey;
    case 'magenta':
      return Color(0xFFFF00FF);
    case 'yellow':
      return Colors.yellow;
    default:
      return Colors.transparent;
  }
}

class _MainDashboardState extends State<MainDashboard> {
  String data = "";
  bool isFetched = false;
  Future<String> getData() async {
    data = await aws('ex.json');
    final file = File('samppple.json');
    await file.writeAsString(data);
    return data;
  }

  List<PieChartSectionData> generatePie(List<String> colors) {
    List<PieChartSectionData> data = [];
    Map<String, int> count = calculateWordFrequency(colors);
    count.forEach((key, value) {
      data.add(PieChartSectionData(
          value: value + 0.0,
          color: convertColorStringToColor(key.toLowerCase())));
    });
    return data;
  }

  String searchValue = "";
  @override
  Widget build(BuildContext context) {
    // Map<String, int> count = calculateWordFrequency(colors);
    // List<PieChartSectionData> piedata = generatePie(count);
    return Scaffold(
      appBar: EasySearchBar(
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
        onSearch: (value) => setState(() {
          searchValue = value;
        }),
        putActionsOnRight: true,
      ),
      // AppBar(
      //   title: Text(
      //     widget.title,
      //     style: TextStyle(color: Colors.white),
      //   ),
      // ),
      body: Center(
        // Text("thest"),
        child: FutureBuilder<String>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else {
              String responseData = snapshot.data!;
              Map<String, dynamic> dataMap = json.decode(responseData);
              List<String> colors = [];
              List<String> basic = [];
              dataMap.forEach((key, value) {
                print('$key');
                basic.add(key);
                value.forEach((key1, value1) {
                  if (key1 == 'lines') {
                    for (dynamic i in value1)
                      i.forEach((key3, value3) {
                        if (key3 == 'colors') {
                          value3.forEach((key4, value4) {
                            colors.add(key4.toString());
                          });
                        }
                      });
                  }
                });
              });

              print(colors);
              return Column(children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: basic.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('${basic[index]}'),
                      );
                    },
                  ),
                ),

                // PieChart(PieChartData(sections: generatePie(colors)))),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: PieChart(
                            PieChartData(sections: generatePie(colors))),
                      )),
                      Expanded(
                          child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container())),
                    ],
                  ),
                )
              ]);
            }
          },
        ),
      ),
    );
  }
}
/*
Column(children: [
              Expanded(child: PieChart(PieChartData(sections: generatePie(count)))),
              Expanded(
                child: Row(
                  children: [
                    Expanded(child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: PieChart(PieChartData(sections: generatePie(count))),
                    )),
                    Expanded(child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container()
                    )),
                  ],
                ),
              )
            ]
            ,) */
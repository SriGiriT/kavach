import 'package:flutter/material.dart';
import 'package:kavach/components/pie_chart.dart';
import 'package:pie_chart/pie_chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kavach',
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
        title: Text(widget.title, style: TextStyle(color: Colors.white),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Row(children: [
              Expanded(child: Padding(
                padding: EdgeInsets.all(20.0),
                child: PieChartWidget( {
      "Flutter": 5,
      "React": 3,
      "Xamarin": 2,
      "Ionic": 2,
      "test": 1
    }, [Colors.red, Color(0xFFE0FFFF), Colors.blue, Colors.green, Color(0xFFFF80FF)]
))),
              Expanded(child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: PieChartWidget(),
              )),
              ],),
            ),
            Expanded(
              child: Row(children: [
              Expanded(child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: PieChartWidget(),
              )),
              Expanded(child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: PieChartWidget(),
              )),
              ],),
            ),
          ],
        ),
      ),
    );
  }
}

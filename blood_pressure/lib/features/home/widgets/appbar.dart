import 'package:blood_pressure/constants/global_variables.dart';
import 'package:blood_pressure/features/home/widgets/blood_page.dart';
import 'package:blood_pressure/features/home/widgets/chart_page.dart';
import 'package:blood_pressure/features/home/widgets/follow_blood_pressure.dart';
import 'package:blood_pressure/provider/user_provider.dart';
import 'package:flutter/material.dart';

class Measure extends StatefulWidget {
  static const String routeName = "/Measure";
  const Measure({Key? key}) : super(key: key);

  @override
  State<Measure> createState() => _MeasureState();
}

class _MeasureState extends State<Measure> {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      color: Color.fromARGB(255, 198, 216, 230),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            title: const Text('Blood Pressure Monitoring'),
            backgroundColor: Color.fromARGB(117, 100, 193, 234),
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: 'Enter Blood Pressure',
                  icon: Icon(Icons.home),
                ),
                Tab(text: 'History', icon: Icon(Icons.directions_transit)),
              ],
            ),
          ),
          body: const TabBarView(
            children: [BloodPage(), ChartPage()],
          ),
        ),
      ),
    );
  }
}

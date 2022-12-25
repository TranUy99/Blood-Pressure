import 'package:blood_pressure/features/home/services/blood_pageServices.dart';
import 'package:blood_pressure/models/chartData.dart';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartPage extends StatefulWidget {
  static const String routeName = '/chart-page';

  const ChartPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  String parseDate(date) {
    DateTime time = DateTime.parse(date);
    DateTime dt2 = time.add(const Duration(hours: 7));
    String hour = dt2.hour.toString();
    String minute = dt2.minute.toString();
    if (dt2.hour < 10) {
      hour = '0$hour';
    }
    if (dt2.minute < 10) {
      minute = '0$minute';
    }
    return '$hour:$minute, ${dt2.day}/${dt2.month}/${dt2.year}';
  }

  String parseday(date) {
    DateTime time = DateTime.parse(date);
    DateTime dt2 = time.add(const Duration(hours: 7));
    String hour = dt2.hour.toString();
    String minute = dt2.minute.toString();
    if (dt2.hour < 10) {
      hour = '0$hour';
    }
    if (dt2.minute < 10) {
      minute = '0$minute';
    }
    return '${dt2.day}/${dt2.month}/${dt2.year}';
  }

  @override
  void initState() {
    super.initState();
    BloodPageService().chartBloodPressure(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(117, 100, 193, 234),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
              color:  Color.fromARGB(255, 184, 242, 243),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              )),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
                  children: [
             FutureBuilder<List<ChartData>>(
                future: BloodPageService().chartBloodPressure(context),
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    return Align(
                      alignment: Alignment.topCenter,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 20),
                              child: FutureBuilder(
                                  future: BloodPageService()
                                      .chartBloodPressure(context),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return SfCartesianChart(
                                        primaryXAxis: CategoryAxis(),
                                        title: ChartTitle(
                                            text: 'Chart Data Blood Pressure'),
                                        series: <ChartSeries<ChartData, String>>[
                                          LineSeries(
                                            dataSource: snapshot.data!,
                                            xValueMapper: (ChartData chartdata,
                                                    _) =>
                                                parseday(
                                                        chartdata.date.toString())
                                                    .toString(),
                                            yValueMapper:
                                                (ChartData chartdata, _) =>
                                                    chartdata.sys,
                                          ),
                                          LineSeries(
                                            dataSource: snapshot.data!,
                                            xValueMapper: (ChartData chartdata,
                                                    _) =>
                                                parseday(
                                                        chartdata.date.toString())
                                                    .toString(),
                                            yValueMapper:
                                                (ChartData chartdata, _) =>
                                                    chartdata.dia,
                                          ),
                                          LineSeries(
                                            dataSource: snapshot.data!,
                                            xValueMapper: (ChartData chartdata,
                                                    _) =>
                                                parseday(
                                                        chartdata.date.toString())
                                                    .toString(),
                                            yValueMapper:
                                                (ChartData chartdata, _) =>
                                                    chartdata.pulse,
                                          )
                                        ],
                                      );
                                    } else {
                                      return CircularProgressIndicator();
                                    }
                                  }),
                            ),
                            Container(
                                child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: const [
                                  Text(
                                    'Index:',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 11, 11, 11)),
                                  ),
                                  Text(
                                    'Sys-----:',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                  Text(
                                    'Dia-----',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 160, 79, 87)),
                                  ),
                                  Text(
                                    'Pulse-----',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 154, 3, 3)),
                                  ),
                                ],
                              ),
                            )),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'The history:',
                                  style: TextStyle(fontSize: 15),
                                ),
                                ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      child: Column(
                                        children: [
                                          Text(
                                            (parseDate(
                                                snapshot.data?[index].date)),
                                            style: const TextStyle(
                                                color:
                                                    Color.fromARGB(255, 7, 7, 7),
                                                fontSize: 18),
                                          ),
                                          Text(
                                              'Blood Pressure:${snapshot.data?[index].sys}/${snapshot.data?[index].dia}'),
                                          Text(
                                              'Pulse:${snapshot.data?[index].pulse}'),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                })
          
                  ],
                ),
          )),
    );
  }
}

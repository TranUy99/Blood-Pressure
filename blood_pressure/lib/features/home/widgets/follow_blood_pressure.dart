import 'package:flutter/material.dart';

class FollowBloodPressure extends StatefulWidget {
  final double sys;
  final double dia;
  final double pulse;
  const FollowBloodPressure(
      {Key? key, required this.sys, required this.dia, required this.pulse})
      : super(key: key);

  @override
  State<FollowBloodPressure> createState() => _FollowBloodPressureState();
}

class _FollowBloodPressureState extends State<FollowBloodPressure> {
  DateTime now = DateTime.now();
  String parseDate(date) {
    DateTime dt2 = now.add(const Duration(hours:0));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Follow The Blood Pressure'),
        backgroundColor: const Color.fromARGB(66, 134, 167, 225),
      ),
      backgroundColor:  Color.fromARGB(255, 184, 242, 243),
      body: SingleChildScrollView(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'The result just measured',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 15, 14, 14),
                      ),
                    ),
                    Text(parseDate(now)),
                  ],
                ),
                const SizedBox(height: 16),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        child: Card(
                          color: Color.fromARGB(255, 139, 235, 240),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                const Text(
                                  'Blood Pressure',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 15, 14, 14),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  '${widget.sys.toString()}/${widget.dia.toString()}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 10, 131, 237),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const VerticalDivider(
                        color: Colors.black54, //color of divider
                        width: 10, //width space of divider
                        thickness: 2, //thickness of divier line
                        indent: 10, //Spacing at the top of divider.
                        endIndent: 10, //Spacing at the bottom of divider.
                      ),
                      Expanded(
                        child: Card(
                          color: Color.fromARGB(255, 139, 235, 240),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                const Text(
                                  'Pulse',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 15, 14, 14),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  widget.pulse.toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 10, 131, 237),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Card(
                        color: Color.fromARGB(255, 191, 227, 229),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              if (widget.sys > 89 &&
                                  widget.sys <= 120 &&
                                  widget.dia > 59 &&
                                  widget.dia <= 80)
                                const Text(
                                  'Ideal Blood Pressure.Do not forget to check your measurements every day!!',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 38, 200, 17),
                                  ),
                                ),
                              if (widget.sys < 90 || widget.dia < 60)
                                const Text(
                                  'Low Blood Pressure.You need to rest',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 103, 15, 209),
                                  ),
                                ),
                              if (widget.sys > 120 || widget.dia > 90)
                                const Text(
                                  'High Blood Pressure.You need to rest',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 218, 7, 7),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

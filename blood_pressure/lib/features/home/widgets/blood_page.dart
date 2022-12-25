import 'package:blood_pressure/common/widgets/custom_button.dart';
import 'package:blood_pressure/features/home/services/blood_pageServices.dart';
import 'package:blood_pressure/features/home/widgets/follow_blood_pressure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

class BloodPage extends StatefulWidget {
  static const String routeName = '/BloodPage';
  const BloodPage({Key? key}) : super(key: key);

  @override
  State<BloodPage> createState() => _BloodPageState();
}

class _BloodPageState extends State<BloodPage> {
  final BloodPageService bloodPageService = BloodPageService();
  double sys = 70;
  double dia = 60;
  double pulse = 40;

  void bloodData() {
    BloodPageService().bloodData(
      context,
      sys,
      dia,
      pulse,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 184, 242, 243),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: const [
                  Text(
                    'Cardiologists recommend resting for at least 15 minutes before measuring',
                    style: TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(255, 233, 17, 17),
                      fontFamily: 'Regular',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Column(
                children: const [
                  Text(
                    'Enter 3 blood pressure readings',
                    style: TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(255, 13, 13, 13),
                      fontFamily: 'Regular',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(10),
                child: SpinBox(
                  max: 300,
                  value: sys,
                  decimals: 1,
                  decoration: const InputDecoration(labelText: 'Systolic'),
                  onChanged: (value) {
                    setState(() {
                      sys = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: SpinBox(
                  max: 200,
                  value: dia,
                  min: 1,
                  decimals: 1,
                  decoration: const InputDecoration(labelText: 'Diastolic'),
                  onChanged: (value) {
                    setState(() {
                      dia = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: SpinBox(
                  max: 250,
                  value: pulse,
                  min: 40,
                  decimals: 1,
                  decoration: const InputDecoration(labelText: 'Pulse'),
                  onChanged: (value) {
                    setState(() {
                      pulse = value;
                    });
                  },
                ),
              ),
              CustomButton(
                text: 'Save',
                color: Color.fromARGB(31, 177, 80, 148),
                onTap: () {
                  bloodData();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FollowBloodPressure(
                            sys: sys, dia: dia, pulse: pulse)),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

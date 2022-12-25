import 'package:blood_pressure/constants/global_variables.dart';
import 'package:blood_pressure/features/appointment/screen/appointment.dart';
import 'package:blood_pressure/features/home/widgets/appbar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 128, 204, 223),
      body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 147, 180, 226),
          ),
          child: ListView(
            children: [
              Stack(children: [
                Image.asset(
                  'assets/images/doctor.png',
                )
              ]),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Category',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: SizedBox(
                        height: 300,
                        child: GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 8,
                          childAspectRatio: 1.50,
                          children: [
                            _selectedCategor(
                              image: 'assets/icons/do huyet ap.png',
                              name: 'Blood Pressure',
                              destination: 0,
                            ),
                            _selectedCategor(
                              image: 'assets/images/actives.jpeg',
                              name: 'Appointment',
                              destination: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Widget _selectedCategor({
    required String image,
    required String name,
    required int destination,
  }) {
    return GestureDetector(
      onTap: () {
        if (destination == 0) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Measure()));
        }
        if (destination == 1) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Appointment()));
        }
      },
      child: Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 180, 223, 241),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: GlobalVariables.orangeAccent, width: 2)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(image))),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              name,
              style: const TextStyle(fontSize: 17),
            )
          ],
        ),
      ),
    );
  }
}

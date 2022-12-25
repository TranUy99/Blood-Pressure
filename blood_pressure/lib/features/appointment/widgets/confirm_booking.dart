import 'package:blood_pressure/common/widgets/bottom_bar.dart';
import 'package:blood_pressure/common/widgets/custom_button.dart';
import 'package:blood_pressure/constants/global_variables.dart';
import 'package:blood_pressure/features/appointment/screen/appointment.dart';
import 'package:blood_pressure/features/appointment/services/appointment_services.dart';
import 'package:blood_pressure/features/home/screens/home_screens.dart';
import 'package:blood_pressure/models/doctor.dart';

import 'package:flutter/material.dart';

class confirm_booking extends StatefulWidget {
  final String doctorId;
  final String doctorName;
  final String address;
  final String phonenumber;
  final String date;
  final String timeType;
  const confirm_booking({
    super.key,
    required this.doctorId,
    required this.doctorName,
    required this.address,
    required this.phonenumber,
    required this.date,
    required this.timeType,
  });

  @override
  State<confirm_booking> createState() => _confirm_bookingState();
}

class _confirm_bookingState extends State<confirm_booking> {
  var doctorId;
  var timeType;
  var date;
  final bool isAvailable = true;
  void booking() {
    AppointmentServices()
        .booking(context, doctorId, timeType, date, isAvailable);
  }

  void updateSchedule() {
    AppointmentServices()
        .updateSchedule(context, doctorId, timeType, date, isAvailable);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color.fromARGB(96, 96, 91, 188),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: Container(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/confirm.png',
              width: 1000,
              height: 300,
            ),
            const Text(
              'Thank you for booking our services',
              style: TextStyle(
                  color: Color.fromARGB(255, 241, 16, 4), fontSize: 18),
            ),
            const Text(
              'Booking Information',
              style: TextStyle(
                  color: Color.fromARGB(255, 31, 63, 80), fontSize: 15),
            ),
            Column(
              children: [
                Text('${widget.doctorName}'),
                const SizedBox(height: 10),
                Text('${widget.address}'),
                const SizedBox(height: 10),
                Text('${widget.phonenumber}'),
                const SizedBox(height: 10),
                Text('${widget.date}'),
                const SizedBox(height: 10),
                Text('${widget.timeType}'),
              ],
            ),
            CustomButton(
              text: "Confirm",
              onTap: () {
                setState(() {
                  doctorId = widget.doctorId;
                  timeType = widget.timeType;
                  date = widget.date;
                });
                booking();
                updateSchedule();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BottomBar(),
                  ),
                );
              },
            )
          ],
        ),
      )),
    );
  }
}

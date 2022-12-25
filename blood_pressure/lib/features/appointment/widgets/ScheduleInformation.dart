import 'package:blood_pressure/common/widgets/custom_button.dart';
import 'package:blood_pressure/features/appointment/services/appointment_services.dart';
import 'package:blood_pressure/features/appointment/widgets/confirm_booking.dart';

import 'package:blood_pressure/models/doctor.dart';
import 'package:blood_pressure/models/schedule.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DoctorDetailPage extends StatefulWidget {
  final String doctorId;
  final String doctorName;
  final String address;
  final String phonenumber;
  // final String isAvailable;
  const DoctorDetailPage({
    super.key,
    required this.doctorId,
    required this.doctorName,
    required this.address,
    required this.phonenumber,
    // required this.isAvailable
  });

  @override
  State<DoctorDetailPage> createState() => _DoctorDetailPageState();
}

class _DoctorDetailPageState extends State<DoctorDetailPage> {
  String date = DateFormat("dd/MM/yyyy").format(DateTime.now());
  void _shoDataPicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime(2025))
        .then((value) {
      setState(() {
        date = DateFormat("dd/MM/yyyy").format(value!);
      });
    });
  }

  var timeType;
  var selectedCard = -1;

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
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 150,
              child: Column(children: [
                Text('Doctor Name: ${widget.doctorName}'),
                Text('Address:  ${widget.address}'),
                Text('Phone Number: ${widget.phonenumber}')
              ]),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 208, 224, 231),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  )),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: FutureBuilder<List<Schedule>>(
                  future: AppointmentServices()
                      .Schedules(context, widget.doctorId, date),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MaterialButton(
                            onPressed: _shoDataPicker,
                            child: const Padding(
                              padding: EdgeInsets.all(20),
                              child: Text(
                                'Choose Date',
                                style: TextStyle(
                                  color: Colors.amber,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            date,
                            style: TextStyle(fontSize: 20),
                          ),
                          ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedCard = index;
                                            timeType=
                                                snapshot.data![index].timeType!;
                                          });
                                        },
                                        child: Card(
                                          color: selectedCard == index
                                              ? Color.fromARGB(
                                                  255, 131, 189, 237)
                                              : Color.fromARGB(
                                                  255, 170, 231, 137),
                                          margin: const EdgeInsets.all(8),
                                          shadowColor: Color.fromARGB(
                                              255, 214, 123, 104),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              const Padding(
                                                  padding: EdgeInsets.all(8)),
                                              Text(snapshot
                                                  .data![index].timeType!)
                                                                  ],
                                                                ),
                                                              )),
                                                        
                                                        ],
                                                      );
                                                    }),
                                              ],
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                              const SizedBox(height: 10),
                                                        CustomButton(
                                                            text: 'Make appointment',
                                                            onTap: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          confirm_booking(
                                                                            doctorId:
                                                                                widget.doctorId,
                                                                            doctorName:
                                                                                widget.doctorName,
                                                                            address: widget.address,
                                                                            phonenumber:
                                                                                widget.phonenumber,
                                                                            date: date,
                                                                            timeType: timeType,
                                                                          )));
                                                            })
          ],
        ),
      ),
    );
  }
}

import 'package:blood_pressure/constants/global_variables.dart';
import 'package:blood_pressure/features/appointment/services/appointment_services.dart';
import 'package:blood_pressure/features/appointment/widgets/ScheduleInformation.dart';
import 'package:blood_pressure/models/doctor.dart';
import 'package:flutter/material.dart';

class Appointment extends StatefulWidget {
  const Appointment({super.key});

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 198, 216, 230),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color.fromARGB(117, 100, 193, 234),
        title: Text("Take Appointment"),
      ),
      body: Container(
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 181, 225, 243),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              height: 60,
              // decoration: BoxDecoration(
              //   color: Colors.white,
              //   borderRadius: BorderRadius.circular(5),
              //   boxShadow: const [
              //     BoxShadow(
              //         color: Colors.black26,
              //         offset: Offset(0, 10),
              //         blurRadius: 15,
              //         spreadRadius: 0),
              //   ],
              // ),
              child: Row(children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: const TextField(
                        maxLines: 1,
                        autofocus: false,
                        style: TextStyle(
                            color: Color.fromARGB(31, 240, 128, 128),
                            fontSize: 20),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'List the doctor..',
                        ),
                        cursorColor: Colors.black),
                  ),
                ),
                // Expanded(
                //   flex: 1,
                //   child: Container(
                //     decoration: BoxDecoration(
                //       color: Color.fromARGB(255, 121, 165, 234),
                //       borderRadius: BorderRadius.circular(5),
                //     ),
                //     child: const Center(
                //       child: Icon(
                //         Icons.search,
                //         color: Colors.white,
                //         size: 25,
                //       ),
                //     ),
                //   ),
                // )
              ]),
            ),
            Container(
              child: FutureBuilder<List<doctor>>(
                future: AppointmentServices().Doctor(context),
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    return Container(
                        child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: InkWell(
                            child: Row(children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Name: ${snapshot.data?[index].doctorName}",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Address:${snapshot.data?[index].address}",
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 39, 187, 88)),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Phone NumBer:${snapshot.data?[index].phonenumber}",
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 39, 187, 88)),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Gender:${snapshot.data?[index].gender}",
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 39, 187, 88)),
                                  )
                                ],
                              )
                            ]),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DoctorDetailPage(
                                            doctorId:
                                                snapshot.data![index].doctorId!,
                                            doctorName: snapshot
                                                .data![index].doctorName!,
                                            address:
                                                snapshot.data![index].address!,
                                            phonenumber: snapshot
                                                .data![index].phonenumber!,
                                          ))).then((value) {
                                setState(() {});
                              });
                            },
                          ),
                        );
                      },
                    ));
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

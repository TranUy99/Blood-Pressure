import 'package:blood_pressure/constants/global_variables.dart';
import 'package:blood_pressure/features/appointment/services/appointment_services.dart';
import 'package:blood_pressure/models/doctor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.backgroundColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor:Color.fromARGB(255, 147, 180, 226),
        title: Text("Chat with Doctor"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ;
        },
        child: Icon(
          Icons.chat,
          color: Colors.white,
        ),
      ),
      body: Container(
        child: Column(
          children: [
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

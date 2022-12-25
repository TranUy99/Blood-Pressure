import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:blood_pressure/common/widgets/custom_button.dart';
import 'package:blood_pressure/constants/global_variables.dart';
import 'package:blood_pressure/features/account/services/account_services.dart';
import 'package:blood_pressure/models/user.dart';
import 'package:blood_pressure/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateProfileScreen extends StatefulWidget {
  final User user;
  const UpdateProfileScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final _submitKey = GlobalKey<FormState>();
  final TextEditingController username = TextEditingController();
  final TextEditingController gender = TextEditingController();
  final TextEditingController phonenumber = TextEditingController();
  final TextEditingController birthday = TextEditingController();
  final TextEditingController address = TextEditingController();
  @override
  void initState() {
    super.initState();
    username.text = widget.user.username;
    gender.text = widget.user.gender;
    phonenumber.text = widget.user.phonenumber;
    birthday.text = widget.user.birthday;
    address.text = widget.user.address;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.orangeAccent,
          title: const Text(
            "Update personal information",
            style: TextStyle(
              fontSize: 23,
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: GlobalVariables.backgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: SingleChildScrollView(
          child: Form(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(20),
                child: Form(
                    key: _submitKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: "User Name:"),
                          controller: username,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: "Gender: Male or Female"),
                          controller: gender,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: "Phone Number:"),
                          controller: phonenumber,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: "Birth Day 00/00/0000:"),
                          controller: birthday,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: "Address:"),
                          controller: address,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        CustomButton(
                            text: "Update Information",
                            onTap: () async {
                              if (_submitKey.currentState!.validate()) {
                                AwesomeDialog(
                                  context: context,
                                  animType: AnimType.SCALE,
                                  dialogType: DialogType.question,
                                  dismissOnTouchOutside: false,
                                  title: 'Update Information?',
                                  btnCancelOnPress: () {},
                                  btnOkOnPress: () {
                                    AccountService().changeProfile(
                                      context: context,
                                      username: username.text,
                                      gender: gender.text,
                                      phonenumber: phonenumber.text,
                                      birthday: birthday.text,
                                      address: address.text,
                                    );
                                  },
                                ).show();
                              }
                            })
                      ],
                    )),
              )
            ],
          )),
        ),
      ),
    );
  }
}

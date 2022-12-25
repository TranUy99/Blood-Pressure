import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:blood_pressure/common/widgets/custom_textfield.dart';
import 'package:blood_pressure/constants/global_variables.dart';
import 'package:blood_pressure/constants/util.dart';
import 'package:blood_pressure/features/account/services/account_services.dart';
import 'package:blood_pressure/features/account/widgets/account_button.dart';
import 'package:blood_pressure/models/user.dart';
import 'package:flutter/material.dart';


class ChangePasswordScreen extends StatefulWidget {
   final User user;
  const ChangePasswordScreen({  Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
    final AccountService accountService = AccountService();
  final _changePassKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController newPassController = TextEditingController();
  final TextEditingController repeatPassController = TextEditingController();
  void changePass() {
    AwesomeDialog(
        context: context,
        animType: AnimType.scale,
        dialogType: DialogType.question,
        dismissOnTouchOutside: false,
        title: 'Confirm change?',
        btnCancelOnPress: (){},
        btnOkOnPress: () {
          accountService.changePassword(
              context: context,
              email: widget.user.email,
              password: passwordController.text,
              repeatPass: repeatPassController.text,
              newPass: newPassController.text);
        }
    ).show();
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      backgroundColor: Colors.orangeAccent,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.orangeAccent,
          title: const Text(
            "Đổi mật khẩu",
            style: TextStyle(
              fontSize: 23,
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: Container(

        width: double.infinity,
        height: double.infinity,

        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
            color: GlobalVariables.backgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            )),

        child: Center(
          child: Form(
            key: _changePassKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: passwordController,
                  hintText: 'Old password',
                 
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: newPassController ,
                  hintText: 'New password',
                
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: repeatPassController,
                  hintText: 'Repeat Password',
                 
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    AccountButton(
                      text: 'Change Password',
                      onTap: () => {
                        if(_changePassKey.currentState!.validate()){
                            if(passwordController.text != newPassController.text){
                              FocusScope.of(context).requestFocus(FocusNode()),
                              changePass()
                            }else{
                              showSnackBar(context, "The new password is the same as the old password")
                            }
                      
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      );
  }
}
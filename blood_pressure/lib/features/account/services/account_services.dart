import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:blood_pressure/common/widgets/bottom_bar.dart';
import 'package:blood_pressure/constants/util.dart';
import 'package:blood_pressure/features/auth/screens/auth_screen.dart';
import 'package:blood_pressure/models/user.dart';
import 'package:blood_pressure/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:blood_pressure/constants/global_variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountService {
  Future<User> getAccount(context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.get(
        Uri.parse('$uri/'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'bearer ${userProvider.user.token}'
        },
      );
      print(userProvider.user.password);
      if (res.statusCode == 200) {
        final parsed = json.decode(res.body).cast<Map<String, dynamic>>();
        return parsed.map<User>((json) => User.fromJson(json)).toList();
      } else {
        throw Exception(res.body);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  void changeProfile({
    required context,
    required username,
    required address,
    required phonenumber,
    required birthday,
    required gender,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.patch(
        Uri.parse('$uri/api/updateAccount'),
        body: jsonEncode({
          'username': username,
          'address': address,
          'phonenumber': phonenumber,
          'birthday': birthday,
          'gender': gender,
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'bearer ${userProvider.user.token}'
        },
      );
      if (res.statusCode == 200) {
        AwesomeDialog(
            context: context,
            animType: AnimType.scale,
            dialogType: DialogType.success,
            dismissOnTouchOutside: false,
            title: 'Update success',
            btnOkOnPress: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const BottomBar()));
            }).show();
      } else {
        throw Exception(res.body);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
  void changePassword({
    required context,
    required String email,
    required String password,
    required String repeatPass,
    required String newPass,
  }) async{
  final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response res = await http.patch(
        Uri.parse('$uri/api/changePassword'),
        body: jsonEncode({
          'email':email,
          'password' : password,
          'repeatPass' : repeatPass,
          'newPass' : newPass,
        }),
         headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'bearer ${userProvider.user.token}'
        },
      );
      if(res.statusCode == 200){
        AwesomeDialog(
            context: context,
            animType: AnimType.scale,
            dialogType: DialogType.success,
            dismissOnTouchOutside: false,
            title: 'Change password successfully',
            btnOkOnPress: () {
                Navigator.pop(context);
            }
        ).show();
      }else if(res.statusCode==404){
        showSnackBar(context, 'Wrong password');
      }else{
        showSnackBar(context, 'Server error');
      }


  }


   void logOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('Authorization', '');
      Navigator.pushNamedAndRemoveUntil(
        context,
        AuthScreen.routeName,
        (route) => false,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}

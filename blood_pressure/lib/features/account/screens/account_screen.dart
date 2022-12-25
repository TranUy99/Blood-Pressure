import 'package:blood_pressure/constants/global_variables.dart';
import 'package:blood_pressure/features/account/services/account_services.dart';
import 'package:blood_pressure/features/account/widgets/account_button.dart';
import 'package:blood_pressure/features/account/widgets/change_password.dart';
import 'package:blood_pressure/features/account/widgets/update_account.dart';
import 'package:blood_pressure/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blood_pressure/models/user.dart';

class AccountSrceen extends StatefulWidget {
  static const String routeName = '/account-screen';
  const AccountSrceen({super.key});

  @override
  State<AccountSrceen> createState() => _AccountSrceenState();
}

class _AccountSrceenState extends State<AccountSrceen> {
  final AccountService accountService = AccountService();
  Future<User> getUser(context, id) async {
    return accountService.getAccount(context);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      backgroundColor: GlobalVariables.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          elevation: 0.0,
          backgroundColor:Color.fromARGB(255, 147, 180, 226),
          title: const Text(
            "Account",
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
        child: FutureBuilder<User>(
            future: AccountService().getAccount(context),
            builder: (context, snapshot) {
              // if (!snapshot.hasData) {
              //   return const Center(
              //        child: CircularProgressIndicator(),
              //       );
              // } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("UserName:",
                              style: TextStyle(
                                  fontSize: 18, fontFamily: 'Regular')),
                          Text(user.username,
                              style: const TextStyle(
                                  fontSize: 18, fontFamily: 'Regular')),
                        ],
                      ),
                      const Divider()
                    ],
                  ),
                  const SizedBox(height: 16),
                  Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text("Email:",
                              style: TextStyle(
                                  fontSize: 18, fontFamily: 'Regular')),
                          Text(user.email,
                              style: const TextStyle(
                                  fontSize: 18, fontFamily: 'Regular')),
                        ],
                      ),
                      const Divider()
                    ],
                  ),
                  const SizedBox(height: 16),
                  Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text("Gender",
                              style: TextStyle(
                                  fontSize: 18, fontFamily: 'Regular')),
                          Text(user.gender,
                              style: const TextStyle(
                                  fontSize: 18, fontFamily: 'Regular')),
                        ],
                      ),
                      const Divider()
                    ],
                  ),
                  const SizedBox(height: 16),
                  Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text("Phone number",
                              style: TextStyle(
                                  fontSize: 18, fontFamily: 'Regular')),
                          Text(user.phonenumber,
                              style: const TextStyle(
                                  fontSize: 18, fontFamily: 'Regular')),
                        ],
                      ),
                      const Divider()
                    ],
                  ),
                  const SizedBox(height: 16),
                  Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text("Birth Day:",
                              style: TextStyle(
                                  fontSize: 18, fontFamily: 'Regular')),
                          Text(user.birthday,
                              style: const TextStyle(
                                  fontSize: 18, fontFamily: 'Regular')),
                        ],
                      ),
                      const Divider()
                    ],
                  ),
                  const SizedBox(height: 16),
                  Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text("Address",
                              style: TextStyle(
                                  fontSize: 18, fontFamily: 'Regular')),
                          Text(user.address,
                              style: const TextStyle(
                                  fontSize: 18, fontFamily: 'Regular')),
                        ],
                      ),
                      const Divider()
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      AccountButton(
                        text: 'Update information',
                        onTap: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      UpdateProfileScreen(user: user))),
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      AccountButton(
                        text: 'Change Password',
                        onTap: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePasswordScreen(user: user,))),
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      AccountButton(
                        text: 'Log Out',
                         onTap: () => AccountService().logOut(context),
                      ),
                    ],
                  ),
                ],
              );
            }),
      ),
    );
  }
}

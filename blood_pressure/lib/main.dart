import 'package:blood_pressure/common/widgets/bottom_bar.dart';
import 'package:blood_pressure/constants/global_variables.dart';
import 'package:blood_pressure/features/auth/screens/auth_screen.dart';
import 'package:blood_pressure/features/auth/services/auth_services.dart';
import 'package:blood_pressure/provider/user_provider.dart';
import 'package:blood_pressure/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService =AuthService();

  @override
  
  void initState() {
    super.initState();
    authService.getUserData(context);
   }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'REMOTE MEDICAte',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
          ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        useMaterial3: true,        
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
      ? const BottomBar() 
      : const AuthScreen(),
    );
  }
}


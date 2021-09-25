import 'package:egovernance/pages/wallet.dart';
import 'package:egovernance/services/main_dashboard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'Screens/Login/loginScreen.dart';
import 'Screens/Signup/signupScreen.dart';
import 'Screens/WelcomeScreen/welcomeScreen.dart';
import 'Screens/mainScreen.dart';
import 'constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

DatabaseReference usersRef =
    FirebaseDatabase.instance.reference().child("users");

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Governance',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: "Brand Bold",
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: Wallet(),
      initialRoute: LoginScreen.idScreen,
      routes: {
        SignupScreen.idScreen: (context) => SignupScreen(),
        LoginScreen.idScreen: (context) => LoginScreen(),
        //Dashboard.idScreen: (context) => Dashboard(),
        MainScreen.idScreen: (context) => MainScreen(),
        // WelcomeScreen.idScreen: (context) => WelcomeScreen(),
        //'/Wallet': (context) => Wallet(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

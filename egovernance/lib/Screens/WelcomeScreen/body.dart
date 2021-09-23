import 'package:egovernance/Screens/Login/loginScreen.dart';
import 'package:egovernance/Screens/Signup/signupScreen.dart';
import 'package:egovernance/Screens/WelcomeScreen/background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants.dart';


class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //This size provides us total height and width of the screen
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
          "Rapido",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32, fontFamily: "Brand Bold"),
          ),
          SvgPicture.asset(
            "images/chat.svg",
            height: size.height * 0.5,
          ),
          SizedBox(height: 60),
          Container(
            width: size.width * 0.8,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: ElevatedButton(onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(
                  builder: (context){
                    return LoginScreen();
                  },
                )
                );
              },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    shadowColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 12),
                  ),
                  child: Text("Login", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: "Brand Bold")),
              ),
            ),
          ),
          SizedBox(height: 25),
          Container(
            width: size.width * 0.6,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: ElevatedButton(onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(
                  builder: (context){
                    return SignupScreen();
                    },
                )
                );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightGreen,
                  shadowColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                ),
                child: Text("SignUp", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, fontFamily: "Brand Bold")),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Don't have an Account?",
              style: TextStyle(color: kPrimaryColor),
              ),
            ],
          )
        ],
      ),
    );
  }
}

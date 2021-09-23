import 'package:egovernance/Screens/WelcomeScreen/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Background(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "SignUp as a Driver",
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: "Brand Bold",
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 55),
              SvgPicture.asset("images/login.svg",
                height: size.height * 0.3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


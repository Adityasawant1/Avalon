import 'package:avalon/theme/colors.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: backgroundColor1,
        width: size.width,
        height: size.height,
        child: Stack(children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: size.height * 0.53,
              width: size.width,
              decoration: BoxDecoration(
                  color: primaryColor,
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/images/login.png",
                    ),
                  )),
            ),
          )
        ]),
      ),
    );
  }
}

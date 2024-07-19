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
        child: Column(
          children: [
            Stack(children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: size.height * 0.53,
                  width: size.width,
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40)),
                      image: const DecorationImage(
                        image: AssetImage(
                          "assets/images/login.png",
                        ),
                      )),
                ),
              )
            ]),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40.0,
              ),
              child: Container(
                child: const Column(
                  children: [
                    Text(
                      "Sustainable Living \nStarts with You",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Work towards an inclusive, sustainable future \nthat benefits both people and the planet",
                      style: TextStyle(
                        fontSize: 13.3,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: size.width * 0.8,
                  height: size.height * 0.08,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.white,
                      ),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 5,
                            spreadRadius: 0.5,
                            color: Colors.grey.withOpacity(0.1))
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            print("Niraj is gay");
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  10), // Add border radius here
                            ),
                            child: const Center(
                                child: Text(
                              "Register",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            )),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            print("chomu is gay");
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              // Ensure there's a color to see the border radius effect
                              borderRadius: BorderRadius.circular(
                                  10), // Add border radius here
                            ),
                            child: const Center(
                                child: Text(
                              "Sign In",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class SocialMediaButton extends StatelessWidget {
  final String imagePath;
  final Color backgroundColor;
  final VoidCallback onpress;

  const SocialMediaButton({
    Key? key,
    required this.imagePath,
    required this.backgroundColor,
    required this.onpress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onpress,
      child: Container(
        height: size.height * 0.08,
        width: size.width * 0.7,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(50),
          boxShadow: const [
            BoxShadow(
              blurRadius: 2,
              spreadRadius: 1,
              color: Colors.grey,
            ),
          ],
        ),
        child: Center(
          child: Image.asset(
            imagePath,
            height: 35,
            width: 35,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  SocialButton({super.key, required this.social,required this.bgColor});
  String social;
  Color bgColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        child: Text("Log in with $social"),
        style: ElevatedButton.styleFrom(backgroundColor: bgColor,),
      ),
    );
  }
}

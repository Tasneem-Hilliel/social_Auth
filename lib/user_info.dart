
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserInfoScreen extends StatelessWidget {
  UserInfoScreen(
    this.imgUrl, {
    super.key,
    required this.num,
    required this.name,
    required this.email,
  });
  String num;
  String name;
  String imgUrl =
      'https://t3.ftcdn.net/jpg/03/53/11/00/360_F_353110097_nbpmfn9iHlxef4EDIhXB1tdTD0lcWhG9.jpg';
  String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                imgUrl,
              ),
              radius: 50,
              backgroundColor: Colors.white10,
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              name,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 14,
            ),
            Text(
              email,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.blueGrey),
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40)),
              onPressed: () async {
                if (num == "1") {
                  GoogleSignIn googleSignIn = GoogleSignIn();
                  googleSignIn.disconnect();
                } else if (num == "2") {
                  FacebookLogin facebookLogin = FacebookLogin();
                  facebookLogin.logOut();
                } else if (num == "3") {
                  //twitter logout
                  // TwitterLogin twitterLogin =
                  //     TwitterLogin(apiKey: "", apiSecretKey: "", redirectURI: "");
                }

                await FirebaseAuth.instance.signOut();
                Navigator.pop(context);
              },
              child: SizedBox(
                width: 110,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Logout",
                      style: TextStyle(fontSize: 20),
                    ),
                    Icon(Icons.logout)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


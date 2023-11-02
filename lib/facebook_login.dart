  import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:social_auth/user_info.dart';

Future signInWithFacebook(context) async {
    try {
      final result =
          await FacebookAuth.i.login(permissions: ['public_profile', 'email']);
      if (result.status == LoginStatus.success) {
        final userData = await FacebookAuth.i.getUserData();

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => UserInfoScreen(
                    userData['picture']['data']['url'],
                    num: "2",
                    name: userData['name'],
                    email: userData['email'],
                  )),
        );
      }
    } catch (error) {
      print(error);
    }
  }

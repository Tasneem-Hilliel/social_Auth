import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sign_button/sign_button.dart';
import 'package:twitter_login/twitter_login.dart';
import 'facebook_login.dart';
import 'google_login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: HomeScreen());
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future signInWithTwitter(context) async {
    final twitterLogin = TwitterLogin(
      // Consumer API keys
      apiKey: '4OnUVrt5keMjYd4a8tXtPnraL',
      // Consumer API Secret keys
      apiSecretKey: 'yvyyBr3LJ9utpINiDnBkplwxwbGtWeWe0AwCZQwEojeHE3Lqi3',
      redirectURI: 'socialAuthAppliction://',
    );
    final authResult = await twitterLogin.login();
    switch (authResult.status) {
      case TwitterLoginStatus.loggedIn:
        print("true");
        // success
        break;
      case TwitterLoginStatus.cancelledByUser:
        print("cancel");
        break;
      case TwitterLoginStatus.error:
        print(authResult.errorMessage);

        print("error"); // error
        break;
      default:
        print("def");
        break;
    }
  }

  Future log(context) async {
    TwitterLogin twitterLogin = TwitterLogin(
      // Consumer API keys
      apiKey: '4OnUVrt5keMjYd4a8tXtPnraL',
      // Consumer API Secret keys
      apiSecretKey: 'yvyyBr3LJ9utpINiDnBkplwxwbGtWeWe0AwCZQwEojeHE3Lqi3',

      redirectURI: 'socialAuthAppliction://',
    );

    await twitterLogin.login().then((value) async {
      print(value.errorMessage);
      final authToken = value.authToken;
      final authTokenSecret = value.authTokenSecret;
      if (authToken != null && authTokenSecret != null) {
        final twitterAuthCredentials = TwitterAuthProvider.credential(
            accessToken: authToken, secret: authTokenSecret);
        await FirebaseAuth.instance
            .signInWithCredential(twitterAuthCredentials);
      }
    });
  }

  Future signWithTwitter() async {
    // Create a TwitterLogin instance
    final twitterLogin = TwitterLogin(
        apiKey: '4OnUVrt5keMjYd4a8tXtPnraL',
        apiSecretKey: 'yvyyBr3LJ9utpINiDnBkplwxwbGtWeWe0AwCZQwEojeHE3Lqi3',
        redirectURI: 'https://social-auth-18de5.firebaseapp.com/__/auth/handler');

    // Trigger the sign-in flow
    final authResult = await twitterLogin.login();
    if (authResult.status == null) {
      return;
    }
    // Create a credential from the access token
    final twitterAuthCredential = TwitterAuthProvider.credential(
      accessToken: authResult.authToken!,
      secret: authResult.authTokenSecret!,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Social Login",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Quickly sign in with your social network",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.blueGrey),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.11,
          ),
          Center(
            child: Column(
              children: [
                SignInButton(
                    padding: 10,
                    buttonType: ButtonType.google,
                    buttonSize: ButtonSize.large,
                    btnTextColor: Colors.grey,
                    btnColor: Colors.white,
                    width: 350,
                    btnText: 'Sign in with Google',
                    onPressed: () {
                      signInWithGoogle(context);
                    }),
                SizedBox(
                  height: 20,
                ),
                SignInButton(
                    padding: 10,
                    buttonType: ButtonType.facebook,
                    buttonSize: ButtonSize.large,
                    btnTextColor: Colors.grey,
                    btnColor: Colors.white,
                    width: 350,
                    btnText: 'Sign in with facebook',
                    onPressed: () {
                      signInWithFacebook(context);
                    }),
                SizedBox(
                  height: 20,
                ),
                SignInButton(
                    padding: 10,
                    buttonType: ButtonType.twitter,
                    buttonSize: ButtonSize.large,
                    btnTextColor: Colors.grey,
                    btnColor: Colors.white,
                    width: 350,
                    btnText: 'Sign in with twitter',
                    onPressed: () {
                      signInWithTwitter(context);
                      // log(context);
                      // signWithTwitter();
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

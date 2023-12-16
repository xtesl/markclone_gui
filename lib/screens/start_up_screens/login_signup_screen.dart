/*
  LOGIN AND SIGN UP SCREEN
  ============================
*/

import 'package:flutter/material.dart';
import 'package:markclone/Functionalities/special_classes.dart';
import 'package:markclone/Functionalities/special_functions.dart';
import 'package:markclone/constants/colors.dart';
import 'package:markclone/screens/auth_screens/login_screen.dart';
import 'package:markclone/screens/auth_screens/sign_up_screen.dart';
import 'package:markclone/special_ui_elements/custom_buttons.dart';

class LoginSignUpPage extends StatefulWidget {
  const LoginSignUpPage({super.key});

  @override
  State<LoginSignUpPage> createState() => _LoginSignUpPageState();
}

class _LoginSignUpPageState extends State<LoginSignUpPage> {
  Future<void> showScreen(Widget screen, bool showLoading) async {
    showLoading
        ? showDialog(
            context: context,
            builder: (context) {
              return const Center(
                child: CircularProgressIndicator(
                  color: CustomColors.primaryColor,
                ),
              );
            })
        : null;

    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return screen;
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipPath(
              clipper: CircularBottomClipper(300, 0.7),
              child: Container(
                height: 450,
                width: 500,
                decoration: const BoxDecoration(
                  color: CustomColors.primaryColor,
                ),
                child: Center(
                  child: Container(
                      padding: const EdgeInsets.only(bottom: 270.0),
                      child: Image.asset(
                        'assets/images/M.png',
                        height: 100.0,
                        color: Colors.white,
                      )),
                ),
              ),
            ),
            const SizedBox(
              height: 150.0,
            ),
            PrimaryCustomButton(
                onpressed: () {
                  moveToPage(const SignupScreen(), context);
                },
                text: 'SIGN UP'),
            const SizedBox(
              height: 20.0,
            ),
            PrimaryCustomButton(
                onpressed: () {
                  moveToPage(const LoginScreen(), context);
                },
                text: 'LOGIN'),
          ],
        ),
      ),
    );
  }
}

class Page extends StatefulWidget {
  const Page({super.key});

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

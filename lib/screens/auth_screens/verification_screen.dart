import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markclone/Functionalities/special_functions.dart';
import 'package:markclone/constants/colors.dart';
import 'package:markclone/screens/home/index.dart';
import 'package:markclone/special_ui_elements/custom_buttons.dart';
import 'package:markclone/special_ui_elements/custom_forms.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});
  static int? userId;
  static String? otp; //otp from server

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(padding: EdgeInsets.only(top: screenHeight * 0.04)),
                  Text(
                    "VERIFY EMAIL",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                        color: CustomColors.primaryColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "We've just sent a verification code to your email address.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.sail(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: CustomColors.primaryColor),
                  ),
                  Text(
                    "Please check your inbox and enter the code to complete the verification process.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.sail(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: CustomColors.primaryColor),
                  ),
                  const SizedBox(
                    height: 80.0,
                  ),
                  const EmailVerifyForm(),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).popAndPushNamed(
                            '/signup'); //move user back to the signup page
                      },
                      child: const Text(
                        'Wrong email?',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  const SizedBox(
                    height: 100.0,
                  ),
                  PrimaryCustomButton(
                    onpressed: () async {
                      //verify user OTP
                      var userOTP = {'otp': EmailVerifyForm.formValue};
                      if (EmailVerifyForm.formValue.length == 6 &&
                          EmailVerifyForm.isCorrect) {
                        verifyOTP(userOTP, context).then((response) {
                          showMessage(
                              json.decode(response.body)['message'], context);
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) {
                            return const Index();
                          }));
                        }).catchError((err) {
                          showMessage(
                              'Failed to verify your email please try again',
                              context);
                        });

                        //verify user's otp
                      } else {
                        showMessage('Wrong OTP.Please try again', context);
                      }
                    },
                    text: 'SUBMIT',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/*

 *INTRODUCTION SCREEN FOR MARKCLONE 
 *................................
 *Uses the introduction_screen ^3.1.12 external package

*/

import 'package:flutter/material.dart';
import 'package:markclone/Functionalities/special_functions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markclone/constants/colors.dart';
import 'package:markclone/screens/start_up_screens/login_signup_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    super.initState();
    seekLocation(); // Request the location settings of the device.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(color: CustomColors.primaryColor),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 25.0, left: 10.0),
                  child: Text(
                    'Markclone',
                    style:
                        GoogleFonts.sail(color: Colors.white, fontSize: 30.0),
                  ),
                )
              ],
            ),
            Container(
                height: 456.0,
                padding: const EdgeInsets.only(right: 90.0, top: 30.0),
                child: Image.asset(
                  'assets/images/intro_image.png',
                  fit: BoxFit.cover,
                )),
            SafeArea(
              child: Container(
                height: 321,
                width: 408.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Buy the best one',
                      style: GoogleFonts.sreeKrushnadevaraya(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.primaryColor),
                    ),
                    Text(
                      'Buy quality and reliable products including second-hand goods from our trusted sellers.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.sreeKrushnadevaraya(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          color: CustomColors.primaryColor),
                    ),
                    const SizedBox(
                      height: 90.0,
                    ),
                    ElevatedButton(
                        style: const ButtonStyle(
                            elevation: MaterialStatePropertyAll<double>(20.0),
                            minimumSize: MaterialStatePropertyAll<Size>(
                                Size(200.0, 55.0)),
                            backgroundColor: MaterialStatePropertyAll<Color>(
                                CustomColors.primaryColor)),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) {
                            return const LoginSignUpPage();
                          }));
                        },
                        child: Text(
                          'Get started',
                          style: GoogleFonts.sreeKrushnadevaraya(
                              color: Colors.white, fontSize: 25.0),
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    )));
  }
}

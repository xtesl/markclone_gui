/*

 *INTRODUCTION SCREEN FOR MARKCLONE 
 *................................
 *Uses the introduction_screen ^3.1.12 external package

*/

import 'package:flutter/material.dart';
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
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
                      padding: EdgeInsets.only(
                          top: screenHeight * 0.02, left: screenWidth * 0.02),
                      child: Text(
                        'MingleCart',
                        style: GoogleFonts.sail(
                            color: Colors.white, fontSize: screenWidth * 0.06),
                      ),
                    )
                  ],
                ),
                Container(
                  height: screenHeight * 0.5,
                  padding: EdgeInsets.only(
                      right: screenWidth * 0.2, top: screenHeight * 0.05),
                  child: Image.asset(
                    'assets/images/intro_image.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.1,
                      vertical: screenHeight * 0.02),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Buy the best one',
                        style: GoogleFonts.sreeKrushnadevaraya(
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.primaryColor,
                        ),
                      ),
                      Text(
                        'Buy quality and reliable products including second-hand goods from our trusted sellers.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.sail(
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.w500,
                          color: CustomColors.primaryColor,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.05),
                      ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all<double>(20.0),
                          minimumSize: MaterialStateProperty.all<Size>(
                              Size(screenWidth * 0.4, screenHeight * 0.09)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              CustomColors.primaryColor),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) {
                              return const LoginSignUpPage();
                            }),
                          );
                        },
                        child: Text(
                          'Get started',
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: screenWidth * 0.1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markclone/Functionalities/special_functions.dart';
import 'package:markclone/constants/colors.dart';
import 'package:markclone/special_ui_elements/custom_buttons.dart';
import 'package:markclone/special_ui_elements/custom_forms.dart';

class PhoneSignupPage extends StatefulWidget {
  const PhoneSignupPage({super.key});

  @override
  State<PhoneSignupPage> createState() => _PhoneSignupPageState();
}

class _PhoneSignupPageState extends State<PhoneSignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: CustomColors.primaryColor,
                        ))
                  ],
                ),
                Text(
                  'ADD YOUR NUMBER',
                  style: GoogleFonts.roboto(
                      color: CustomColors.primaryColor,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  "We'll send you a verification code",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                      fontSize: 18, color: CustomColors.primaryColor),
                ),
                const SizedBox(
                  height: 80.0,
                ),
                const PhonesignupForm(),
                const SizedBox(
                  height: 100.0,
                ),
                PrimaryCustomButton(
                  onpressed: () {
                    sendCode();
                  },
                  text: 'SEND',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

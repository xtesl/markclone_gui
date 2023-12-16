import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markclone/Functionalities/special_functions.dart';
import 'package:markclone/constants/colors.dart';
import 'package:markclone/screens/auth_screens/phone_signup_page.dart';
import 'package:markclone/special_ui_elements/custom_buttons.dart';
import 'package:markclone/special_ui_elements/custom_forms.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  Widget showScreen(Widget screen, bool showLoading) {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    /*
    *Perform backend operations here.
    *e.g storing user info

    */
    return screen;
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: SafeArea(
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            FocusScope.of(context)
                                .unfocus(); // Remove any focus from widget
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            color: CustomColors.primaryColor,
                          ))
                    ],
                  ),
                  Text(
                    'SIGN UP',
                    style: GoogleFonts.roboto(
                        color: CustomColors.primaryColor,
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 80.0,
                  ),
                  const EmailForm(),
                  const SizedBox(
                    height: 40.0,
                  ),
                  const PasswordForm(hintText: 'Create a password'),
                  const SizedBox(
                    height: 40.0,
                  ),
                  const PasswordForm(hintText: 'Repeat password'),
                  const SizedBox(
                    height: 60.0,
                  ),
                  Text(
                    'SIGN UP WITH:',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        color: CustomColors.primaryColor),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(
                        width: 30.0,
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Image.asset(
                            'assets/images/google.png',
                            height: 50.0,
                          )),
                      TextButton(
                          onPressed: () {},
                          child: Image.asset(
                            'assets/images/x.png',
                            height: 50.0,
                          )),
                      TextButton(
                          onPressed: () {},
                          child: Image.asset(
                            'assets/images/instagram.png',
                            height: 50.0,
                          )),
                      const SizedBox(
                        width: 30.0,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  PrimaryCustomButton(
                    onpressed: () {
                      moveToPage(const PhoneSignupPage(), context);
                    },
                    text: 'SIGN UP',
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

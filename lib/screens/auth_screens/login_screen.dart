import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markclone/Functionalities/special_functions.dart';
import 'package:markclone/constants/colors.dart';
import 'package:markclone/screens/start_up_screens/intro_screen.dart';
import 'package:markclone/special_ui_elements/custom_buttons.dart';
import 'package:markclone/special_ui_elements/custom_forms.dart';

enum SigninOptions { phone, email }

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  SigninOptions option = SigninOptions.phone;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: SafeArea(
            child: Form(
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
                    'LOGIN',
                    style: GoogleFonts.roboto(
                        color: CustomColors.primaryColor,
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold),
                  ),
                  ListTile(
                    title: Text(
                      'Sign in with phone',
                      style:
                          GoogleFonts.roboto(color: CustomColors.primaryColor),
                    ),
                    leading: Radio(
                        fillColor: const MaterialStatePropertyAll<Color>(
                            CustomColors.primaryColor),
                        value: SigninOptions.phone,
                        groupValue: option,
                        onChanged: (SigninOptions? value) {
                          setState(() {
                            option = value!;
                          });
                        }),
                  ),
                  option == SigninOptions.email
                      ? const EmailForm()
                      : const PhonesignupForm(),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const PasswordForm(hintText: 'Password'),
                  ListTile(
                    title: Text(
                      'Sign in with email',
                      style:
                          GoogleFonts.roboto(color: CustomColors.primaryColor),
                    ),
                    leading: Radio(
                        fillColor: const MaterialStatePropertyAll<Color>(
                            CustomColors.primaryColor),
                        value: SigninOptions.email,
                        groupValue: option,
                        onChanged: (SigninOptions? value) {
                          setState(() {
                            option = value!;
                          });
                        }),
                  ),
                  const SizedBox(
                    height: 60.0,
                  ),
                  PrimaryCustomButton(
                    onpressed: () {
                      moveToPage(const IntroScreen(), context);
                    },
                    text: 'LOGIN',
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

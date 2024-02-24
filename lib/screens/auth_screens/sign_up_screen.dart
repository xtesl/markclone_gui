import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markclone/Functionalities/special_functions.dart';
import 'package:markclone/constants/colors.dart';
import 'package:markclone/special_ui_elements/animation_visuals.dart';
import 'package:markclone/special_ui_elements/custom_buttons.dart';
import 'package:markclone/special_ui_elements/custom_forms.dart';
import 'package:markclone/constants/endpoints.dart' as urls;

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  static bool showScreen = true;

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    SignupScreen.showScreen = true;
  }

  @override
  void dispose() {
    super.dispose();
    SignupScreen.showScreen = true;
  }

  @override
  Widget build(BuildContext context) {
    return SignupScreen.showScreen
        ? PopScope(
            canPop: false,
            child: Visibility(
              visible: SignupScreen.showScreen,
              child: Scaffold(
                body: SingleChildScrollView(
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.white),
                    child: SafeArea(
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
                            height: 60.0,
                          ),
                          const EmailForm(),
                          const SizedBox(
                            height: 40.0,
                          ),
                          const PasswordForm(hintText: 'Create a password'),
                          const SizedBox(
                            height: 40.0,
                          ),
                          const PhoneForm(hintText: 'Phone'),
                          const SizedBox(
                            height: 80.0,
                          ),
                          const Row(
                            children: [
                              Expanded(
                                  child: Divider(
                                      thickness: 1, color: Colors.grey)),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text("OR",
                                    style: TextStyle(color: Colors.grey)),
                              ),
                              Expanded(
                                  child: Divider(
                                      thickness: 1, color: Colors.grey)),
                            ],
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
                              const SizedBox(
                                width: 30.0,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 70.0,
                          ),
                          PrimaryCustomButton(
                            onpressed: () async {
                              if (EmailForm.formValue.isEmpty ||
                                  PasswordForm.formValue.isEmpty) {
                                showMessage(
                                    'Oops! Looks like some fields are empty.',
                                    context); //fields are required
                              } else if (EmailForm.formValue.isNotEmpty &&
                                  PasswordForm.formValue.isNotEmpty) {
                                //validate form fields
                                bool emailValidated =
                                    validateEmail(EmailForm.formValue);
                                bool passwordValidate =
                                    validatePassword(PasswordForm.formValue);
                                if (!emailValidated || !passwordValidate) {
                                  String message =
                                      'Invalid registration information. Please check your email and password and try again';
                                  showMessage(message, context);
                                }
                                //all is good to be passed to api
                                if (emailValidated && passwordValidate) {
                                  //initiate loading screen
                                  setState(() {
                                    SignupScreen.showScreen = false;
                                  });
                                  //api call data
                                  var data = {
                                    "email": EmailForm.formValue,
                                    "passcode": PasswordForm.formValue,
                                    "phone": PhoneForm.formValue
                                  };
                                  //api call for user registration
                                  register(data, urls.signUp, context)
                                      .then((response) {
                                    if (response.statusCode == 200) {
                                      //navigate user to verification screen for email verification
                                      Navigator.of(context).popAndPushNamed(
                                          '/verificationScreen');

                                      showMessage(
                                          'Welcome!', context); //welcome user
                                    }
                                    //user may already be in the database
                                    if (response.statusCode == 401) {
                                      setState(() {
                                        SignupScreen.showScreen =
                                            true; //terminate loading
                                      });
                                      showMessage(
                                          json.decode(response.body)['message'],
                                          context);
                                    }
                                  });
                                }
                              }
                            },
                            text: 'SIGN UP',
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        : const Loading();
  }
}

/*
This file defines custom forms for the app
==========================================
*Author:Asare Emmanuel

*Date:Unknown

*Lincense:MIT

*(C) 2023.All rights reserved
*/

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markclone/constants/colors.dart';

class EmailForm extends StatefulWidget {
  const EmailForm({super.key});
  static var formValue = '';

  @override
  State<EmailForm> createState() => _EmailFormState();
}

class _EmailFormState extends State<EmailForm> {
  final controller = TextEditingController();

  @override
  void initState() {
    controller.text = EmailForm.formValue;
    super.initState();
  }

  final emailRegex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      borderRadius: BorderRadius.circular(30.0),
      child: SizedBox(
        width: 350.0,
        child: TextFormField(
          onChanged: (value) {
            setState(() {
              controller.text = value.trim();
              EmailForm.formValue = value.trim();
            });
          },
          controller: controller,
          cursorColor: CustomColors.primaryColor,
          decoration: InputDecoration(
              prefixIcon: Container(
                padding: const EdgeInsets.all(8.0),
                child: const Icon(Icons.email_rounded),
              ),
              suffixIcon: controller.text.isNotEmpty &&
                      emailRegex.hasMatch(controller.text.trim())
                  ? const Icon(Icons.done, color: Colors.green)
                  : null,
              error: (controller.text.isNotEmpty) &&
                      !emailRegex.hasMatch(controller.text.trim())
                  ? SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.error,
                            color: Colors.red,
                          ),
                          Text(
                            'Please enter a valid email',
                            style: GoogleFonts.roboto(color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : null,
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide:
                      const BorderSide(color: CustomColors.primaryColor)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide:
                      const BorderSide(color: CustomColors.primaryColor)),
              suffixStyle: const TextStyle(color: Colors.black),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide:
                      const BorderSide(color: CustomColors.primaryColor)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(
                  color: CustomColors.primaryColor,
                ),
              ),
              hintText: 'Email'),
        ),
      ),
    );
  }
}

class PasswordForm extends StatefulWidget {
  final String hintText;
  const PasswordForm({super.key, required this.hintText});
  static var formValue = '';

  @override
  State<PasswordForm> createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  final controller = TextEditingController();

  final passwordRegex =
      RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_])[A-Za-z\d\W_]{6,}$');
  String? hintText;
  bool? show;
  static int counter = 0;
  IconData showPasswordIcon = Icons.visibility;

  @override
  void initState() {
    hintText = widget.hintText;
    controller.text = PasswordForm.formValue;
    show = false;
    super.initState();
  }

  // String get value => controller.text;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      borderRadius: BorderRadius.circular(30.0),
      child: SizedBox(
        width: 350.0,
        child: TextFormField(
          obscureText: !show!,
          onChanged: (value) {
            setState(() {
              controller.text = value.trim();
              PasswordForm.formValue = value.trim();
              if (controller.text.isEmpty) {
                show = false;
                showPasswordIcon = Icons.visibility;
                counter = 0;
              }
            });
          },
          controller: controller,
          cursorColor: CustomColors.primaryColor,
          decoration: InputDecoration(
              prefixIcon: Container(
                padding: const EdgeInsets.all(8.0),
                child: const Icon(Icons.lock),
              ),
              suffixIcon: controller.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          counter += 1;
                          if (counter % 2 == 0) {
                            show = false;
                            showPasswordIcon = Icons.visibility;
                          } else {
                            show = true;
                            showPasswordIcon = Icons.visibility_off;
                          }
                        });
                      },
                      icon: Icon(
                        showPasswordIcon,
                        color: Colors.black,
                      ))
                  : null,
              error: (controller.text.isNotEmpty) &&
                      !passwordRegex.hasMatch(controller.text)
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.error,
                              color: Colors.red,
                            ),
                          ],
                        ),
                        Column(children: [
                          Text(
                            'Password must contains:',
                            style: GoogleFonts.roboto(color: Colors.red),
                          ),
                          Text(
                            'at least one uppercase letter[A-Z]',
                            style: GoogleFonts.roboto(color: Colors.red),
                          ),
                          Text(
                            'at least one lowercase letter[a-z]',
                            style: GoogleFonts.roboto(color: Colors.red),
                          ),
                          Text(
                            'at least one special character[=.*[!@#/)+-]',
                            style: GoogleFonts.roboto(color: Colors.red),
                          ),
                          Text(
                            'at least six letters',
                            style: GoogleFonts.roboto(color: Colors.red),
                          ),
                        ])
                      ],
                    )
                  : null,
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide:
                      const BorderSide(color: CustomColors.primaryColor)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide:
                      const BorderSide(color: CustomColors.primaryColor)),
              suffixStyle: const TextStyle(color: Colors.black),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide:
                      const BorderSide(color: CustomColors.primaryColor)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(
                  color: CustomColors.primaryColor,
                ),
              ),
              hintText: hintText),
        ),
      ),
    );
  }
}

class EmailVerifyForm extends StatefulWidget {
  const EmailVerifyForm({super.key});
  static String formValue = ''; //otp entered by user
  static String otp = ''; //otp from the server
  static bool isCorrect = false;

  @override
  State<EmailVerifyForm> createState() => _EmailVerifyFormState();
}

class _EmailVerifyFormState extends State<EmailVerifyForm> {
  final controller = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  //   controller.text = EmailForm.formValue;
  // }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: SizedBox(
        width: 350.0,
        child: TextFormField(
          controller: controller,
          onChanged: (value) {
            setState(() {
              EmailVerifyForm.formValue = value.trim();
              if (EmailVerifyForm.formValue == EmailVerifyForm.otp) {
                EmailVerifyForm.isCorrect =
                    true; // user entered the correct otp
              }
            });
            if (value.length <= 6) {
              setState(() {
                controller.text = value;
              });
            } else {
              setState(() {
                controller.text = controller.text
                    .substring(0, 6); //Required verification code length
              });
            }
          },
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          style: const TextStyle(fontSize: 20.0),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          cursorColor: CustomColors.primaryColor,
          decoration: InputDecoration(
              hintText: 'Enter Code',
              hintStyle: const TextStyle(fontWeight: FontWeight.bold),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide:
                      const BorderSide(color: CustomColors.primaryColor)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide:
                      const BorderSide(color: CustomColors.primaryColor))),
        ),
      ),
    );
  }
}

//phone number form
class PhoneForm extends StatefulWidget {
  final String hintText;
  const PhoneForm({super.key, required this.hintText});
  static String formValue = '';
  @override
  State<PhoneForm> createState() => _PhoneFormState();
}

class _PhoneFormState extends State<PhoneForm> {
  final controller = TextEditingController();
  String? hintText;

  @override
  void initState() {
    super.initState();
    controller.text = PhoneForm.formValue;
    hintText = widget.hintText;
  }

  Country country = Country(
      phoneCode: '233',
      countryCode: 'GH',
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: 'Ghana',
      example: 'Ghana',
      displayName: 'Ghana',
      displayNameNoCountryCode: 'GH',
      e164Key: '');

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: SizedBox(
        width: 350.0,
        child: TextFormField(
          controller: controller,
          onChanged: (value) {
            PhoneForm.formValue = value.trim();
            if (value.length <= 10) {
              setState(() {
                controller.text = value;
              });
            } else {
              setState(() {
                controller.text = controller.text
                    .substring(0, 10); //Required verification code length
              });
            }
          },
          keyboardType: TextInputType.number,
          style: const TextStyle(fontSize: 20.0),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          cursorColor: CustomColors.primaryColor,
          decoration: InputDecoration(
              prefixIcon: Container(
                padding: const EdgeInsets.only(top: 8, right: 8.0),
                child: InkWell(
                  onTap: () {
                    //   showCountryPicker(
                    //       context: context,
                    //       onSelect: (value) {
                    //         setState(() {
                    //           country = value; //
                    //         });
                    //       });
                  },
                  child: Text(
                    "${country.flagEmoji} +${country.phoneCode}",
                    style: const TextStyle(fontSize: 22.0),
                  ),
                ),
              ),
              hintText: hintText,
              hintStyle: const TextStyle(fontWeight: FontWeight.bold),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide:
                      const BorderSide(color: CustomColors.primaryColor)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide:
                      const BorderSide(color: CustomColors.primaryColor))),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markclone/constants/colors.dart';

/*
 Custom sign up page buttons
 ============================
*/
class PrimaryCustomButton extends StatefulWidget {
  final VoidCallback onpressed;
  final String text;
  const PrimaryCustomButton(
      {super.key, required this.onpressed, required this.text});

  @override
  State<PrimaryCustomButton> createState() => _PrimaryCustomButtonState();
}

class _PrimaryCustomButtonState extends State<PrimaryCustomButton> {
  VoidCallback onpressed = () {};
  String text = '';

  @override
  void initState() {
    onpressed = widget.onpressed;
    text = widget.text;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onpressed,
        style: const ButtonStyle(
            elevation: MaterialStatePropertyAll<double>(10.0),
            fixedSize: MaterialStatePropertyAll<Size>(Size(300.0, 70.0)),
            backgroundColor:
                MaterialStatePropertyAll<Color>(CustomColors.primaryColor),
            foregroundColor: MaterialStatePropertyAll<Color>(Colors.white)),
        child: Text(
          text,
          style: GoogleFonts.roboto(fontSize: 25.0),
        ));
  }
}

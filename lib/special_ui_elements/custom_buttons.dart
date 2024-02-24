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

class SecondaryCustomButton extends StatelessWidget {
  final VoidCallback onpressed;
  final String text;
  final double width;
  const SecondaryCustomButton(
      {super.key,
      required this.onpressed,
      required this.text,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onpressed,
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0))),
            elevation: const MaterialStatePropertyAll<double>(10.0),
            fixedSize: MaterialStatePropertyAll<Size>(Size(width, 50.0)),
            backgroundColor: const MaterialStatePropertyAll<Color>(
                CustomColors.primaryColor),
            foregroundColor:
                const MaterialStatePropertyAll<Color>(Colors.white)),
        child: Text(
          text,
          style: GoogleFonts.roboto(fontSize: 18.0),
        ));
  }
}

class V1CustomButton extends StatefulWidget {
  final VoidCallback onpressed;
  final String text;
  final bool selected;
  const V1CustomButton(
      {super.key,
      required this.onpressed,
      required this.text,
      required this.selected});

  @override
  State<V1CustomButton> createState() => _V1CustomButtonState();
}

class _V1CustomButtonState extends State<V1CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: widget.onpressed,
        style: ButtonStyle(
            shadowColor: const MaterialStatePropertyAll<Color>(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    side: const BorderSide(color: CustomColors.primaryColor),
                    borderRadius: BorderRadius.circular(18.0))),
            elevation: const MaterialStatePropertyAll<double>(10.0),
            fixedSize: const MaterialStatePropertyAll<Size>(Size(100.0, 10.0)),
            backgroundColor: MaterialStatePropertyAll<Color>(
                widget.selected ? CustomColors.primaryColor : Colors.white),
            foregroundColor:
                const MaterialStatePropertyAll<Color>(Colors.white)),
        child: Text(
          widget.text,
          style: GoogleFonts.roboto(
              fontSize: 12.0,
              color:
                  widget.selected ? Colors.white : CustomColors.primaryColor),
        ));
  }
}

class V3CustomButton extends StatefulWidget {
  final VoidCallback onpressed;
  const V3CustomButton({super.key, required this.onpressed});

  @override
  State<V3CustomButton> createState() => _V3CustomButtonState();
}

class _V3CustomButtonState extends State<V3CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
      child: TextButton(
        onPressed: widget.onpressed,
        style: const ButtonStyle(
            foregroundColor: MaterialStatePropertyAll<Color>(Colors.white),
            backgroundColor:
                MaterialStatePropertyAll<Color>(CustomColors.primaryColor)),
        child: const Text('Edit'),
      ),
    );
  }
}

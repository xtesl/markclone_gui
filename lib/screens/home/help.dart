import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:markclone/Functionalities/special_functions.dart';
import 'package:markclone/constants/colors.dart';

class Help extends StatefulWidget {
  const Help({super.key});

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    Map<String, double> screenDimensions = getScreenDimensions(context);
    return Scaffold(
        backgroundColor: const Color.fromRGBO(245, 245, 245, 1.0),
        body: ListView(
          children: [
            SizedBox(
              height: screenDimensions['height']! * 0.04,
            ),
            Text(
              "Hello, how can we help you?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: screenDimensions['width']! * 0.06,
                fontWeight: FontWeight.w500,
              ),
            ),
            Image.asset(
              'assets/images/support_bot.png',
              height: screenDimensions['height']! * 0.25,
              color: CustomColors.primaryColor,
            ),
            SizedBox(
              height: screenDimensions['height']! * 0.11,
            ),
            Card(
              shadowColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              elevation: 1.5,
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                leading: const Icon(
                  Icons.chat_outlined,
                  size: 40.0,
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                title: const Padding(
                  padding: EdgeInsets.all(18),
                  child: Text(
                    'Chat with Kendra',
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                tileColor: Colors.white,
                splashColor: const Color.fromRGBO(240, 240, 240, 1.0),
                onTap: () {},
              ),
            ),
            Card(
              elevation: 1.5,
              shadowColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                leading: const Icon(
                  Icons.email_outlined,
                  size: 40.0,
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                title: const Padding(
                    padding: EdgeInsets.all(18),
                    child: Text('Send us an E-mail')),
                tileColor: Colors.white,
                splashColor: const Color.fromRGBO(240, 240, 240, 1.0),
                onTap: () {},
              ),
            ),
            Card(
              elevation: 1.5,
              shadowColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                leading: const Icon(
                  Icons.help_outlined,
                  size: 40.0,
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                title: const Padding(
                    padding: EdgeInsets.all(18), child: Text('FAQs')),
                tileColor: Colors.white,
                splashColor: const Color.fromRGBO(240, 240, 240, 1.0),
                onTap: () {},
              ),
            ),
            SizedBox(
              height: screenDimensions['height']! * 0.08,
            ),
            const Center(
              child: Text('Version 1.0.0'),
            )
          ],
        ));
  }
}

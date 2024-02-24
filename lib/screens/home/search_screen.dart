import 'package:flutter/material.dart';
import 'package:markclone/Functionalities/special_functions.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    Map<String, double> screenDimensions = getScreenDimensions(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        actions: [
          Container(
            width: screenDimensions['width']! * 0.79,
            child: TextField(
              autofocus: true,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: screenDimensions['width']! * 0.05),
              decoration: InputDecoration(
                  hintText: 'Type your search here',
                  hintStyle: const TextStyle(color: Colors.white),
                  prefix: Container(
                    padding: EdgeInsets.only(
                        top: screenDimensions['height']! * 0.01),
                    child: IconButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.arrow_back_outlined,
                          color: Colors.white,
                          size: screenDimensions['width']! * 0.07,
                        )),
                  )),
            ),
          ),
          SizedBox(
            width: screenDimensions['width']! * 0.2,
          )
        ],
      ),
    );
  }
}

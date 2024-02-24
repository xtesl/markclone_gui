import 'package:flutter/material.dart';
import 'package:markclone/Functionalities/special_functions.dart';
import 'package:markclone/constants/colors.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    Map<String, double> screenDimensions = getScreenDimensions(context);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('My Cart'),
          centerTitle: true,
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.keyboard_arrow_down,
              size: screenDimensions['height']! * 0.04,
            ),
          ),
        ),
        backgroundColor: const Color.fromRGBO(230, 230, 230, 1.0),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    constraints: BoxConstraints(
                        maxHeight: screenDimensions['height']! * 0.89),
                    child: ListView.builder(
                        itemCount: 21,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(
                                    screenDimensions['width']! * 0.01),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      screenDimensions['width']! * 0.02),
                                  child: Material(
                                    elevation: 6.0,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                            constraints: BoxConstraints(
                                                maxHeight: screenDimensions[
                                                        'height']! *
                                                    0.15,
                                                minWidth:
                                                    screenDimensions['width']! *
                                                        0.3,
                                                maxWidth:
                                                    screenDimensions['width']! *
                                                        0.3),
                                            child: Image.asset(
                                              'assets/images/controller.jpg',
                                              fit: BoxFit.cover,
                                            )),
                                        Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: screenDimensions[
                                                              'width']! *
                                                          0.15),
                                                  child: const Text(
                                                    'Jordan 11',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                                IconButton(
                                                    onPressed: () {},
                                                    icon: const Icon(
                                                        Icons.delete,
                                                        color: CustomColors
                                                            .primaryColor))
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right: screenDimensions[
                                                          'width']! *
                                                      0.05),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  IconButton(
                                                      onPressed: () {},
                                                      icon: Container(
                                                        decoration: BoxDecoration(
                                                            color: const Color
                                                                .fromRGBO(230,
                                                                230, 230, 1.0),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12.0)),
                                                        child: Icon(
                                                          Icons.add,
                                                          size: screenDimensions[
                                                                  'height']! *
                                                              0.04,
                                                          color: CustomColors
                                                              .primaryColor,
                                                        ),
                                                      )),
                                                  const Text(
                                                    '1',
                                                    style: TextStyle(
                                                        color: CustomColors
                                                            .primaryColor),
                                                  ),
                                                  IconButton(
                                                      onPressed: () {},
                                                      icon: Container(
                                                        decoration: BoxDecoration(
                                                            color: const Color
                                                                .fromRGBO(230,
                                                                230, 230, 1.0),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12.0)),
                                                        child: Icon(
                                                          Icons.remove,
                                                          size: screenDimensions[
                                                                  'height']! *
                                                              0.04,
                                                          color: CustomColors
                                                              .primaryColor,
                                                        ),
                                                      )),
                                                  SizedBox(
                                                    width: screenDimensions[
                                                            'width']! *
                                                        0.04,
                                                  ),
                                                  const Text('GH₵ 15, 456.00')
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                  Positioned(
                      left: screenDimensions['width']! * 0.8,
                      top: screenDimensions['height']! * 0.7,
                      child: Container(
                        decoration: BoxDecoration(
                            color: CustomColors.primaryColor,
                            borderRadius: BorderRadius.circular(18.0)),
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.clear_all,
                              color: Colors.white,
                            )),
                      )),
                ],
              ),
            ],
          ),
        ));
  }
}

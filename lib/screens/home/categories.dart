import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:markclone/Functionalities/special_functions.dart';
import 'package:markclone/constants/colors.dart';
import 'package:markclone/screens/home/product_view.dart';
import 'package:markclone/special_ui_elements/animation_visuals.dart';
import 'package:markclone/special_ui_elements/custom_buttons.dart';
import 'package:markclone/constants/endpoints.dart' as urls;

class Categories extends StatefulWidget {
  const Categories({super.key});
  static bool showScreen = true;

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  //Top bar buttons rep the various categories
  int selectedTopBarButtonIndex = 0; //first button by default
  int countTaps = 0;
  List<String> categories = [
    //available categories of products
    'Phones',
    'Men Fashion',
    'Computers',
    'Women Fashion',
    'Cosmetics',
    'Books',
    'Food Stuffs',
  ];

  @override
  Widget build(BuildContext context) {
    Map<String, double> screenDimensions = getScreenDimensions(context);
    return Categories.showScreen
        ? Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.black,
              title: Text(
                'Tops',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: screenDimensions['height']! * 0.05),
              ),
              centerTitle: true,
              actions: [
                Text(
                  'Sort',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: screenDimensions['width']! * 0.03),
                ),
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              icon: const Icon(
                                Icons.sort,
                                size: 30,
                              ),
                              elevation: 0.0,
                              shadowColor: Colors.white,
                              title: SizedBox(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Sort options',
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        icon: const Icon(Icons.cancel,
                                            color: Colors.black))
                                  ],
                                ),
                              ),
                              content: const Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [MyRadioButtons()],
                              ),
                            );
                          });
                    },
                    icon:
                        const Icon(Icons.sort, size: 20, color: Colors.white)),
              ],
            ),
            body: Column(
              children: [
                SizedBox(
                  height: screenDimensions['height']! * 0.07,
                  width: double.infinity,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            SizedBox(
                              width: screenDimensions['width']! * 0.33,
                              child: V1CustomButton(
                                  onpressed: () {
                                    setState(() {
                                      selectedTopBarButtonIndex =
                                          index; //select the button
                                      const SpinKitCircle(
                                        color: CustomColors.primaryColor,
                                      );
                                    });
                                  },
                                  text: categories[index],
                                  selected: selectedTopBarButtonIndex == index),
                            ),
                            SizedBox(
                              width: screenDimensions['width']! * 0.04,
                            )
                          ],
                        );
                      }),
                ),
                SingleChildScrollView(
                  child: SizedBox(
                    height: screenDimensions['height']! * 0.69,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  2, // Number of columns in the grid
                              crossAxisSpacing: 2.0, // Spacing between columns
                              mainAxisSpacing: 3.0,
                              childAspectRatio: 0.55),
                      itemBuilder: (context, index) {
                        return FutureBuilder(
                            future: fetchProducts(urls.getProducts),
                            builder: (ontext, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const SpinKitCircle(
                                  color: CustomColors.primaryColor,
                                );
                              }
                              return CategoryCard(
                                  onpressed: () {
                                    Navigator.of(context).push(
                                        customPageRoute_2(const ProductView(
                                      productName:
                                          'iphone 15 pro max 32gb ram 64gb storage',
                                    )));
                                  },
                                  categoryName: 'ph',
                                  imageUrl: 'assets/images/headset_1.jpg');
                            });
                      },
                      itemCount: 10,
                    ),
                  ),
                )
              ],
            ))
        : InkWell(
            onTap: () {
              setState(() {
                countTaps += 1;
                if (countTaps % 2 == 0) {
                  Categories.showScreen = true;
                } else {
                  Categories.showScreen = false;
                }
              });
            },
            child: const Loading(),
          );
  }
}

class CategoryCard extends StatefulWidget {
  final String categoryName;
  final String imageUrl;
  final VoidCallback onpressed;

  const CategoryCard(
      {super.key,
      required this.categoryName,
      required this.imageUrl,
      required this.onpressed});

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  int countPressed = 0;
  bool liked = false;
  @override
  Widget build(BuildContext context) {
    Map<String, double> screenDimensions = getScreenDimensions(context);
    return InkWell(
      onTap: widget.onpressed,
      child: Card(
        color: Colors.white,
        elevation: 0.7,
        shadowColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              widget.imageUrl,
              height: screenDimensions['height']! * 0.22,
              fit: BoxFit.scaleDown,
            ),
            Text(
              'iphone 15 pro max 32gb ram 64gb storage',
              style: TextStyle(
                fontSize: screenDimensions['width']! * 0.03,
              ),
              // textAlign: TextAlign.center,
            ),
            Text(
              'GH₵ 15, 454.00',
              style: TextStyle(
                fontSize: screenDimensions['width']! * 0.03,
                fontWeight: FontWeight.bold,
              ),
            ),
            SecondaryCustomButton(
                onpressed: () {},
                text: 'Add to cart',
                width: screenDimensions['width']! * 0.04),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      countPressed += 1;
                      if (countPressed % 2 == 0) {
                        setState(() {
                          liked = false;
                        });
                      } else {
                        setState(() {
                          liked = true;
                        });
                      }
                    },
                    icon: Icon(
                      liked ? Icons.favorite : Icons.favorite_outline,
                      size: screenDimensions['height']! * 0.05,
                      color: CustomColors.primaryColor,
                    )),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.chat_outlined,
                    size: screenDimensions['height']! * 0.05,
                  ),
                  color: CustomColors.primaryColor,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

//sort options radios
class MyRadioButtons extends StatefulWidget {
  const MyRadioButtons({super.key});

  @override
  State<MyRadioButtons> createState() => _MyRadioButtonsState();
}

class _MyRadioButtonsState extends State<MyRadioButtons> {
  int? selectedRadio;

  @override
  void initState() {
    super.initState();
    // Initialize the selected radio button value
    getData('sortOption').then((option) {
      if (option != null) {
        setState(() {
          selectedRadio = int.parse(option);
        }); //get the previously selected option
      } else {
        setState(() {
          selectedRadio = 1;
        }); //default selection
      }
    });
  }

  setSelectedRadio(int? val) async {
    setState(() {
      // Set the selected radio button value
      selectedRadio = val;
    });
    await setData(
        'sortOption', selectedRadio.toString()); //selected option stored
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text('Newest'),
          leading: Radio(
            value: 1,
            groupValue: selectedRadio,
            onChanged: (val) async {
              await setSelectedRadio(val);
            },
          ),
        ),
        const Divider(),
        ListTile(
          title: const Text('Price - Low to High'),
          leading: Radio(
            value: 2,
            groupValue: selectedRadio,
            onChanged: (val) async {
              await setSelectedRadio(val);
            },
          ),
        ),
        const Divider(),
        ListTile(
          title: const Text('Price - High to Low'),
          leading: Radio(
            value: 3,
            groupValue: selectedRadio,
            onChanged: (val) async {
              await setSelectedRadio(val);
            },
          ),
        ),
        const Divider(),
        ListTile(
          title: const Text('Best Sellers'),
          leading: Radio(
            value: 4,
            groupValue: selectedRadio,
            onChanged: (val) async {
              await setSelectedRadio(val);
            },
          ),
        )
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Flutter Radio Buttons'),
      ),
      body: MyRadioButtons(),
    ),
  ));
}

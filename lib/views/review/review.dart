import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../home_screen/home_screen.dart';

class Rate extends StatefulWidget {
  const Rate({super.key});

  @override
  State<Rate> createState() => _RateState();
}

class _RateState extends State<Rate> {
  double? rate;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            //  appBar: AppBar(title: Text("smart")),
            //  drawer: Drawer(
            //  child: SingleChildScrollView(
            //  child: Container(
            //  child: Column(
            //  children: [
            //    HomePage(),
            //],
            //),

            body: SizedBox(
                width: size.width,
                height: size.height,
                child: SingleChildScrollView(
                    child: Stack(children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 320.0),
                      child: Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50),
                            ),
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 50,
                                ),
                                Form(
                                    child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      "Rate This Driver",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20,
                                          // fontFamily: ,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 9,
                                    ),
                                    RatingBar.builder(
                                      initialRating: 3,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemPadding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {
                                        rate = rating;
                                      },
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(

                                      ),
                                      width: 342,
                                      height: 162,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: TextField(
                                        maxLines: 6,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                            hintStyle: TextStyle(
                                                color: Color(0xffD6D6D6)),
                                            hintText: 'Write any comments..',
                                     ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          style: const ButtonStyle(
                                              shape: MaterialStatePropertyAll(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10)))),
                                              minimumSize:
                                                  MaterialStatePropertyAll(
                                                      Size(152, 50))),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const Rate()));
                                          },
                                          child: Text("Skip",
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              )),
                                        ),
                                        const SizedBox(
                                          width: 30,
                                        ),
                                        ElevatedButton(
                                          style: const ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      Colors.white),
                                              shape: MaterialStatePropertyAll(
                                                  RoundedRectangleBorder(
                                                      side: BorderSide(
                                                        color:
                                                            Color(0xff15CB95),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10)))),
                                              minimumSize:
                                                  MaterialStatePropertyAll(
                                                      Size(152, 50))),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const HomeScreen()));
                                          },
                                          child: Text("Submit",
                                              style: const TextStyle(
                                                color: Color(0xff15CB95),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              )),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                  ],
                                ))
                              ])))
                ])))));
  }
}

_build() {
  return const Padding(
    padding: EdgeInsets.symmetric(horizontal: 100),
    child: Text(
      "How Was your Ride?",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
  );
}

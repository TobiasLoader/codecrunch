import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../funcs.dart';
import '../setup.dart';

Widget abouttext(Size size, {TextAlign textAlign = TextAlign.left}) {
  return Center(
    child: SingleChildScrollView(
      padding: EdgeInsets.only(right: 20),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: (() {
            if (textAlign == TextAlign.center)
              return CrossAxisAlignment.center;
            else
              return CrossAxisAlignment.start;
          }()),
          children: [
            Text(
              "Heya  –  I'm Toby.",
              style: TextStyle(fontSize: 22),
              textAlign: textAlign,
            ),
            Text(
              "\nI'm a current second year Maths & CS undergrad at Oxford. I built this app to encourage anyone starting out with programming and give them some great mathsy challenges they can sharpen their programming abilities on. I'm aiming to post a new problem every 2 weeks and am trying to pitch the difficulty for beginner/intermediate coders with some maths skills, i.e. GC\n\nSE ALevel standard in UK or equivalent. I'm very new to this so I hope you enjoy and please get in touch if you have any feeback! I'm a current second year Maths & CS undergrad at Oxford. I built this app to encourage anyone starting out with programming and give them some great mathsy challenges they can sharpen their programming abilities on. I'm aiming to post a new problem every 2 weeks and am trying to pitch the difficulty for beginner/intermediate coders with some maths skills, i.e. GCSE/ALevel standard in UK or equivalent. I'm very new to this so I hope you enjoy and please get in touch if you have any feeback!",
              textAlign: TextAlign.left,
              style: TextStyle(height: 1.7),
            ),
          ]),
    ),
  );
}

Widget aboutimg(Size size) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(5.0),
    child: Container(
        child: const Image(
          image: AssetImage('assets/TobyNiceSquare.jpeg'),
        ),
        width: 200.0),
  );
}

class About extends StatelessWidget {
  About({Key? key, required this.controller}) : super(key: key);
  final Controller controller;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Spacer(),
          Flexible(
            flex: 8,
            child: Container(
              height: (() {
                if (size.width > Data.wbounds[2.0]!)
                  return 300.0;
                else
                  return size.height * 0.9;
              }()),
              child: (() {
                if (size.width > Data.wbounds[2.0]!)
                  return Row(children: [
                    Expanded(
                        child: Padding(
                            padding: EdgeInsets.only(
                                right: (() {
                              if (size.width > Data.wbounds[3.0]!)
                                return 60.0;
                              else
                                return 20.0;
                            }())),
                            child: abouttext(size))),
                    aboutimg(size)
                  ]);
                else
                  return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Flexible(flex: 1, child: aboutimg(size)),
                    Expanded(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                            padding: EdgeInsets.only(top: 30), child: abouttext(size, textAlign: TextAlign.center)),
                      ),
                    ),
                  ]);
              }()),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../funcs.dart';
import '../setup.dart';

Widget abouttext(Size size, Color? colour, {TextAlign textAlign = TextAlign.left}) {
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
              "Heya 👋 –  I'm Toby",
              style: TextStyle(fontSize: 22,fontWeight:FontWeight.bold),
              textAlign: textAlign,
            ),
            RichText(
              text: TextSpan(
                style: TextStyle(height: 1.7,fontFamily:'Poppins'),
                children: [
                  TextSpan(
                    text:"\nI'm a current third year Maths & CS undergrad at Oxford. I built this app to encourage anyone starting out with programming and give them some great mathsy challenges they can sharpen their programming abilities on. Find me on ",
                  ),
                  TextSpan(
                    text:"Github",
                    style: TextStyle(color: colour, fontWeight:FontWeight.bold),
                    recognizer: TapGestureRecognizer()..onTap = () => launchUrl(Uri.parse('https://www.github.com/TobiasLoader')),
                  ),
                  TextSpan(
                    text:" or ",
                  ),
                  TextSpan(
                    text:"LinkedIn",
                    style: TextStyle(color: colour, fontWeight:FontWeight.bold),
                    recognizer: TapGestureRecognizer()..onTap = () => launchUrl(Uri.parse('https://www.linkedin.com/in/tobiasloader')),
                  ),
                  TextSpan(
                    text:".",
                  )
                ]
              )
            ),
          ]),
    ),
  );
}

Widget aboutimg(Size size) {
  return Container(
    width: (() {
      if (size.width > Data.wbounds[3.0]!)
        return 300.0;
      else
        return 300.0*size.width/Data.wbounds[3.0]!;
    }()),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(150),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 10,
          blurRadius: 10
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(150.0),
      child: const Image(
        image: AssetImage('assets/TobyNiceSquare.jpeg'),
      ),
    )
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
                if (size.width > Data.wbounds[3.0]!)
                  return 300.0;
                else
                  return size.height * 0.9;
              }()),
              child: (() {
                if (size.width > Data.wbounds[3.0]!)
                  return Row(children: [
                    Expanded(
                        child: Padding(
                            padding: EdgeInsets.only(
                                right: (() {
                              if (size.width > Data.wbounds[2.0]!)
                                return 60.0;
                              else
                                return 20.0;
                            }())),
                            child: abouttext(size,extractCardCol(controller.problemid.value)))),
                    aboutimg(size)
                  ]);
                else
                  return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Flexible(flex: 1, child: aboutimg(size)),
                    Expanded(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: abouttext(size,extractCardCol(controller.problemid.value), textAlign: TextAlign.center),
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

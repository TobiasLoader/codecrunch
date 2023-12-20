import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../funcs.dart';
import '../problems/crunchbox.dart';
import '../setup.dart';
import 'stats.dart';

Widget titleTxt(controller, titlecol, Size size) {
  return TextButton(
    style: TextButton.styleFrom(
      padding: EdgeInsets.zero,
    ).copyWith(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
    ),
    onPressed: (() {
      controller.page.value = "Problems";
      titlecol.value = Color.fromARGB(255, 158, 158, 158);
    }),
    onHover: (h) => {
      if (h)
        titlecol.value = extractCardCol(controller.problemid.value)
      else
        titlecol.value = Color.fromARGB(255, 158, 158, 158)
    },
    child: Row(mainAxisAlignment: MainAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
      Text(
        extractCardName(controller.problemid.value),
        style: TextStyle(
            fontSize: min(min(size.width, 2 * size.height) / 30, 35),
            fontWeight: FontWeight.bold,
            color: titlecol.value,
            overflow: TextOverflow.ellipsis),
        textAlign: TextAlign.left,
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
        child: Icon(
          Icons.keyboard_arrow_right_rounded,
          size: 1.2 * min(min(size.width, 2 * size.height) / 30, 35),
          color: titlecol.value.withOpacity(0.6),
        ),
      )
    ]),
  );
}

List<Widget> statsDataSolved(controller, Size size) {
  return [
    Text(
      'Solution: ' + solutionToProblem(controller.problemid.value).toString(),
      style: TextStyle(fontSize: min(min(size.width, 2 * size.height) / 50, 20), color: Colors.black54),
      textAlign: TextAlign.left,
    ),
    Text(
      'Difficulty: ' + '4/10',
      style: TextStyle(fontSize: min(min(size.width, 2 * size.height) / 50, 20), color: Colors.black54),
      textAlign: TextAlign.left,
    ),
    Text(
      'Solved By: ' + '314 users',
      style: TextStyle(fontSize: min(min(size.width, 2 * size.height) / 50, 20), color: Colors.black54),
      textAlign: TextAlign.left,
    ),
    Text(
      'Date Solved: ' + '04/05/2022',
      style: TextStyle(fontSize: min(min(size.width, 2 * size.height) / 50, 20), color: Colors.black54),
      textAlign: TextAlign.left,
    ),
  ];
}

List<Widget> statsDataUnsolved(controller, Size size) {
  return [
    Text(
      'Solution: ' + ' - ',
      style: TextStyle(fontSize: min(min(size.width, 2 * size.height) / 50, 20), color: Colors.black54),
      textAlign: TextAlign.left,
    ),
    Text(
      'Difficulty: ' + '4/10',
      style: TextStyle(fontSize: min(min(size.width, 2 * size.height) / 50, 20), color: Colors.black54),
      textAlign: TextAlign.left,
    ),
    Text(
      'Solved By: ' + '314 users',
      style: TextStyle(fontSize: min(min(size.width, 2 * size.height) / 50, 20), color: Colors.black54),
      textAlign: TextAlign.left,
    ),
    Text(
      'Date Solved: ' + ' - ',
      style: TextStyle(fontSize: min(min(size.width, 2 * size.height) / 50, 20), color: Colors.black54),
      textAlign: TextAlign.left,
    ),
  ];
}

class IndiStats extends StatelessWidget {
  IndiStats({Key? key, required this.controller}) : super(key: key);
  final Controller controller;
  var titlecol = (Color.fromARGB(255, 158, 158, 158)).obs;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double svgwidth = min(min(size.width, size.height) / 3, 200.0);
    double fontsize = 1.8 * svgwidth / (svgwidth ~/ 100) / 7;
    return Center(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: size.width / 10,
              child: Center(
                child: IconButton(
                  iconSize: 50,
                  icon: Icon(
                    Icons.keyboard_arrow_left_rounded,
                    color: Colors.black.withOpacity(0.3),
                  ),
                  onPressed: () => controller.page.value = "Stats",
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(size.width / 10),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Flexible(
                flex: 1,
                child: Stack(
                  children: [
                    SvgPicture.asset(
                      'assets/Emily_Toby_v3.svg',
                      color: extractCardCol(controller.problemid.value),
                      width: svgwidth,
                    ),
                    Container(
                      margin:EdgeInsets.all(8),
                      child:statsnumbutton(controller, controller.problemid.value-1, true, extractCardCol(controller.problemid.value), fontsize, svgwidth - 32.0, "Problems"),
                    ),
                  ]
                ),
              ),
              Flexible(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.only(left: size.width / 20),
                  child: Obx(
                    () => Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          titleTxt(controller, titlecol, size),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: (() {
                                if (hasSolved(controller.problemid.value, controller.solved))
                                  return statsDataSolved(controller, size);
                                else
                                  return statsDataUnsolved(controller, size);
                              }()),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

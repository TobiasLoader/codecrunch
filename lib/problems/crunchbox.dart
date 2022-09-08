import 'package:flutter_svg/flutter_svg.dart';

import '../funcs.dart';
import '../setup.dart';
import 'package:flutter/material.dart';

Widget centercard(n, opacity, fontSize) {
  return Center(
    child: Text(
      n.toString(),
      style: TextStyle(
          color: Colors.white.withOpacity(0.4 * opacity),
          // color: (() {
          //   if (hasSolved(n, controller.solved.value))
          //     return color.withOpacity(0.6 * opacity);
          //   else
          //     return Colors.white.withOpacity(0.3 * opacity);
          // }()),
          // color: Colors.white.withOpacity(0.3 * opacity),
          fontSize: 3 * fontSize / (1 + (n.toString().length - 1) / 2.5)),
    ),
  );
}

Widget cardbuildexlbite(n, color, opacity, fontSize) {
  // return Obx(
  // () => Card(
  return Card(
    elevation: 0.0,
    child: centercard(n, opacity, fontSize),

    // color: (() {
    //   if (n != 0 && n == controller.problemid.value)
    //     return changeColorLightness(color).withOpacity(opacity);
    //   else
    //     return color.withOpacity(opacity);
    // }()),
    color: color.withOpacity(opacity),
    shape: RoundedRectangleBorder(
      // side: BorderSide(color: color.withOpacity(0.6 * opacity), width: 1),
      borderRadius: BorderRadius.circular(5),
    ),
    // ),
  );
}

class CrunchBox extends StatelessWidget {
  final int n;
  final String name;
  final double fontSize;
  final Color color;
  final Controller controller;
  final double opacity;
  CrunchBox({
    required this.controller,
    required this.n,
    required this.name,
    required this.color,
    this.fontSize = 20.0,
    this.opacity = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return (() {
      if (hasSolved(n, controller.solved))
        return Stack(
          children: [
            cardbuildexlbite(n, color, opacity, fontSize),
            new SvgPicture.asset('assets/bite.svg'),
            // new SvgPicture.asset('assets/crumbs.svg', color: color.withOpacity(opacity)),
          ],
        );
      else
        return cardbuildexlbite(n, color, opacity, fontSize);
    }());
  }
}

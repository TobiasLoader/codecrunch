import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../funcs.dart';
import '../problems/crunchbox.dart';
import '../setup.dart';

// class MasonryLayout extends StatelessWidget {
//   final int maxNum;
//   final Controller controller;
//   MasonryLayout({Key? key, required this.controller, this.maxNum = 50}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return Padding(
//       padding: EdgeInsets.all(7.0),
//       child: new StaggeredGridView.countBuilder(
//         crossAxisCount: 10,
//         itemCount: maxNum,
//         itemBuilder: (BuildContext context, int i) => cardbuildexlbite(
//             i + 1,
//             (() {
//               if (hasSolved(i + 1, controller.solved))
//                 return extractCardCol(i + 1);
//               else
//                  return Colors.grey;
//             }()),
//             1.0,
//             size.width / 50),
//         staggeredTileBuilder: (int i) => new StaggeredTile.count(1, extractCardSize(i + 1)),
//         mainAxisSpacing: 5.0,
//         crossAxisSpacing: 5.0,
//       ),
//     );
//   }
// }

Widget statsnumbutton(controller, i, bool solved, Color colour, double fontsize, [double fixedsize = 0]) {
  return Container(
    width: (() {
      if (fixedsize != 0) return fixedsize;
    }()),
    height: (() {
      if (fixedsize != 0) return fixedsize;
    }()),
    child: TextButton(
      onPressed: () {
        controller.problemid.value = i + 1;
        controller.page.value = "IndiStats";
      },
      child: Center(
        child: Text(
          (i + 1).toString(),
          style: TextStyle(
              color: (() {
                if (solved)
                  return Colors.white.withOpacity(0.8);
                else
                  return colour.withOpacity(0.5);
              })(),
              fontSize: 3 * fontsize / (1 + ((i + 1).toString().length - 1) / 2.5)),
        ),
      ),
    ),
  );
}

Widget statsproblemcard(sizewidth, controller, i, bool solved, Color colour, [double fixedsize = 0]) {
  var widthofgrid = sizewidth - 160;
  var fontsize = widthofgrid / (widthofgrid ~/ 100) / 7;
  return (() {
    if (!solved) {
      return Container(
        margin: const EdgeInsets.all(8),
        width: (() {
          if (fixedsize != 0) return fixedsize;
        }()),
        height: (() {
          if (fixedsize != 0) return fixedsize;
        }()),
        decoration: BoxDecoration(
          border: Border.all(color: colour.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(7),
          color: (() {
            if (solved)
              return colour;
            else
              return colour.withOpacity(0.07);
          })(),
        ),
        child: (() {
          if (fixedsize != 0)
            return statsnumbutton(controller, i, solved, colour, fontsize);
          else
            return statsnumbutton(controller, i, solved, colour, fontsize, fixedsize);
        }()),
      );
    } else
      return Stack(children: [
        (() {
          if (fixedsize == 0)
            return new SvgPicture.asset('assets/Emily_Toby_v4.svg', color: colour);
          else
            return new SvgPicture.asset(
              'assets/Emily_Toby_v4.svg',
              color: colour,
              width: fixedsize,
              height: fixedsize,
            );
        }()),
        statsnumbutton(controller, i, solved, colour, fontsize, fixedsize),
      ]);
  }());
}

class Stats extends StatelessWidget {
  Stats({Key? key, required this.controller}) : super(key: key);
  final Controller controller;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // return Center(child: Text('stats'));
    // return MasonryLayout(controller: controller, maxNum: Data.numProblems);
    return Center(
      child: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 80),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(extractCardName(controller.problemid.value).replaceFirst(' ', '\n'),
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black45,
                      ),
                      textAlign: TextAlign.right),
                  Padding(
                    padding: EdgeInsets.only(left: size.width / 20),
                    child: statsproblemcard(
                        size.width,
                        controller,
                        controller.problemid.value - 1,
                        hasSolved(controller.problemid.value, controller.solved),
                        extractCardCol(controller.problemid.value),
                        120),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: GridView.builder(
              padding: EdgeInsets.fromLTRB(50, 0, 50, 50),
              itemCount: Data.numProblems,
              itemBuilder: (BuildContext context, int i) {
                // if (i == 0)
                //   return statsproblemcard(
                //       size.width,
                //       controller,
                //       controller.problemid.value - 1,
                //       hasSolved(controller.problemid.value, controller.solved),
                //       extractCardCol(controller.problemid.value));
                // else if (i < controller.problemid.value)
                //   return statsproblemcard(
                //       size.width * 0.9, controller, i - 1, hasSolved(i, controller.solved), extractCardCol(i));
                // else
                return statsproblemcard(
                    size.width, controller, i, hasSolved(i + 1, controller.solved), extractCardCol(i + 1));
              },
              // decoration: BoxDecoration(
              //   // gradient: (() {
              //   //   if (hasSolved(i + 1, controller.solved))
              //   //     return LinearGradient(
              //   //         begin: Alignment.topLeft,
              //   //         end: Alignment.bottomRight,
              //   //         colors: [extractCardCol(i + 3), extractCardCol(i + 1), extractCardCol(i - 1)],
              //   //         stops: [0.2, 0.8, 1]);
              //   //   else
              //   //     return LinearGradient(
              //   //         begin: Alignment.topLeft,
              //   //         end: Alignment.bottomRight,
              //   //         colors: [Colors.black38, Colors.black45, Colors.black54],
              //   //         stops: [0.2, 0.8, 1]);

              //   color: (() {
              //     if (hasSolved(i + 1, controller.solved))
              //       return extractCardCol(i + 1);
              //     else
              //       return Colors.transparent;
              //   }()),
              //   border: Border.all(
              //     width: 0.5,
              //     color: Data.offwhite,
              //   ),
              // ),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: (size.width - 160) ~/ 100,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

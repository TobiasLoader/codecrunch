import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../funcs.dart';
import '../setup.dart';
import 'desc.dart';
import 'sidebar.dart';

class Problems extends StatelessWidget {
  Problems({Key? key, required this.controller}) : super(key: key);
  final Controller controller;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          gradient: (() {
            // if (Data.cardstacked)
            //   return LinearGradient(
            //     colors: [
            //       Data.offwhite,
            //       changeColorLightness(extractCardCol(controller.problemid.value)),
            //     ],
            //     begin: const FractionalOffset(0.0, 0.0),
            //     end: const FractionalOffset(1.5, 0.0),
            //     stops: [0.2, 1.0],
            //   );
            // else
            return RadialGradient(
              colors: [
                extractCardCol(controller.problemid.value),
                Colors.white,
              ],
              stops: [0.0, 1.0],
              center: Alignment(0.1, 0.3),
              focal: Alignment(-0.7, 0.6),
              focalRadius: 3,
            );
          }()),
        ),
        child: (() {
          // if (Data.cardstacked)
          //   return Row(
          //     children: [
          //       CrunchBoxSidebar(controller: controller, cardNum: Data.numProblems),
          //       Expanded(
          //         child: Align(
          //           alignment: Alignment.centerLeft,
          //           child: ProblemDescription(Data.keys[controller.problemid.value], controller),
          //         ),
          //       )
          //     ],
          //   );
          // else
          if (size.width > Data.wbounds[2]!)
            return Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Center(
                    child: Row(children: [
                      Spacer(),
                      Flexible(
                        flex: 4,
                        child: ProblemDescription(Data.keys[controller.problemid.value], controller),
                      ),
                      Spacer(),
                    ]),
                  ),
                ),
                VerticalDivider(
                  width: 1,
                  color: extractCardCol(controller.problemid.value).withOpacity(0.3),
                  thickness: 1,
                ),
                CrunchBoxSidebar(controller: controller, cardNum: Data.numProblems),
              ],
            );
          else
            return Center(
              child: Row(children: [
                Spacer(),
                Flexible(
                  flex: 4,
                  child: ProblemDescription(Data.keys[controller.problemid.value], controller),
                ),
                Spacer(),
              ]),
            );
        }()),
      ),
    );
  }
}

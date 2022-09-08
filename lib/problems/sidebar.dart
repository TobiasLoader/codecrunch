import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'crunchbox.dart';
import '../funcs.dart';
import '../setup.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CrunchBoxSidebar extends StatefulWidget {
  final int cardNum;
  late final double defaultSize;
  final Controller controller;
  final bool forcelarge;
  CrunchBoxSidebar({required this.controller, this.cardNum = 10, this.forcelarge = false}) {
    this.defaultSize = 70.0;
    // if (Data.cardstacked) this.defaultSize = 130.0;
    // if (!Data.cardstacked) this.defaultSize = 70.0;
  }

  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<CrunchBoxSidebar> {
  late ItemScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ItemScrollController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget drawCard(i) {
    return Obx(
      () => Container(
        width: widget.defaultSize * extractCardSize(i),
        height: widget.defaultSize * extractCardSize(i),
        child: CrunchBox(
            n: i,
            controller: widget.controller,
            name: extractCardName(i),
            color: extractCardCol(i),
            fontSize: extractCardSize(i) * widget.defaultSize / 5,
            opacity: (() {
              if (hasSolved(i, widget.controller.solved))
                return 0.5;
              else
                return 1.0;
            }())),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      // padding: (() {
      //   if (Data.cardstacked) return EdgeInsets.symmetric(horizontal: 10);
      // }()),
      // Container(
      color: Data.offwhite,
      width: (() {
        if (size.width > Data.wbounds[3]! || widget.forcelarge)
          return 250.0;
        else
          return 1.7 * widget.defaultSize;
      }()),
      child: ScrollablePositionedList.builder(
        itemCount: widget.cardNum + 2,
        initialScrollIndex: (() {
          if (widget.controller.problemid.value > 0)
            return widget.controller.problemid.value - 1;
          else
            return widget.controller.problemid.value;
        }()),
        itemScrollController: _scrollController,
        padding: EdgeInsets.symmetric(vertical: 10),
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int i) {
          if (i == 0)
            return TextButton(
              onPressed: () {
                var next = nextUnsolved(widget.controller.solved);
                _scrollController
                    .scrollTo(
                      index: next - 1,
                      duration: Duration(milliseconds: 700),
                      curve: Curves.easeInOutSine,
                    )
                    .then((i) => widget.controller.problemid.value = next);
              },
              child: Container(
                  child: (() {
                    if (size.width > Data.wbounds[3]! || widget.forcelarge)
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.downhill_skiing_rounded),
                          Text(
                            'Next Unsolved',
                            style: TextStyle(color: Colors.black45),
                          )
                        ],
                      );
                    else
                      return Icon(Icons.downhill_skiing_rounded);
                  }()),
                  height: 70),
            );
          else if (i <= widget.cardNum)
            return Align(
              heightFactor: 1,
              widthFactor: 2 / 3,
              alignment: Alignment.centerLeft,
              child: (() {
                // if (Data.cardstacked)
                //   return new InkWell(
                //       onTap: () {
                //         widget.controller.problemid.value = i;
                //       },
                //       child: drawCard(i));
                // else
                return Obx(
                  () => Material(
                    color: Colors.transparent,
                    child: new InkWell(
                      splashColor: extractCardCol(i).withOpacity(0.1),
                      onLongPress: () {},
                      highlightColor: extractCardCol(i).withOpacity(0.3),
                      splashFactory: (() {
                        if (hasSolved(i, widget.controller.solved))
                          return NoSplash.splashFactory;
                        else
                          return InkRipple.splashFactory;
                      }()),
                      hoverColor: (() {
                        if (hasSolved(i, widget.controller.solved))
                          return Data.offwhite;
                        else
                          return extractCardCol(i).withOpacity(0.1);
                      }()),
                      radius: 150,
                      onTap: () {
                        widget.controller.problemid.value = i;
                        if (size.width <= Data.wbounds[2]!) Navigator.of(context).pop();
                      },
                      child: Stack(children: [
                        Container(
                          child: (() {
                            if (size.width > Data.wbounds[3]! || widget.forcelarge)
                              return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                Flexible(
                                  flex: 1,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 15),
                                      child: drawCard(i),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(right: 15),
                                    child: Text(
                                      extractCardName(i),
                                      style: (() {
                                        if (hasSolved(i, widget.controller.solved))
                                          return TextStyle(
                                              fontSize: 13,
                                              // fontWeight: FontWeight.normal,
                                              color: Colors.black.withOpacity(0.4));
                                        else
                                          return TextStyle(
                                              fontSize: 14,
                                              // fontWeight: FontWeight.bold,
                                              color: Colors.black);
                                      }()),
                                    ),
                                  ),
                                ),
                              ]);
                            else
                              return Center(
                                child: drawCard(i),
                              );
                          }()),
                        ),
                        (() {
                          if (widget.controller.problemid.value == i)
                            return Container(
                                padding: EdgeInsets.only(left: 2),
                                height: widget.defaultSize * extractCardSize(i),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Icon(Icons.chevron_right_rounded, color: extractCardCol(i))));
                          else
                            return SizedBox.shrink();
                        }()),
                      ]),
                    ),
                  ),
                );
              }()),
            );
          else
            return TextButton(
              onPressed: () {
                _scrollController
                    .scrollTo(
                      index: 1,
                      duration: Duration(milliseconds: 700),
                      curve: Curves.easeInOutSine,
                    )
                    .then((i) => widget.controller.problemid.value = 1);
              },
              child: Container(
                  child: (() {
                    if (size.width > Data.wbounds[3]! || widget.forcelarge)
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.paragliding_rounded),
                          Text(
                            'To Top',
                            style: TextStyle(color: Colors.black45),
                          )
                        ],
                      );
                    else
                      return Center(child: Icon(Icons.paragliding_rounded));
                  }()),
                  height: 70),
            );
        },
      ),
    );
  }
}

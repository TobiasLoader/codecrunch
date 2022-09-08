import 'package:codecrunch/home/downarrow.dart';
import 'package:codecrunch/problems/crunchbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'dart:math';
import '../funcs.dart';
import '../setup.dart';

class Home extends StatefulWidget {
  final Controller controller;

  Home({Key? key, required this.controller}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late ItemScrollController _scrollController;
  var scrollpos = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ItemScrollController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget horizthreeboxgraphic(int n, {double s = 360.0}) {
    return Stack(alignment: Alignment.center, children: [
      Container(
        margin: EdgeInsets.fromLTRB(26 * s / 36, 2 * s / 36, 0, 0),
        child: Transform(
          alignment: Alignment.topRight,
          transform: Matrix4.skewY(0)..rotateZ(pi / 16.0),
          child: Container(
            width: s / 4,
            height: s / 4,
            child: cardbuildexlbite(
                dectobin((n + 2) % Data.numProblems), extractCardCol((n + 2) % Data.numProblems), 1.0, 18 * s / 360),
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.fromLTRB(4 * s / 36, 0, 0, 0),
        child: Transform(
          alignment: Alignment.topRight,
          transform: Matrix4.skewY(0)..rotateZ(-pi / 18.0),
          child: Container(
              width: s / 3,
              height: s / 3,
              child: cardbuildexlbite(
                  dectobin((n + 1) % Data.numProblems), extractCardCol((n + 1) % Data.numProblems), 1.0, 25 * s / 360)),
        ),
      ),
      Container(
        margin: EdgeInsets.fromLTRB(0, 0, 14 * s / 36, 0),
        child: Transform(
          alignment: Alignment.topRight,
          transform: Matrix4.skewY(0)..rotateZ(pi / 16.0),
          child: Container(
            width: 15 * s / 36,
            height: 15 * s / 36,
            child: cardbuildexlbite(dectobin(n), extractCardCol(n), 1.0, 3 * s / 36),
          ),
        ),
      ),
    ]);
  }

  Widget vertithreeboxgraphic(int n, {double s = 360.0}) {
    return Stack(alignment: Alignment.center, children: [
      Container(
        margin: EdgeInsets.fromLTRB(0, 27 * s / 36, 2 * s / 36, 0),
        child: Transform(
          alignment: Alignment.topRight,
          transform: Matrix4.skewY(0)..rotateZ(pi / 16.0),
          child: Container(
            width: s / 4,
            height: s / 4,
            child: cardbuildexlbite(
                dectobin((n + 2) % Data.numProblems), extractCardCol((n + 2) % Data.numProblems), 1.0, 18 * s / 360),
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.fromLTRB(0, 5 * s / 36, 8 * s / 36, 0),
        child: Transform(
          alignment: Alignment.topRight,
          transform: Matrix4.skewY(0)..rotateZ(-pi / 18.0),
          child: Container(
              width: s / 3,
              height: s / 3,
              child: cardbuildexlbite(
                  dectobin((n + 1) % Data.numProblems), extractCardCol((n + 1) % Data.numProblems), 1.0, 25 * s / 360)),
        ),
      ),
      Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 14 * s / 36),
        child: Transform(
          alignment: Alignment.topRight,
          transform: Matrix4.skewY(0)..rotateZ(pi / 16.0),
          child: Container(
            width: 15 * s / 36,
            height: 15 * s / 36,
            child: cardbuildexlbite(dectobin(n), extractCardCol(n), 1.0, 3 * s / 36),
          ),
        ),
      ),
    ]);
  }

  Widget hometextlarge() {
    return Padding(
      padding: EdgeInsets.only(right: 50),
      child: Align(
        alignment: Alignment.centerRight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Hello there !',
              style: TextStyle(color: Colors.black87, fontSize: 40, fontWeight: FontWeight.w300),
              textAlign: TextAlign.right,
            ),
            // FractionallySizedBox(
            //   widthFactor: 0.2,
            //   child: Divider(
            //     color: Colors.black45,
            //     height: 100.0,
            //     endIndent: 20,
            //   ),
            // ),
            // Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            //   Icon(Icons.chevron_left_rounded, color: Colors.black45),
            //   Text('dedicated to problem solving',
            //       style: TextStyle(color: Colors.black45, fontSize: 16, fontWeight: FontWeight.w300),
            //       textAlign: TextAlign.right),
            //   Icon(Icons.chevron_right_rounded, color: Colors.black45),
            // ])
            Text('dedicated to problem solving',
                style: TextStyle(color: Colors.black45, fontSize: 16, fontWeight: FontWeight.w300),
                textAlign: TextAlign.right),
          ],
        ),
      ),
    );
  }

  Widget hometextsmall() {
    return Center(
      child:
          Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
        Padding(
          padding: EdgeInsets.only(bottom: 30),
          child: Text(
            'Hello there !',
            style: TextStyle(color: Colors.black87, fontSize: 35, fontWeight: FontWeight.w300),
            textAlign: TextAlign.right,
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.chevron_left_rounded, color: Colors.black45),
          Text('dedicated to problem solving',
              style: TextStyle(color: Colors.black45, fontSize: 14, fontWeight: FontWeight.w300),
              textAlign: TextAlign.right),
          Icon(Icons.chevron_right_rounded, color: Colors.black45),
        ])
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: new LayoutBuilder(builder: (BuildContext context, BoxConstraints viewportConstraints) {
        var size = MediaQuery.of(context).size;
        return ScrollablePositionedList.builder(
            itemCount: 2,
            initialScrollIndex: scrollpos,
            itemScrollController: _scrollController,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int i) {
              return Container(
                  height: (() {
                    if (size.width > Data.wbounds[2.0]!)
                      return size.height - Data.appbarheight;
                    else
                      return size.height;
                  }()),
                  child: (() {
                    if (i == 0)
                      return Stack(
                          children: (() {
                        if (size.width > Data.wbounds[3.0]!)
                          return [
                            Row(children: [
                              Flexible(flex: 1, child: hometextlarge()),
                              Flexible(
                                flex: 1,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                        padding: EdgeInsets.only(left: 40),
                                        child: horizthreeboxgraphic(widget.controller.problemid.value))),
                              ),
                            ]),
                            DownArrow(controller: widget.controller, scrollController: _scrollController),
                          ];
                        else if (size.width > Data.wbounds[2.0]!)
                          return [
                            Row(children: [
                              Flexible(flex: 3, child: hometextlarge()),
                              Flexible(
                                  flex: 2,
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: vertithreeboxgraphic(widget.controller.problemid.value, s: 300))),
                            ]),
                            DownArrow(controller: widget.controller, scrollController: _scrollController, padding: 20),
                          ];
                        else if (size.width > Data.wbounds[1.0]!)
                          return [
                            Column(children: [
                              Flexible(flex: 1, child: hometextsmall()),
                              Flexible(
                                  flex: 1,
                                  child: Align(
                                      alignment: Alignment.topCenter,
                                      child: horizthreeboxgraphic(widget.controller.problemid.value, s: 300))),
                            ]),
                            // DownArrow(controller: widget.controller, scrollController: _scrollController, padding: 10),
                          ];
                        else
                          return [
                            Column(children: [
                              Flexible(flex: 2, child: hometextsmall()),
                              Flexible(
                                  flex: 3,
                                  child: Align(
                                      alignment: Alignment.topCenter,
                                      child: vertithreeboxgraphic(widget.controller.problemid.value, s: 300))),
                            ]),
                            // DownArrow(
                            //   controller: widget.controller,
                            //   scrollController: _scrollController,
                            //   padding: 0,
                            //   alignment: Alignment.bottomRight,
                            // )
                          ];
                      }()));
                    else
                      return Stack(children: [
                        Row(children: [
                          Flexible(
                              flex: 2,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: new SvgPicture.asset('assets/Emily_Toby_v4.svg',
                                    color: extractCardCol(widget.controller.problemid.value),
                                    width: min(size.width, size.height) / 3),
                              )),
                          Flexible(
                            flex: 3,
                            child: Center(
                              child: Text(
                                "Code\nCrunch\nRepeat.",
                                style: TextStyle(
                                    fontSize: min(size.width, 2 * size.height) / 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black38),
                              ),
                            ),
                          ),
                        ]),
                        DownArrow(controller: widget.controller, scrollController: _scrollController, flipped: true)
                      ]);
                  }()));
            });
      }),
    );
  }
}

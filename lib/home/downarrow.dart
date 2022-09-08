import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../setup.dart';

class DownArrow extends StatefulWidget {
  final Controller controller;
  final ItemScrollController scrollController;
  final bool flipped;
  final double padding;
  final Alignment alignment;
  DownArrow({
    required this.controller,
    required this.scrollController,
    this.flipped = false,
    this.padding = 30.0,
    this.alignment = Alignment.bottomCenter,
  });

  @override
  _DownArrowState createState() => _DownArrowState();
}

class _DownArrowState extends State<DownArrow> with TickerProviderStateMixin {
  late AnimationController _animationControllerRot;
  late AnimationController _animationControllerOp;

  late CurvedAnimation _curveRot;
  late CurvedAnimation _curveOp;

  late Animation _animationrot;
  late Animation _animationop;
  late double smoothvalue;

  @override
  void initState() {
    super.initState();
    _animationControllerRot = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationControllerRot.repeat(reverse: true);
    _animationControllerOp = AnimationController(vsync: this, duration: Duration(seconds: 3));
    _animationControllerOp.repeat(reverse: true);
    _curveRot = CurvedAnimation(parent: _animationControllerRot, curve: Curves.easeInOutSine);
    _curveOp = CurvedAnimation(parent: _animationControllerOp, curve: Curves.elasticInOut);
    _animationrot = Tween(begin: -0.06, end: 0.06).animate(_curveRot)
      ..addListener(() {
        setState(() {});
      });

    _animationop = Tween(begin: 0.2, end: 0.4).animate(_curveOp)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _animationControllerRot.dispose();
    _animationControllerOp.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(widget.padding),
      child: Container(
        alignment: widget.alignment,
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.skewY(0)..rotateZ((pi) * _animationrot.value),
          child: IconButton(
            iconSize: 50,
            icon: Icon(
              (() {
                if (!widget.flipped)
                  return Icons.keyboard_arrow_down_rounded;
                else
                  return Icons.keyboard_arrow_up_rounded;
              }()),
              color: Colors.black.withOpacity(_animationop.value),
            ),
            onPressed: () {
              setState(() {
                widget.scrollController.scrollTo(
                  index: (() {
                    if (!widget.flipped)
                      return 1;
                    else
                      return 0;
                  }()),
                  duration: Duration(milliseconds: 700),
                  curve: Curves.easeInOutSine,
                );
              });
            },
          ),
        ),
      ),
    );
  }
}

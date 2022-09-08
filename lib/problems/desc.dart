import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../funcs.dart';
import '../setup.dart';

class ProblemDescription extends StatefulWidget {
  final Controller controller;
  ProblemDescription(Key key, this.controller) : super(key: key);

  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<ProblemDescription> {
  late ConfettiController _confettiController;
  bool answeredincorrect = false;

  @override
  void initState() {
    super.initState();
    Data.txtControllers[widget.controller.problemid.value].addListener(() {
      if (this.mounted)
        return setState(() {
          answeredincorrect = false;
        });
    });
    _confettiController = ConfettiController(duration: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  Widget answerbox() {
    return TextField(
      controller: Data.txtControllers[widget.controller.problemid.value],
      decoration: InputDecoration(
        helperText: '',
        errorText: (() {
          if (answeredincorrect)
            return errormsg();
          else
            return null;
        }()),
        suffixIcon: (() {
          if (answeredincorrect)
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: new SvgPicture.asset('assets/cross.svg'),
            );
          else
            return SizedBox.shrink();
        }()),
        prefixIcon: Icon(Icons.chevron_right_rounded),
        hintText: 'Answer',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget crunchbutton() {
    return Container(
      width: 110,
      height: 56,
      decoration: BoxDecoration(
        color: extractCardCol(widget.controller.problemid.value).withOpacity(0.9),
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextButton(
        onPressed: () {
          if (questionSuccess(
              widget.controller.problemid.value, Data.txtControllers[widget.controller.problemid.value].text)) {
            _confettiController.play();
            widget.controller.solved.value = new Map<int, bool>.from(widget.controller.solved)
              ..addAll({widget.controller.problemid.value: true});
          } else {
            if (this.mounted) {
              setState(() {
                answeredincorrect = true;
              });
            }
          }
        },
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("CRUNCH ", style: TextStyle(color: Colors.white)),
              Text("!", style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic)),
            ],
          ),
        ),
      ),
    );
  }

  Widget hintbutton() {
    return Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          border: Border(
            left: BorderSide(color: extractCardCol(widget.controller.problemid.value), width: 1),
            top: BorderSide(color: extractCardCol(widget.controller.problemid.value), width: 1),
            right: BorderSide(color: extractCardCol(widget.controller.problemid.value), width: 1),
            bottom: BorderSide(color: extractCardCol(widget.controller.problemid.value), width: 1),
          ),
        ),
        child: TextButton(
            onPressed: () {},
            child: Center(
                child: Text("Hint", style: TextStyle(color: extractCardCol(widget.controller.problemid.value))))));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        Spacer(),
        Flexible(
          flex: 8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Center(
                  child: Text(
                      widget.controller.problemid.value.toString() +
                          ". " +
                          extractCardName(widget.controller.problemid.value),
                      style: TextStyle(fontSize: 25),
                      textAlign: TextAlign.center)),
              Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 200),
                  child: SingleChildScrollView(
                      child: Text(
                    extractCardDesc(widget.controller.problemid.value),
                    textAlign: TextAlign.justify,
                    style: TextStyle(height: 1.7),
                  )),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Question by ' + questionAuthor(widget.controller.problemid.value),
                    style: TextStyle(color: Colors.black38, fontSize: 13)),
              ),
              Obx(
                () => Center(
                    child: (() {
                  if (hasSolved(widget.controller.problemid.value, widget.controller.solved))
                    return Stack(alignment: Alignment.center, children: [
                      Container(
                        height: 50,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Center(
                                child: Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Text(solutionToProblem(widget.controller.problemid.value).toString()))),
                            Center(
                              widthFactor: 1,
                              child: Padding(
                                  padding: EdgeInsets.only(left: 10), child: new SvgPicture.asset('assets/tick.svg')),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border(
                            left: BorderSide(
                                color: extractCardCol(widget.controller.problemid.value).withOpacity(0.5), width: 1),
                            top: BorderSide(
                                color: extractCardCol(widget.controller.problemid.value).withOpacity(0.5), width: 1),
                            right: BorderSide(
                                color: extractCardCol(widget.controller.problemid.value).withOpacity(0.5), width: 1),
                            bottom: BorderSide(
                                color: extractCardCol(widget.controller.problemid.value).withOpacity(0.5), width: 1),
                          ),
                        ),
                      ),
                      ConfettiWidget(
                        confettiController: _confettiController,
                        blastDirectionality: BlastDirectionality.explosive,
                        particleDrag: 0.05,
                        emissionFrequency: 0.05,
                        numberOfParticles: 20,
                        gravity: 0.05,
                        shouldLoop: false,
                        colors: [
                          extractCardCol(widget.controller.problemid.value),
                          changeColorLightness(extractCardCol(widget.controller.problemid.value))
                        ], // manually specify the colors to be used
                      ),
                    ]);
                  else {
                    if (size.width > Data.wbounds[3.0]!)
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Spacer(),
                          Flexible(
                            flex: 6,
                            child: answerbox(),
                          ),
                          Spacer(),
                          crunchbutton(),
                          // Spacer(),
                          // hintbutton(),
                          Spacer(),
                        ],
                      );
                    else if (size.width > Data.wbounds[1]!)
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            flex: 6,
                            child: answerbox(),
                          ),
                          Spacer(),
                          crunchbutton(),
                          // Spacer(),
                          // hintbutton(),
                        ],
                      );
                    else
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          answerbox(),

                          crunchbutton(),
                          // Spacer(),
                          // hintbutton(),
                        ],
                      );
                  }
                }())),
              ),
            ],
          ),
        ),
        Spacer(),
      ],
    );
  }
}

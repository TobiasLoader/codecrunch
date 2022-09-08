import 'dart:math';

import 'package:flutter/material.dart';
import 'setup.dart';

Color changeColorLightness(Color c) {
  return HSLColor.fromColor(c).withLightness(0.85).toColor();
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}

double extractCardSize(i) {
  if (Data.ls.containsKey(i))
    return Data.ls[i]!;
  else
    return 1.0;
}

String extractCardName(i) {
  if (Data.names.containsKey(i))
    return Data.names[i]!;
  else
    return "Problem";
}

String extractCardDesc(i) {
  if (Data.descriptions.containsKey(i))
    return Data.descriptions[i]!;
  else
    return "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
}

Color extractCardCol(i) {
  return Color.lerp(Data.cs[(((i - 1) / 10).floor()) % Data.cs.length]!,
      Data.cs[(((i - 1) / 10).floor() + 1) % Data.cs.length]!, ((i - 1) % 10) / 10)!;
}

bool hasSolved(i, solvedlist) {
  if (solvedlist.containsKey(i))
    return solvedlist[i]!;
  else
    return false;
}

String questionAuthor(i) {
  if (Data.authors.containsKey(i))
    return Data.authors[i]!;
  else
    return "Tobias Loader";
}

int solutionToProblem(questionNumber) {
  if (Data.problemSolutions[questionNumber] != null)
    return Data.problemSolutions[questionNumber]!;
  else
    return 50;
}

bool questionSuccess(questionNumber, submission) {
  return int.tryParse(submission) == solutionToProblem(questionNumber);
}

String errormsg() {
  return Data.errmsgs[Random().nextInt(Data.errmsgs.length)];
}

int nextUnsolved(solved) {
  for (var i = 1; i < Data.numProblems; i += 1) {
    if (!solved.containsKey(i) || solved[i] == false) return i;
  }
  return 1;
}

int dectobin(input) {
  int dec = input;
  int bin = 0, i = 1;
  while (dec > 0) {
    bin = bin + (dec % 2) * i;
    dec ~/= 2;
    i = i * 10;
  }
  return bin;
}

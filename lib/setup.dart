import 'package:get/get.dart';
import 'package:flutter/material.dart';

class Controller extends GetxController {
  var problemid = 1.obs;
  var solved = {
    1: true,
    2: true,
    3: true,
    8: true,
    9: true,
    10: true,
    12: true,
    14: true,
  }.obs;
  var page = "Home".obs;
  var titlecol = Colors.black38.obs;

  var usernameCont = TextEditingController();
  var emailCont = TextEditingController();
  var countryCont = TextEditingController();
}

class Data {
  Data();

  static int numProblems = 50;

  static Map<int, int> problemSolutions = {1: 40};

  static Map<double, double> wbounds = {1: 400, 2: 600, 2.5: 700, 3: 800};

  static Color offwhite = Color.fromARGB(255, 254, 252, 247);
  static Color offwhitedark = Color.fromARGB(255, 182, 180, 174);

  static Map<int, double> ls = {
    // 0: 1,
    // 1: 1.15,
    // 2: 1.1,
    // 3: 1,
    // 4: 1.1,
    // 5: 1,
    // 6: 1.1,
    // 7: 1.1,
    // 8: 1.15,
    // 9: 1.05,
    // 10: 1.15,
    // 11: 0.8,
    // 12: 1.2,
    // 13: 0.9,
    // 14: 0.95,
    // 15: 1.1,
    // 16: 1.15
  };

  static Map<int, String> names = {
    1: "Palindrome",
    2: "Poker Probabilities",
    3: "Rabbits vs Foxes",
    4: "Organic Chemistry",
    5: "Divisible triangular number"
  };
  static Map<int, Color> cs = {
    0: Color.fromARGB(255, 40, 124, 196),
    1: Color.fromARGB(255, 196, 64, 50),
    // 2: Color.fromARGB(255, 205, 113, 63),
    2: Color.fromARGB(255, 123, 154, 29),
    3: Color.fromARGB(255, 29, 143, 114),
  };
  static Map<int, String> authors = {2: "Nick Maslov", 4: "Prahalad Giridhar"};

  static Map<int, String> descriptions = {
    1: "Palindrome problem bla bla bla Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    2: "Poker problem bla bla bla Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    3: "Rabbit problem bla bla bla Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    4: "Chemistry problem bla bla bla Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
  };

  static List<Key> keys = List<Key>.generate(numProblems + 1, (int index) => UniqueKey());

  static List<TextEditingController> txtControllers =
      List<TextEditingController>.generate(numProblems + 1, (int index) => TextEditingController());

  static List<String> errmsgs = [
    'Better luck next time',
    'Oops, never mind...',
    'Gotta try again',
    "You'll get it next time",
    'Try harder next time',
    'Close! (but not close enough)',
    'So close yet so far',
    'Nearly there!',
    'Keep trying!',
    'Worse things happen at sea',
    'Nevermind',
    'You can do it, keep going :)',
    'Sorry, not quite',
    'Whoopsie',
    'Oh noes!',
    'Nah, wrong!',
    'Arghh!',
    'Tough luck',
    'Have another go',
    'Yikes',
    'What was that??',
    'Oh noes! Please try again :)',
  ];

  static double appbarheight = 70.0;

  static List<String> pagenames = ['Home', 'About', 'Problems', 'Stats'];
}

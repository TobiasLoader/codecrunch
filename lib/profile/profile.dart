import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../funcs.dart';
import '../setup.dart';

class Profile extends StatefulWidget {
  final Controller controller;
  Profile({Key? key, required this.controller}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Widget answerbox(TextEditingController txtcont, String hinttxt) {
    return TextField(
      controller: txtcont,
      decoration: InputDecoration(
        helperText: '',
        errorText: (() {
          return null;
        }()),
        prefixIcon: Icon(Icons.chevron_right_rounded),
        hintText: hinttxt,
        labelText: hinttxt,
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget submitbutton() {
    return Container(
      width: 300,
      height: 56,
      decoration: BoxDecoration(
        color: extractCardCol(widget.controller.problemid.value).withOpacity(0.9),
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextButton(
        onPressed: () {},
        child: Center(
          child: Text("SUBMIT", style: TextStyle(color: Colors.white, fontSize: 18)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // return Center(child: Text('stats'));
    // return MasonryLayout(controller: controller, maxNum: Data.numProblems);
    return Center(
      child: Container(
        width: 300,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          // Center(
          //   child: Padding(
          //     padding: EdgeInsets.symmetric(vertical: 30),
          //     child: Text(
          //       "User Profile",
          //       style: TextStyle(fontSize: 20, overflow: TextOverflow.ellipsis),
          //     ),
          //   ),
          // ),
          answerbox(widget.controller.usernameCont, "username"),
          answerbox(widget.controller.emailCont, "email"),
          answerbox(widget.controller.countryCont, "country"),
          submitbutton(),
        ]),
      ),
    );
  }
}

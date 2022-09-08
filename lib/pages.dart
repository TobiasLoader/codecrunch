import 'package:codecrunch/problems/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'about/about.dart';
import 'funcs.dart';
import 'home/home.dart';
import 'problems/problems.dart';
import 'setup.dart';
import 'stats/stats.dart';
import 'stats/indistats.dart';
import 'profile/profile.dart';

Widget writepages(context, controller) {
  return Obx(
    () => Container(
      decoration: BoxDecoration(
          gradient: RadialGradient(
        colors: [
          extractCardCol(controller.problemid.value),
          Colors.white,
        ],
        stops: [0.0, 1.0],
        center: Alignment(0.1, 0.3),
        focal: Alignment(-0.7, 0.6),
        focalRadius: 3,
      )),
      child: (() {
        if (controller.page.value == "Home")
          return Home(controller: controller);
        else if (controller.page.value == "About")
          return About(controller: controller);
        else if (controller.page.value == "Problems")
          return Problems(controller: controller);
        else if (controller.page.value == "Stats")
          return Stats(controller: controller);
        else if (controller.page.value == "IndiStats")
          return IndiStats(controller: controller);
        else if (controller.page.value == "Profile")
          return Profile(controller: controller);
        else
          return Container();
      }()),
    ),
  );
}

Widget menubutton(context, {double padding = 40.0}) {
  return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: EdgeInsets.fromLTRB(padding, padding, 0, 0),
        child: Card(
          elevation: 0.0,
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.black38, width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            constraints: BoxConstraints(maxHeight: 40, maxWidth: 40),
            iconSize: 25,
            // padding: EdgeInsets.all(5),
            icon: Icon(
              Icons.menu_rounded,
              color: Colors.black.withOpacity(0.7),
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ));
}

Widget problemsbutton(context, {double padding = 40.0}) {
  return Align(
      alignment: Alignment.topRight,
      child: Container(
        margin: EdgeInsets.fromLTRB(0, padding, padding, 0),
        child: Card(
          elevation: 0.0,
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.black38, width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            constraints: BoxConstraints(maxHeight: 40, maxWidth: 40),
            iconSize: 25,
            // padding: EdgeInsets.all(5),
            icon: Icon(
              // local_parking_rounded
              // checklist_rounded
              // assignment_rounded
              Icons.checklist_rounded,
              color: Colors.black.withOpacity(0.7),
            ),
            onPressed: () => Scaffold.of(context).openEndDrawer(),
          ),
        ),
      ));
}

PreferredSizeWidget appbar(context, Controller controller, Size size) {
  return AppBar(
      leading: Padding(
        padding: EdgeInsets.only(left: 20),
        child: new SvgPicture.asset('assets/Emily_Toby_v2.svg', color: extractCardCol(controller.problemid.value)),
      ),
      toolbarHeight: Data.appbarheight,
      backgroundColor: Data.offwhite,
      elevation: 0.0,
      shape: Border(bottom: BorderSide(color: extractCardCol(controller.problemid.value), width: 1)),
      title: Text('CodeCrunch.io', style: TextStyle(color: Colors.black45)),
      actions: (() {
        var a = List<Widget>.generate(
          Data.pagenames.length,
          (int i) => TextButton(
            onPressed: () {
              controller.page.value = Data.pagenames[i];
            },
            child: Container(
              padding: (() {
                if (size.width > Data.wbounds[3.0]!)
                  return EdgeInsets.symmetric(horizontal: 20);
                else if (size.width > Data.wbounds[2.5]!)
                  return EdgeInsets.symmetric(horizontal: 10);
                else
                  return EdgeInsets.symmetric(horizontal: 5);
              }()),
              child: Obx(
                () => Text(
                  Data.pagenames[i],
                  style: TextStyle(
                    color: (() {
                      if (controller.page.value == Data.pagenames[i])
                        return extractCardCol(controller.problemid.value);
                      else
                        return Colors.black54;
                    }()),
                  ),
                ),
              ),
            ),
          ),
        );
        a.add(
          Padding(
            padding: (() {
              if (size.width > Data.wbounds[3.0]!)
                return EdgeInsets.symmetric(horizontal: 20);
              else if (size.width > Data.wbounds[2.5]!)
                return EdgeInsets.symmetric(horizontal: 10);
              else
                return EdgeInsets.symmetric(horizontal: 5);
            }()),
            child: Obx(
              () => IconButton(
                icon: Icon(Icons.account_circle_rounded),
                onPressed: () {
                  controller.page.value = "Profile";
                },
                splashRadius: 30,
                iconSize: 30,
                color: (() {
                  if (controller.page.value == 'Profile')
                    return extractCardCol(controller.problemid.value);
                  else
                    return Colors.black38;
                }()),
              ),
            ),
          ),
        );
        return a;
      }()));
}

Widget pagesdrawersidebar(context, Controller controller, Size size) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.only(top: 50),
      children: (() {
        var a = List<Widget>.generate(
          Data.pagenames.length,
          (int i) => TextButton(
            onPressed: () {
              controller.page.value = Data.pagenames[i];
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Obx(
                () => Text(
                  Data.pagenames[i],
                  style: TextStyle(
                    color: (() {
                      if (controller.page.value == Data.pagenames[i])
                        return Colors.black;
                      else
                        return Colors.black45;
                    }()),
                  ),
                ),
              ),
            ),
          ),
        );
        a.insert(
          0,
          TextButton(
            onPressed: () {
              controller.page.value = Data.pagenames[0];
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Padding(
                  padding: EdgeInsets.only(right: 30),
                  child: new SvgPicture.asset('assets/codecrunchlogo.svg', width: 30),
                ),
                Text(
                  "CodeCrunch.io",
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 20,
                  ),
                ),
              ]),
            ),
          ),
        );
        a.insert(
          1,
          Divider(),
        );
        a.add(
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Obx(
              () => IconButton(
                icon: Icon(Icons.account_circle_rounded),
                onPressed: () {
                  controller.page.value = "Profile";
                  Navigator.pop(context);
                },
                splashRadius: 30,
                iconSize: 30,
                color: (() {
                  if (controller.page.value == 'Profile')
                    return Colors.black54;
                  else
                    return Colors.black38;
                }()),
              ),
            ),
          ),
        );
        return a;
      }()),
    ),
  );
}

class Pages extends StatelessWidget {
  Pages({Key? key, required this.controller}) : super(key: key);
  final Controller controller;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Obx(
      () => Scaffold(
        endDrawer: (() {
          if (size.width <= Data.wbounds[2.0]! && controller.page.value == 'Problems')
            return CrunchBoxSidebar(controller: controller, cardNum: Data.numProblems, forcelarge: true);
          else
            return SizedBox.shrink();
        }()),
        drawer: (() {
          if (size.width <= Data.wbounds[2.0]!) return pagesdrawersidebar(context, controller, size);
        }()),
        appBar: (() {
          if (size.width > Data.wbounds[2.0]!) return appbar(context, controller, size);
        }()),
        body: Builder(
          builder: (context) => (() {
            // return Obx(() {
            if (size.width > Data.wbounds[2.0]!)
              return writepages(context, controller);
            else if (size.width > Data.wbounds[1.0]! && this.controller.page.value == "Problems")
              return Stack(children: [
                writepages(context, controller),
                menubutton(context),
                problemsbutton(context),
              ]);
            else if (size.width <= Data.wbounds[1.0]! && this.controller.page.value == "Problems")
              return Stack(children: [
                writepages(context, controller),
                menubutton(context, padding: 20),
                problemsbutton(context, padding: 20),
              ]);
            else if (size.width > Data.wbounds[1.0]! && this.controller.page.value != "Problems")
              return Stack(children: [
                writepages(context, controller),
                menubutton(context),
              ]);
            else
              return Stack(children: [
                writepages(context, controller),
                menubutton(context, padding: 20),
              ]);
          }()),
        ),
      ),
    );
  }
}

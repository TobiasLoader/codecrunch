import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'funcs.dart';
import 'pages.dart';
import 'setup.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Crunch());
}

class Crunch extends StatelessWidget {
  final Controller controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CodeCrunch',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'JetBrainsMono',
        primarySwatch: createMaterialColor(Data.offwhitedark),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        highlightColor: Colors.black.withOpacity(.5),
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
      home: Pages(controller: controller),
    );
  }
}

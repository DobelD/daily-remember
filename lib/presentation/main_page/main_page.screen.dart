import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'controllers/main_page.controller.dart';

class MainPageScreen extends GetView<MainPageController> {
  const MainPageScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainPageController>(builder: (_) {
      return Scaffold(
          body: IndexedStack(
            index: controller.tabIndex,
            children: controller.listPages,
          ),
          // bottomNavigationBar: SnakeNavigationBar.color(
          //   behaviour: SnakeBarBehaviour.pinned,
          //   snakeShape: SnakeShape.circle,
          //   // shape: ,
          //   // padding: padding,

          //   ///configuration for SnakeNavigationBar.color
          //   snakeViewColor: Colors.blueAccent,
          //   selectedItemColor: Colors.white,
          //   unselectedItemColor: Colors.grey.shade300,

          //   ///configuration for SnakeNavigationBar.gradient
          //   //snakeViewGradient: selectedGradient,
          //   //selectedItemGradient: snakeShape == SnakeShape.indicator ? selectedGradient : null,
          //   //unselectedItemGradient: unselectedGradient,

          //   // showUnselectedLabels: showUnselectedLabels,
          //   // showSelectedLabels: showSelectedLabels,

          //   currentIndex: controller.tabIndex,
          //   onTap: controller.changeTabIndex,
          //   items: controller.listIcon
          //       .map((e) => BottomNavigationBarItem(
          //           label: e['label'], icon: Icon(e['icon'])))
          //       .toList(),
          // ),
          bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.white,
              currentIndex: controller.tabIndex,
              onTap: controller.changeTabIndex,
              selectedItemColor: Colors.blueAccent,
              unselectedItemColor: Colors.grey.shade300,
              selectedLabelStyle:
                  GoogleFonts.inter(fontSize: 12, color: Colors.blueAccent),
              unselectedLabelStyle:
                  GoogleFonts.inter(fontSize: 12, color: Colors.grey.shade400),
              type: BottomNavigationBarType.fixed,
              items: controller.listIcon
                  .map((e) => BottomNavigationBarItem(
                      label: e['label'], icon: Icon(e['icon'])))
                  .toList()));
    });
  }
}

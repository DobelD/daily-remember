import 'package:dailyremember/infrastructure/navigation/routes.dart';
import 'package:dailyremember/infrastructure/theme/typography.dart';
import 'package:dailyremember/presentation/home/section/english_to_indonesia.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/home.controller.dart';
import 'section/indonesia_to_english.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          heroTag: "home",
          backgroundColor: Colors.blueAccent,
          child: const Icon(
            Icons.book,
          ),
          onPressed: () => Get.toNamed(Routes.ADD_WORD,
              arguments: {"type": "add", "data": null})),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
            headerSliverBuilder: (_, isInnerBoxScrolled) {
              return [
                SliverAppBar(
                  backgroundColor:
                      isInnerBoxScrolled ? Colors.blueAccent : Colors.white,
                  title: Text(
                    'Daily Remember',
                    style: headerBold,
                  ),
                  elevation: 1,
                  floating: true,
                  pinned: true,
                  actions: [
                    IconButton(
                        onPressed: () => controller.openDialogTarget(),
                        icon: const Icon(
                          Icons.track_changes_outlined,
                          color: Colors.blueAccent,
                        ))
                  ],
                  bottom: TabBar(
                    labelStyle: hintTitleNormal,
                    labelColor:
                        isInnerBoxScrolled ? Colors.white : Colors.blueAccent,
                    unselectedLabelColor: isInnerBoxScrolled
                        ? Colors.white.withOpacity(0.8)
                        : Colors.grey.shade400,
                    tabs: const [
                      Tab(text: 'English - Indonesia'),
                      Tab(text: 'Indonesia - English'),
                    ],
                  ),
                )
              ];
            },
            body: const TabBarView(
              physics: ScrollPhysics(),
              children: [
                EnglishToIndonesia(),
                IndonesiaToEnglish(),
              ],
            )),
      ),
    );
  }
}

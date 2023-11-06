import 'package:dailyremember/presentation/home/controllers/home.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../domain/core/model/word_model.dart';
import '../../../infrastructure/theme/typography.dart';
import '../../../utils/style_helper/default_border_radius.dart';

Widget buildListTile(HomeController controller, WordModel data, String tab) {
  String title = tab == "eng"
      ? data.english?.capitalizeFirst ?? ''
      : data.indonesia?.capitalizeFirst ?? '';
  String subtitle = tab == "eng"
      ? data.indonesia?.capitalizeFirst ?? ''
      : data.english?.capitalizeFirst ?? '';
  return Card(
    color: data.remember == true ? Colors.blueAccent : Colors.white,
    elevation: 4,
    shadowColor: const Color(0xFF6680C5).withOpacity(0.1),
    shape: RoundedRectangleBorder(
      borderRadius: radiusNormal,
    ),
    child: ListTile(
        onTap: () => controller.openDetailWord(data),
        title: Text(
          title,
          style: data.remember == true ? whiteTitleNormal : titleNormal,
        ),
        subtitle: Text(
          subtitle,
          style: data.remember == true
              ? whiteHintSubTitleNormal
              : hintSubTitleNormal,
        ),
        trailing: Obx(() => PopupMenuButton<int>(
              icon: Icon(
                Icons.more_vert_rounded,
                color:
                    data.remember == true ? Colors.white : Colors.grey.shade400,
              ),
              initialValue: tab == "eng"
                  ? controller.selectedActionOnEnglish.value
                  : controller.selectedActionOnIndonesia.value,
              onSelected: (int value) {
                tab == "eng"
                    ? controller.selectActionOnEnglish(value, data)
                    : controller.selectActionOnIndonesia(value, data);
              },
              itemBuilder: (BuildContext context) {
                List<PopupMenuEntry<int>> items = [];

                for (int index = 0;
                    index < controller.listAction.length;
                    index++) {
                  if (data.remember != true || index != 0) {
                    items.add(
                      PopupMenuItem<int>(
                        value: index,
                        child: Text(controller.listAction[index],
                            style: subTitleNormal),
                      ),
                    );
                  }
                }

                return items;
              },
            ))),
  );
}

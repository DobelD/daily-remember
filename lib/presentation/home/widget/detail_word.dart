import 'package:dailyremember/components/app_bottom_sheet.dart';
import 'package:dailyremember/infrastructure/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../domain/core/model/word_model.dart';

class DetailWord extends StatelessWidget {
  const DetailWord({super.key, required this.data});

  final WordModel data;

  @override
  Widget build(BuildContext context) {
    return AppBottomSheet.witoutFooter(
      title: "Vocabulary",
      child: Column(
        children: List.generate(
            5,
            (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    children: [
                      Icon(
                        Icons.circle_rounded,
                        color: Colors.black,
                        size: 6.r,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                          flex: 3,
                          child: Text(
                            title(index),
                            style: titleNormal,
                          )),
                      const Expanded(flex: 1, child: Text(":")),
                      Expanded(
                          flex: 8,
                          child: Text(
                            value(
                                index: index,
                                v1: data.verbOne,
                                v2: data.verbTwo,
                                v3: data.verbThree,
                                vIng: data.verbIng,
                                indo: data.indonesia),
                            style: titleBold,
                          )),
                    ],
                  ),
                )),
      ),
    );
  }

  String title(int index) {
    return index == 4 ? "Meaning" : "Verb ${index == 3 ? 'Ing' : index + 1}";
  }

  String value(
      {String? v1,
      String? v2,
      String? v3,
      String? vIng,
      String? indo,
      required int index}) {
    String nullValue = "-";
    if (index == 0) {
      return v1 ?? nullValue;
    } else if (index == 1) {
      return v2 ?? nullValue;
    } else if (index == 2) {
      return v3 ?? nullValue;
    } else if (index == 3) {
      return vIng ?? nullValue;
    } else {
      return indo ?? nullValue;
    }
  }

  TextStyle styleText(
      {String? english,
      String? v1,
      String? v2,
      String? v3,
      String? vIng,
      String? indo,
      required int index}) {
    TextStyle nullValue = hintTitleNormal;
    TextStyle notNullValue = titleNormal;

    if (index == 0) {
      return v1 != null ? notNullValue : nullValue;
    } else if (index != 1) {
      return v2 != null ? notNullValue : nullValue;
    } else if (index != 2) {
      return v3 != null ? notNullValue : nullValue;
    } else if (index != 3) {
      return vIng != null ? notNullValue : nullValue;
    } else {
      return indo != null ? notNullValue : nullValue;
    }
  }
}

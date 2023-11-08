import 'package:dailyremember/domain/core/model/local_storage/auth_model.dart';
import 'package:dailyremember/infrastructure/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:substring_highlight/substring_highlight.dart';

import '../../../../components/app_form.dart';
import '../controllers/login.controller.dart';

class AutocompliteForm extends StatelessWidget {
  const AutocompliteForm({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (controller) {
      return SizedBox(
        child: LayoutBuilder(builder: (_, BoxConstraints constraints) {
          return RawAutocomplete(
            key: controller.autocompleteKey,
            focusNode: controller.focusNode,
            textEditingController: controller.emailController,
            optionsBuilder: (value) {
              return controller.authData
                  .where((auth) => auth.email
                      .toLowerCase()
                      .contains(value.text.toLowerCase()))
                  .toList();
            },
            fieldViewBuilder:
                (context, TextEditingController control, focuse, function) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppForm(
                    focusNode: focuse,
                    controller: control,
                    onEditingComplete: function,
                    hintText: "Email...",
                  ),
                ],
              );
            },
            optionsViewBuilder: (context, select, auth) {
              double heightContain = auth.length * 74;
              double textFieldWidth = constraints.maxWidth;
              return Stack(
                children: [
                  Positioned(
                    top: 0,
                    width: textFieldWidth,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.w),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                              maxHeight: auth.length == 1 ? 60 : heightContain),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(6.r),
                                boxShadow: [
                                  BoxShadow(
                                      color:
                                          Colors.blueAccent.withOpacity(0.05))
                                ]),
                            child: Padding(
                              padding:
                                  EdgeInsets.fromLTRB(16.w, 16.w, 8.w, 16.w),
                              child: Container(
                                color: Colors.white,
                                width: Get.width,
                                child: GestureDetector(
                                  onTap: () => select(auth.elementAt(0)),
                                  child: SubstringHighlight(
                                    text: auth.elementAt(0).email,
                                    textStyle: titleNormal,
                                    textStyleHighlight: titleBold,
                                    term: controller.emailController.text,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
            displayStringForOption: (AuthModel p) {
              return p.email;
            },
            onSelected: (value) {
              controller.selectedEmail(value);
            },
          );
        }),
      );
    });
  }
}

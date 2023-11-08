import 'package:dailyremember/components/app_button.dart';
import 'package:dailyremember/infrastructure/dal/repository/transcribe_repository_impl.dart';
import 'package:dailyremember/infrastructure/navigation/routes.dart';
import 'package:dailyremember/infrastructure/theme/typography.dart';
import 'package:dailyremember/presentation/speaking/controllers/speaking.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

class TranscribeAudioWidget extends StatelessWidget {
  const TranscribeAudioWidget({super.key, required this.transcribe});
  final String transcribe;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SpeakingController>(
        init: SpeakingController(TranscribeRepositoryImpl()),
        builder: (controller) {
          return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.r),
                    topRight: Radius.circular(10.r))),
            child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: Get.height * 0.9,
                  minHeight: Get.height * 0.1,
                ),
                child: Material(
                    color: Colors.transparent,
                    child: Stack(
                      children: [
                        SizedBox(
                            child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: 60.w),
                              Padding(
                                padding: EdgeInsets.all(16.r),
                                child: Text(
                                  transcribe,
                                  style: titleNormal,
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(height: 100.w),
                            ],
                          ),
                        )),
                        Positioned(
                            top: 0,
                            right: 0,
                            left: 0,
                            child: Column(children: [
                              Container(
                                color: Colors.white,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.r, vertical: 12.r),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Transcribe Audio',
                                          style: titleBold),
                                      GestureDetector(
                                          onTap: () => Get.back(),
                                          child: const Icon(
                                              IconlyLight.close_square))
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                color: Colors.grey.shade300,
                                height: 0,
                                thickness: 1,
                              ),
                              SizedBox(height: 16.w),
                            ])),
                        Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: SizedBox(
                                width: Get.width,
                                child: Container(
                                  height: 72.h,
                                  padding: EdgeInsets.all(16.r),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          top: BorderSide(
                                              color: Colors.grey.shade300))),
                                  child: AppButton(
                                      text: "Check Spelling",
                                      // bgColor: Colors.grey.shade300,
                                      onPressed: () {
                                        Get.back();
                                        Get.toNamed(Routes.SPELLING_CHECK,
                                            arguments: transcribe);
                                      }),
                                ))),
                      ],
                    ))),
          );
        });
  }
}

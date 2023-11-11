import 'package:cached_network_image/cached_network_image.dart';
import 'package:dailyremember/infrastructure/theme/typography.dart';
import 'package:dailyremember/presentation/account/controllers/account.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key, required this.controller});
  final AccountController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: GetBuilder<AccountController>(builder: (control) {
        return Column(
          children: [
            SizedBox(
              height: 90.r,
              width: 90.r,
              child: CachedNetworkImage(
                key: UniqueKey(),
                cacheManager: controller.customCacheManager,
                imageUrl: controller.userProfile.avatar ?? '',
                height: 90.w,
                fit: BoxFit.cover,
                imageBuilder: (context, imageProvider) {
                  return CircleAvatar(
                      radius: 24.r, backgroundImage: imageProvider);
                },
                placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(color: Colors.blueAccent)),
                errorWidget: (context, url, error) {
                  return CircleAvatar(
                    radius: 24.r,
                    backgroundColor: Colors.grey.shade200,
                  );
                },
              ),
            ),
            SizedBox(height: 12.h),
            Text(controller.userProfile.name ?? '', style: titleBold),
            SizedBox(height: 4.h),
            Text(controller.userProfile.email ?? '', style: hintSubTitleNormal),
            SizedBox(height: 16.h),
            Divider(
              height: 0,
              color: Colors.grey.shade300,
            )
          ],
        );
      }),
    );
  }
}

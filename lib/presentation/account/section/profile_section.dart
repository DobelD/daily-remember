import 'package:avatar_glow/avatar_glow.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
      child: Container(
        height: 220.h,
        width: Get.width,
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: const Color(0xFF6680C5).withOpacity(0.2),
                  blurRadius: 14,
                  offset: Offset.zero)
            ]),
        child: GetBuilder<AccountController>(builder: (control) {
          return Column(
            children: [
              SizedBox(
                height: 60.r,
                width: 60.r,
                child: CachedNetworkImage(
                  key: UniqueKey(),
                  cacheManager: controller.customCacheManager,
                  imageUrl: controller.userProfile.avatar ?? '',
                  height: 60.w,
                  fit: BoxFit.cover,
                  imageBuilder: (context, imageProvider) {
                    return AvatarGlow(
                        glowRadiusFactor: 0.2,
                        duration: 2000.milliseconds,
                        glowColor: Colors.blueAccent,
                        child: CircleAvatar(
                            radius: 24.r, backgroundImage: imageProvider));
                  },
                  placeholder: (context, url) => const Center(
                      child:
                          CircularProgressIndicator(color: Colors.blueAccent)),
                  errorWidget: (context, url, error) {
                    return AvatarGlow(
                        glowRadiusFactor: 0.4,
                        duration: 2000.milliseconds,
                        glowColor: Colors.blueAccent,
                        child: CircleAvatar(
                          radius: 24.r,
                          backgroundColor: Colors.white,
                        ));
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

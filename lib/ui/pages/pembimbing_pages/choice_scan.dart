import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simor/shared/themes.dart';

import '../../widgets/dialog_absen_widget.dart';

class ChoiceScan extends StatelessWidget {
  const ChoiceScan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/backgorund.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fill,
          ),
          SafeArea(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    SizedBox(height: 16.h),
                    Image.asset(
                      "assets/images/logo.png",
                      height: 54.h,
                      width: 197.w,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(height: 56.h),
                    Text(
                      'MONITORING',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 46.sp,
                      ),
                      textScaleFactor: 1,
                    ),
                    Text(
                      'PRAKTEK PENGENALAN LAPANGAN',
                      style: whiteTextStyle.copyWith(
                        fontSize: 16.sp,
                        fontWeight: light,
                      ),
                      textScaleFactor: 1,
                    ),
                    SizedBox(height: 34.h),
                    ButtonChoice(
                      title: 'Datang',
                      bg: 'bg_scan_2.svg',
                      card: 'bg_presensi_in.svg',
                      tap: () => dialogAbsen(context, 'Datang'),
                    ),
                    SizedBox(height: 16.h),
                    ButtonChoice(
                      title: 'Pulang',
                      bg: 'bg_scan_2.svg',
                      card: 'bg_presensi_out.svg',
                      status: 'Pulang',
                      tap: () => dialogAbsen(context, 'Pulang'),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.arrow_back_outlined,
                        color: kWhiteColor,
                        size: 32.r,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonChoice extends StatelessWidget {
  const ButtonChoice({
    super.key,
    required this.title,
    required this.bg,
    required this.card,
    this.status = 'Datang',
    required this.tap,
  });

  final String title;
  final String bg, card;
  final String status;
  final Function() tap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        '/scan-pembimbing',
        arguments: {
          'bg': bg,
          'card': card,
          'status': status,
          'tap': tap,
          'height': 44.h,
          'typePage': false,
        },
      ),
      child: Container(
        height: 50.h,
        width: 170.w,
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Center(
          child: Text(
            title,
            style: blueTextStyle.copyWith(
              fontSize: 14.sp,
              fontWeight: semiBold,
            ),
            textScaleFactor: 1,
          ),
        ),
      ),
    );
  }
}

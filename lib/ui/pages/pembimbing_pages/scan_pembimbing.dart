import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:simor/cubit/pembimbing_cubit/pembimbing_cubit.dart';

import '../../../shared/themes.dart';

class ScanPembimbing extends StatefulWidget {
  const ScanPembimbing({super.key});

  @override
  State<ScanPembimbing> createState() => _ScanPembimbingState();
}

class _ScanPembimbingState extends State<ScanPembimbing> {
  @override
  void initState() {
    super.initState();
    _listenLnLinks();
  }

  @override
  void dispose() {
    super.dispose();
    _stopNFCSession();
  }

  _listenLnLinks() async {
    bool isAvailable = await NfcManager.instance.isAvailable();
    if (isAvailable && Platform.isAndroid) {
      _startNFCSession();
    }
  }

  _startNFCSession() async {
    await NfcManager.instance.stopSession();
    NfcManager.instance.startSession(
      onDiscovered: (NfcTag tag) async {
        var ndef = Ndef.from(tag);
        if (ndef != null) {
          for (var rec in ndef.cachedMessage!.records) {
            String payload = String.fromCharCodes(rec.payload);
            String nimMahasiswa = payload.substring(3);
            context.read<PembimbingCubit>().cekMahasiswa(nimMahasiswa);
          }
        }
      },
    );
  }

  void _stopNFCSession() {
    NfcManager.instance.stopSession();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> item =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: item['tap'],
        child: Stack(
          children: [
            SvgPicture.asset(
              "assets/images/${item['bg']}",
              height: 202.h,
              fit: BoxFit.fill,
            ),
            SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 16.h),
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/logo.png",
                      height: 54.h,
                      width: 197.w,
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(height: 36.h),
                  SvgPicture.asset(
                    'assets/images/${item['card']}',
                    width: 320.w,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(height: 45.h),
                  Text(
                    'Scan Kartu Anda!',
                    style: blackTextStyle.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 20.sp,
                    ),
                    textScaleFactor: 1,
                  ),
                  const Spacer(),
                  Image.asset(
                    "assets/images/vector_scan.png",
                    width: 120.r,
                    height: 120.r,
                    fit: BoxFit.fill,
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 60.h,
                      left: 16.w,
                      right: 16.w,
                    ),
                    child: Text(
                      'Silahkan Scan Kartu Anda Pada Perangkat Pembimbing Lapangan ',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 16.sp,
                      ),
                      textAlign: TextAlign.center,
                      textScaleFactor: 1,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

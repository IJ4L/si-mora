import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simor/cubit/camera_cubit.dart';
import 'package:simor/ui/pages/login_page.dart';
import 'package:simor/ui/pages/mahasiswa_pages/home_page.dart';
import 'package:simor/ui/pages/scan_card_page.dart';
import 'package:simor/ui/pages/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider(create: ((context) => CameraCubit())),
        ],
        child: MaterialApp(
          title: 'SiMonitoring',
          theme: ThemeData(fontFamily: 'Montserrat'),
          debugShowCheckedModeBanner: false,
          initialRoute: 'home-mahasiswa',
          routes: {
            '/': (context) => const Splashscreen(),
            'login': (context) => const Loginpage(),
            'scan-card': (context) => const Scancard(),
            'home-mahasiswa': (context) => const Homemahasiswa(),
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:h_r_m/Utils/resources/res/app_theme.dart';
import 'package:h_r_m/View/HomePAge/api.dart';
import 'package:h_r_m/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<HomeApiProvider>(
              create: (_) => HomeApiProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'HR Maverix',
          theme: ThemeData(
            primaryColor: const Color(0xffD74C23),
            hoverColor: const Color(0xffD74C23),
          ),
          home: const SplashScreen(),
        ),
      );
    });
  }
}

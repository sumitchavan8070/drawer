import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ielts/utilities/navigation/route_generator.dart';
import 'package:ielts/utilities/packages/smooth_rectangular_border.dart';
import 'package:ielts/utilities/theme/app_colors.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool isDebugMode = false;

  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      setState(() {
        isDebugMode = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: isDebugMode,
      title: 'Ielts Grad',
      routerConfig: goRouterConfig,
      theme: ThemeData(
        progressIndicatorTheme: const ProgressIndicatorThemeData(
            circularTrackColor: AppColors.primaryColor, color: Colors.white),
        scaffoldBackgroundColor: AppColors.backgroundColor,
        useMaterial3: true,
        primaryColor: AppColors.primaryColor,
        fontFamily: 'Quicksand',
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderRadius: SmoothBorderRadius(cornerRadius: 10),
            borderSide: BorderSide.none,
          ),
          border: OutlineInputBorder(
            borderRadius: SmoothBorderRadius(cornerRadius: 10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: SmoothBorderRadius(cornerRadius: 10),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: AppColors.alabaster,
          hintStyle: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: AppColors.paleSky),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primaryColor,
            textStyle: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(letterSpacing: 0.15, color: AppColors.primaryColor),
            shape: SmoothRectangleBorder(
              borderRadius: SmoothBorderRadius(cornerRadius: 10),
            ),
            side: const BorderSide(color: AppColors.primaryColor),
          ),
        ),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: SmoothRectangleBorder(
              borderRadius: SmoothBorderRadius(cornerRadius: 10),
            ),
            foregroundColor: Colors.white,
            textStyle: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(letterSpacing: 0.15),
            backgroundColor: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}

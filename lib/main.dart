import 'package:flutter/material.dart';
import 'package:quotes/config/routes/app_router.dart';
import 'package:quotes/config/themes/app_theme.dart';
import 'package:quotes/core/utils/app_strings.dart';

void main() {
  runApp(const QutesApp());
}

class QutesApp extends StatelessWidget {
  const QutesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:quotes/config/routes/app_router.dart';
import 'package:quotes/config/routes/app_routes.dart';
import 'package:quotes/config/themes/app_theme.dart';
import 'package:quotes/core/utils/app_strings.dart';
import 'package:quotes/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServiceLocator();
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
      initialRoute: AppRoutes.initialPageRoute,
    );
  }
}

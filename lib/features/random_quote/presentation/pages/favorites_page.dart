import 'package:flutter/material.dart';
import 'package:quotes/core/utils/app_strings.dart';

class FavoraitesPage extends StatelessWidget {
  const FavoraitesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text(AppStrings.favorites),
      ),
    );
  }
}

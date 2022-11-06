import 'package:flutter/material.dart';
import 'package:quotes/core/utils/app_colors.dart';
import 'package:quotes/core/utils/app_strings.dart';
import 'package:quotes/core/utils/media_query_values.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget(
      {super.key, required this.errorMessage, required this.onRefresh});

  final String errorMessage;
  final VoidCallback onRefresh;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: AppColors.primary,
            size: 150,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              errorMessage,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Text(
            AppStrings.tryAgain,
            style: TextStyle(
                color: AppColors.hint,
                fontSize: 18,
                fontWeight: FontWeight.w500),
          ),
          Container(
            height: 55,
            width: context.width * 0.55,
            margin: const EdgeInsets.symmetric(vertical: 15),
            child: ElevatedButton(
              onPressed: onRefresh,
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Theme.of(context).primaryColor,
                  elevation: 500,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50))),
              child: const Text(
                AppStrings.reloadScreen,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
            ),
          )
        ],
      ),
    );
  }
}

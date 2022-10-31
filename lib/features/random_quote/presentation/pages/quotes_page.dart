import 'package:flutter/material.dart';
import 'package:quotes/core/utils/app_colors.dart';
import 'package:quotes/core/utils/app_strings.dart';
import 'package:quotes/features/random_quote/presentation/widgets/quote_content.dart';

class QuotesPage extends StatelessWidget {
  const QuotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
      ),
      body: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const QuoteContent(
            quote:
                ',jhgaskjhdlfiauhyaweklsjdhlkvuhgjhgaskjhdlfiauhyaweklsjdhlkvuhgjhgaskjhdlfiauhyaweklsjdhlkvuhgjhgaskjhdlfiauhyaweklsjdhlkvuhg',
            author: 'Taha Elkholy,',
          ),
          const SizedBox(height: 30),
          InkWell(
            onTap: () {},
            child: SizedBox(
              width: 48,
              height: 48,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                ),
                child: const Icon(
                  Icons.refresh,
                  size: 28,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

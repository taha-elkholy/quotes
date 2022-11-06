import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quotes/core/utils/app_colors.dart';
import 'package:quotes/core/utils/app_strings.dart';
import 'package:quotes/core/widgets/app_error_widget.dart';
import 'package:quotes/features/random_quote/presentation/cubit/cubit/quote_cubit.dart';
import 'package:quotes/features/random_quote/presentation/widgets/quote_content.dart';
import 'package:quotes/injection_container.dart';

class QuotesPage extends StatelessWidget {
  const QuotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<QuoteCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.appName),
        ),
        body: const _Body(),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body();

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  void _getRandomQuote(context) =>
      BlocProvider.of<QuoteCubit>(context).getRandomQuote();

  @override
  void initState() {
    super.initState();
    _getRandomQuote(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: BlocBuilder<QuoteCubit, QuoteState>(
        builder: (context, state) {
          
          if (state is QuoteError) {
            return AppErrorWidget(
              errorMessage: state.errorMessage,
              onRefresh: () => _getRandomQuote(context),
            );
          } else if (state is QuoteLoaded) {
           return  Column(
              children: [
                QuoteContent(
                  quote: state.quote.content,
                  author: state.quote.author,
                ),
                const SizedBox(height: 30),
                InkWell(
                  onTap: () => _getRandomQuote(context),
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
            );
          } else {
            return SpinKitFadingCircle(
              color: AppColors.primary,
            );
          }
          
        },
      ),
    );
  }
}

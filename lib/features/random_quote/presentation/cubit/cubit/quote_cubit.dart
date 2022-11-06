import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quotes/core/error/failure.dart';
import 'package:quotes/core/usecase/usecase.dart';
import 'package:quotes/core/utils/app_strings.dart';
import 'package:quotes/features/random_quote/domain/entities/quote.dart';
import 'package:quotes/features/random_quote/domain/usecases/get_random_quote.dart';

part 'quote_state.dart';

class QuoteCubit extends Cubit<QuoteState> {
  QuoteCubit(this._getRandomQuote) : super(QuoteInitial());

  final GetRandomQuote _getRandomQuote;

  Future<void> getRandomQuote() async {
    emit(QuoteLoading());
    final result = await _getRandomQuote(NoParam());
    emit(
      result.fold(
        (failure) => QuoteError(errorMessage: _mapFailureToMessage(failure)),
        (quote) => QuoteLoaded(quote: quote),
      ),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return failure.message ?? AppStrings.serverFailure;
      case CacheFailure:
        return AppStrings.cacheFailure;
      default:
        return AppStrings.unexpectedFailure;
    }
  }
}

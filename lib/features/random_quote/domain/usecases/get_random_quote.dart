import 'package:quotes/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:quotes/core/usecase/usecase.dart';
import 'package:quotes/features/random_quote/domain/entities/quote.dart';
import 'package:quotes/features/random_quote/domain/repositories/quote_repository.dart';

class GetRandomQuote implements UseCase<Quote, NoParam> {
  final QuoteRepository _quoteRepository;

  GetRandomQuote(this._quoteRepository);

  @override
  Future<Either<Failure, Quote>> call(NoParam param) =>
      _quoteRepository.getRandomQuote();
}

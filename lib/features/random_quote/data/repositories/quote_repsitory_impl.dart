import 'package:quotes/core/error/exceptions.dart';
import 'package:quotes/core/network/network_info.dart';
import 'package:quotes/features/random_quote/data/datasources/local/ranom_quote_local_data_source.dart';
import 'package:quotes/features/random_quote/data/datasources/remote/ranom_quote_remote_data_source.dart';
import 'package:quotes/features/random_quote/domain/entities/quote.dart';
import 'package:quotes/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:quotes/features/random_quote/domain/repositories/quote_repository.dart';

class QuoteRepositoryImpl implements QuoteRepository {
  final NetworkInfo _networkInfo;
  final RandomQuoteRemoteDatasource _remoteDatasource;
  final RandomQuoteLocalDatasource _localDatasource;

  QuoteRepositoryImpl(
      this._networkInfo, this._remoteDatasource, this._localDatasource);
  @override
  Future<Either<Failure, Quote>> getRandomQuote() async {
    if (await _networkInfo.isConnected) {
      // get from remote
      try {
        final response = await _remoteDatasource.getRandomQuote();
        // cach data
        await _localDatasource.cachRandomQuote(response);
        return right(response);
      } on ServerException catch (_) {
        return left(ServerFailure());
      }
    } else {
      //get from cach
      try {
        final cachedQuote = await _localDatasource.getLastRandomQuote();
        return right(cachedQuote);
      } on CacheException catch (_) {
        return left(CacheFailure());
      }
    }
  }
}

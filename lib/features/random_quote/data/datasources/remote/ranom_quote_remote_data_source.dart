import 'package:quotes/core/api/api_service.dart';
import 'package:quotes/core/api/end_points.dart';
import 'package:quotes/features/random_quote/data/models/quote_model.dart';

abstract class RandomQuoteRemoteDatasource {
  Future<QuoteModel> getRandomQuote();
}

class RandomQuoteRemoteDatasourceImpl implements RandomQuoteRemoteDatasource {
  final ApiService _apiService;

  RandomQuoteRemoteDatasourceImpl(this._apiService);

  @override
  Future<QuoteModel> getRandomQuote() async {
    final response = await _apiService.get(EndPoints.randomQuote);

    return QuoteModel.fromJson(response);
  }
}

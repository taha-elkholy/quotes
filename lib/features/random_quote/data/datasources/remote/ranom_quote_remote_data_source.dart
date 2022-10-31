import 'dart:convert';

import 'package:quotes/core/api/end_points.dart';
import 'package:quotes/core/error/exceptions.dart';
import 'package:quotes/core/utils/app_strings.dart';
import 'package:quotes/features/random_quote/data/models/quote_model.dart';
import 'package:http/http.dart' as http;

abstract class RandomQuoteRemoteDatasource {
  Future<QuoteModel> getRandomQuote();
}

class RandomQuoteRemoteDatasourceImpl implements RandomQuoteRemoteDatasource {
  final http.Client _client;

  RandomQuoteRemoteDatasourceImpl(this._client);

  @override
  Future<QuoteModel> getRandomQuote() async {
    final response = await _client.get(
      Uri.parse(EndPoints.randomQuote),
      headers: {AppStrings.contentType: AppStrings.applicationJson},
    );
    if (response.statusCode == 200) {
      return QuoteModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}

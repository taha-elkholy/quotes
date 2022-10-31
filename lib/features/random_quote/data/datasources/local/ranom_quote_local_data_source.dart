import 'dart:convert';

import 'package:quotes/core/error/exceptions.dart';
import 'package:quotes/core/utils/app_strings.dart';
import 'package:quotes/features/random_quote/data/models/quote_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class RandomQuoteLocalDatasource {
  Future<QuoteModel> getLastRandomQuote();
  Future<void> cachRandomQuote(QuoteModel quote);
}

class RandomQuoteLocalDatasourceImpl implements RandomQuoteLocalDatasource {
  final SharedPreferences _sharedPreferences;

  RandomQuoteLocalDatasourceImpl(this._sharedPreferences);

  @override
  Future<QuoteModel> getLastRandomQuote() async {
    final stringJson =
        _sharedPreferences.getString(AppStrings.cachedRandomQute);
    if (stringJson != null) {
      final cachedRandomQuote = QuoteModel.fromJson(json.decode(stringJson));
      return cachedRandomQuote;
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cachRandomQuote(QuoteModel quote) async {
    await _sharedPreferences.setString(
        AppStrings.cachedRandomQute, json.encode(quote));
  }
}

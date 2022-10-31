import 'package:quotes/features/random_quote/domain/entities/quote.dart';

class QuoteModel extends Quote {
  const QuoteModel(
      {required super.id,
      required super.author,
      required super.content,
      required super.permalink});

  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
      id: json['id'],
      author: json['author'],
      content: json['quote'],
      permalink: json['permalink'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'author': author,
      'quote': content,
      'permalink': permalink
    };
  }
}

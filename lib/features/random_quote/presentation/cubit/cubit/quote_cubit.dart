import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'quote_state.dart';

class QuoteCubit extends Cubit<QuoteState> {
  QuoteCubit() : super(QuoteInitial());
}

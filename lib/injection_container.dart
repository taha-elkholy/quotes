import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:quotes/core/api/api_service.dart';
import 'package:quotes/core/api/app_interceptors.dart';
import 'package:quotes/core/api/dio_consumer.dart';

import 'package:quotes/core/network/network_info.dart';
import 'package:quotes/features/random_quote/data/datasources/local/ranom_quote_local_data_source.dart';
import 'package:quotes/features/random_quote/data/datasources/remote/ranom_quote_remote_data_source.dart';
import 'package:quotes/features/random_quote/data/repositories/quote_repsitory_impl.dart';
import 'package:quotes/features/random_quote/domain/repositories/quote_repository.dart';
import 'package:quotes/features/random_quote/domain/usecases/get_random_quote.dart';
import 'package:quotes/features/random_quote/presentation/cubit/cubit/quote_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt sl = GetIt.instance;

Future<void> initServiceLocator() async {
  //! Features

  // Blocs
  sl.registerFactory<QuoteCubit>(() => QuoteCubit(sl()));

  // Use cases
  sl.registerLazySingleton<GetRandomQuote>(() => GetRandomQuote(sl()));

  // Repository
  sl.registerLazySingleton<QuoteRepository>(
    () => QuoteRepositoryImpl(
      sl(),
      sl(),
      sl(),
    ),
  );

  // Data Sources
  sl.registerLazySingleton<RandomQuoteLocalDatasource>(
      () => RandomQuoteLocalDatasourceImpl(sl()));
  sl.registerLazySingleton<RandomQuoteRemoteDatasource>(
      () => RandomQuoteRemoteDatasourceImpl(sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<ApiService>(() => DioConsumer(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => AppInterceptors());
  sl.registerLazySingleton(() => LogInterceptor(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
        error: true,
      ));
  sl.registerLazySingleton(() => Dio());

}

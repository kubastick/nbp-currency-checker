import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';
import 'package:nbp_currency_checker/data/currency/data_sources/nbp_data_source.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  ChopperClient get chopperClient => ChopperClient(
        converter: const JsonConverter(),
        interceptors: [
          HttpLoggingInterceptor(),
        ],
      );

  @lazySingleton
  NBPDataSource nbpDataSource(ChopperClient client) => NBPDataSource.create(client);
}

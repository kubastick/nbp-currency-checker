import 'package:chopper/chopper.dart';
import 'package:intl/intl.dart';

part 'nbp_data_source.chopper.dart';

@ChopperApi(baseUrl: 'https://api.nbp.pl/api/exchangerates/')
abstract class NBPDataSource extends ChopperService {
  static NBPDataSource create([ChopperClient? client]) => _$NBPDataSource(client);

  static final dateFormatter = DateFormat('y-MM-dd');

  @Get(path: 'rates/A/{currencyCode}/{ymdDate}/')
  Future<Response<Map<String, dynamic>>> getExchangeRates(@Path() String currencyCode, @Path() String ymdDate);
}

import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_notes_application/src/home/api/datasource/home_datasource.dart';

@module
abstract class ProviderApiModule {
  HomeDatasource provideHomeDataSource(ChopperClient client) =>
      client.getService<HomeDatasource>();
}

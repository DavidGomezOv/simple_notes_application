import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:simple_notes_application/src/home/api/datasource/home_local_source.dart';

@injectable
class HomeRepository {
  final HomeLocalSource _localDatasourceSource;

  @factoryMethod
  HomeRepository.from(this._localDatasourceSource);

  Future<dynamic> getLocalNotes() {
    return _localDatasourceSource.getLocalNotes();
  }
}

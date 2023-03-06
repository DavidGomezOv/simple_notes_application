import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_notes_application/src/home/api/datasource/home_firestore_source.dart';
import 'package:simple_notes_application/src/home/api/datasource/home_local_source.dart';

@injectable
class HomeRepository {
  final HomeFirestoreSource _datasourceNotes;
  final HomeLocalSource _localDatasourceSource;

  @factoryMethod
  HomeRepository.from(this._datasourceNotes, this._localDatasourceSource);

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getNotes() {
    return _datasourceNotes.getNotes();
  }

  Future<dynamic> getLocalNotes() {
    return _localDatasourceSource.getLocalNotes();
  }
}

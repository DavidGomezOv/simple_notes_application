import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_notes_application/src/home/api/datasource/home_firestore_source.dart';

@injectable
class HomeRepository {
  final HomeFirestoreSource _datasourceNotes;

  @factoryMethod
  HomeRepository.from(this._datasourceNotes);

  Stream<QuerySnapshot<Map<String, dynamic>>> getNotes() {
    return _datasourceNotes.getNotes();
  }
}

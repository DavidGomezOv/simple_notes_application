import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_notes_application/src/core/base/base_datasource.dart';
import 'package:simple_notes_application/src/core/constants/constants.dart';

@lazySingleton
class HomeFirestoreSource extends BaseDatasource {
  @factoryMethod
  HomeFirestoreSource.from();

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getNotes() async {
    await validateConnection();
    final db = FirebaseFirestore.instance;
    return db.collection(Constants.notesCollection).snapshots();
  }
}

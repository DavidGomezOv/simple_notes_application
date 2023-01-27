import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_notes_application/src/core/constants/constants.dart';

@lazySingleton
class HomeFirestoreSource {
  @factoryMethod
  HomeFirestoreSource.from();

  Stream<dynamic> getNotes() {
    final db = FirebaseFirestore.instance;
    return db.collection(Constants.notesCollection).snapshots();
  }
}

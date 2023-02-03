import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_notes_application/src/core/constants/constants.dart';

@lazySingleton
class HomeFirestoreSource {
  @factoryMethod
  HomeFirestoreSource.from();

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getNotes() async {
    await validateConnection();
    final db = FirebaseFirestore.instance;
    return db.collection(Constants.notesCollection).snapshots();
  }

  Future<bool> validateConnection() async {
    final connectivity = await Connectivity().checkConnectivity();
    if (connectivity == ConnectivityResult.none) {
      throw ('The device is not connected to Internet');
    }
    return connectivity != ConnectivityResult.none;
  }
}

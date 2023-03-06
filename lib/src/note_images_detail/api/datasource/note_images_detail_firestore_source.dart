import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_notes_application/src/core/base/base_datasource.dart';
import 'package:simple_notes_application/src/core/constants/constants.dart';

@lazySingleton
class NoteImagesDetailFirestoreSource extends BaseDatasource {
  @factoryMethod
  NoteImagesDetailFirestoreSource.from();

  Future<Uint8List> downloadImage(String noteModelId, String imageName) async {
    await validateConnection();
    final storage =
        FirebaseStorage.instance.ref('${Constants.imagesFolder}/$noteModelId');
    final islandRef = storage.child(imageName);
    try {
      final Uint8List? data = await islandRef
          .getData(8485760)
          .catchError((error) => throw (error.toString()));
      if (data != null) {
        return data;
      }
      throw ('An error has occurred downloading the image');
    } catch (exception) {
      throw (exception.toString());
    }
  }
}

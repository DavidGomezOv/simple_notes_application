import 'package:injectable/injectable.dart';
import 'package:simple_notes_application/src/core/base/base_reactive_service.dart';

@lazySingleton
class NoteImagesDetailService extends BaseReactiveService {
  @factoryMethod
  NoteImagesDetailService.from() {
    listenToReactiveValues([
      loadingReactiveValue,
    ]);
  }
}

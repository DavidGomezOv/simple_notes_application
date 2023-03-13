import 'package:flutter/cupertino.dart';
import 'package:simple_notes_application/src/home/ui/screen/home_screen.dart';
import 'package:simple_notes_application/src/note_detail/ui/screen/note_detail_screen.dart';
import 'package:simple_notes_application/src/note_images_detail/ui/screen/note_images_detail_screen.dart';

class Routes {
  static const String home = '/home';
  static const String noteDetail = '/note_detail';
  static const String imagesDetail = '/images_detail';

  static final routes = <String, WidgetBuilder>{
    home: (context) => const HomeScreen(),
    noteDetail: (context) => const NoteDetailScreen(),
    imagesDetail: (context) => const NoteImagesDetailScreen(),
  };
}

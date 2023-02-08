import 'package:flutter/cupertino.dart';
import 'package:simple_notes_application/src/auth/ui/screen/auth_screen.dart';
import 'package:simple_notes_application/src/home/ui/screen/home_screen.dart';
import 'package:simple_notes_application/src/note_detail/ui/screen/note_detail_screen.dart';
import 'package:simple_notes_application/src/sign_out/ui/screen/sign_out_screen.dart';

class Routes {
  static const String home = '/home';
  static const String noteDetail = '/note_detail';
  static const String auth = '/auth';
  static const String signOut = '/sign_out';

  static final routes = <String, WidgetBuilder>{
    home: (context) => const HomeScreen(),
    noteDetail: (context) => const NoteDetailScreen(),
    auth: (context) => const AuthScreen(),
    signOut: (context) => const SignOutScreen(),
  };
}

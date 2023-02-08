import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_notes_application/src/auth/model/login_model_request.dart';
import 'package:simple_notes_application/src/auth/model/register_model_request.dart';
import 'package:simple_notes_application/src/core/base/base_datasource.dart';

@lazySingleton
class AuthFirestoreSource extends BaseDatasource {
  @factoryMethod
  AuthFirestoreSource.from();

  Future<String?> doLogin(LoginModelRequest loginModelRequest) async {
    await validateConnection();
    final userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: loginModelRequest.email!,
            password: loginModelRequest.password!);
    return userCredential.user?.uid;
  }

  Future<String?> register(RegisterModelRequest registerModelRequest) async {
    await validateConnection();
    final userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
        email: registerModelRequest.email!,
        password: registerModelRequest.password!);
    await userCredential.user?.updateDisplayName(registerModelRequest.name);
    return userCredential.user?.uid;
  }
}

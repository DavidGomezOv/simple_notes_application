import 'package:injectable/injectable.dart';
import 'package:simple_notes_application/src/auth/api/datasource/auth_firestore_source.dart';
import 'package:simple_notes_application/src/auth/model/login_model_request.dart';
import 'package:simple_notes_application/src/auth/model/register_model_request.dart';

@injectable
class AuthRepository {
  final AuthFirestoreSource _datasource;

  @factoryMethod
  AuthRepository.from(this._datasource);

  Future<String?> doLogin(LoginModelRequest loginModelRequest) {
    return _datasource.doLogin(loginModelRequest);
  }

  Future<String?> register(RegisterModelRequest registerModelRequest) {
    return _datasource.register(registerModelRequest);
  }

}

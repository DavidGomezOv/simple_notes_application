import 'package:json_annotation/json_annotation.dart';

part 'login_model_request.g.dart';

@JsonSerializable(explicitToJson: true)
class LoginModelRequest {
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'password')
  String? password;

  LoginModelRequest(this.email, this.password);

  LoginModelRequest.init();

  factory LoginModelRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginModelRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginModelRequestToJson(this);

  @override
  String toString() {
    return 'LoginModelRequest{email: $email, password: $password}';
  }
}

import 'package:json_annotation/json_annotation.dart';

part 'register_model_request.g.dart';

@JsonSerializable(explicitToJson: true)
class RegisterModelRequest {
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'password')
  String? password;

  RegisterModelRequest.init();

  RegisterModelRequest(this.name, this.email, this.password);

  factory RegisterModelRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterModelRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterModelRequestToJson(this);
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'clinic_details_response.freezed.dart';
part 'clinic_details_response.g.dart';

@freezed
class ClinicDetailsResponse with _$ClinicDetailsResponse {
  const factory ClinicDetailsResponse({
    required Output output,
  }) = _ClinicDetailsResponse;

  factory ClinicDetailsResponse.fromJson(Map<String, Object?> json) =>
      _$ClinicDetailsResponseFromJson(json);
}

@freezed
class Output with _$Output {
  const factory Output({
    required Body body,
    required List<Message> messages,
    required String result,
  }) = _Output;

  factory Output.fromJson(Map<String, Object?> json) => _$OutputFromJson(json);
}

@freezed
class Body with _$Body {
  const factory Body({
    required String clinicID,
    required String colorAccent,
    required String colorBackgroud,
    required String colorPrimary,
    required String description,
    required String logo,
    required String name,
    required String status,
  }) = _Body;

  factory Body.fromJson(Map<String, dynamic> json) => _$BodyFromJson(json);
}

@freezed
class Message with _$Message {
  const factory Message({
    required String code,
    required String message,
    required String severity,
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
}

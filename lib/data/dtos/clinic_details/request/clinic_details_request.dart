import 'package:freezed_annotation/freezed_annotation.dart';

part 'clinic_details_request.freezed.dart';
part 'clinic_details_request.g.dart';

@freezed
class ClinicDetailsRequest with _$ClinicDetailsRequest {
  const factory ClinicDetailsRequest({
    required String clinicID,
    required String institute,
  }) = _ClinicDetailsRequest;

  factory ClinicDetailsRequest.fromJson(Map<String, Object?> json) =>
      _$ClinicDetailsRequestFromJson(json);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clinic_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ClinicDetailsResponse _$$_ClinicDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    _$_ClinicDetailsResponse(
      output: Output.fromJson(json['output'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_ClinicDetailsResponseToJson(
        _$_ClinicDetailsResponse instance) =>
    <String, dynamic>{
      'output': instance.output,
    };

_$_Output _$$_OutputFromJson(Map<String, dynamic> json) => _$_Output(
      body: Body.fromJson(json['body'] as Map<String, dynamic>),
      messages: (json['messages'] as List<dynamic>)
          .map((e) => Message.fromJson(e as Map<String, dynamic>))
          .toList(),
      result: json['result'] as String,
    );

Map<String, dynamic> _$$_OutputToJson(_$_Output instance) => <String, dynamic>{
      'body': instance.body,
      'messages': instance.messages,
      'result': instance.result,
    };

_$_Body _$$_BodyFromJson(Map<String, dynamic> json) => _$_Body(
      clinicID: json['clinicID'] as String,
      colorAccent: json['colorAccent'] as String,
      colorBackgroud: json['colorBackgroud'] as String,
      colorPrimary: json['colorPrimary'] as String,
      description: json['description'] as String,
      logo: json['logo'] as String,
      name: json['name'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$$_BodyToJson(_$_Body instance) => <String, dynamic>{
      'clinicID': instance.clinicID,
      'colorAccent': instance.colorAccent,
      'colorBackgroud': instance.colorBackgroud,
      'colorPrimary': instance.colorPrimary,
      'description': instance.description,
      'logo': instance.logo,
      'name': instance.name,
      'status': instance.status,
    };

_$_Message _$$_MessageFromJson(Map<String, dynamic> json) => _$_Message(
      code: json['code'] as String,
      message: json['message'] as String,
      severity: json['severity'] as String,
    );

Map<String, dynamic> _$$_MessageToJson(_$_Message instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'severity': instance.severity,
    };

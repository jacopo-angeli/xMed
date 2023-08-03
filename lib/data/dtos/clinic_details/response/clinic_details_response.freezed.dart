// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'clinic_details_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ClinicDetailsResponse _$ClinicDetailsResponseFromJson(
    Map<String, dynamic> json) {
  return _ClinicDetailsResponse.fromJson(json);
}

/// @nodoc
mixin _$ClinicDetailsResponse {
  Output get output => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClinicDetailsResponseCopyWith<ClinicDetailsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClinicDetailsResponseCopyWith<$Res> {
  factory $ClinicDetailsResponseCopyWith(ClinicDetailsResponse value,
          $Res Function(ClinicDetailsResponse) then) =
      _$ClinicDetailsResponseCopyWithImpl<$Res, ClinicDetailsResponse>;
  @useResult
  $Res call({Output output});

  $OutputCopyWith<$Res> get output;
}

/// @nodoc
class _$ClinicDetailsResponseCopyWithImpl<$Res,
        $Val extends ClinicDetailsResponse>
    implements $ClinicDetailsResponseCopyWith<$Res> {
  _$ClinicDetailsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? output = null,
  }) {
    return _then(_value.copyWith(
      output: null == output
          ? _value.output
          : output // ignore: cast_nullable_to_non_nullable
              as Output,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $OutputCopyWith<$Res> get output {
    return $OutputCopyWith<$Res>(_value.output, (value) {
      return _then(_value.copyWith(output: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ClinicDetailsResponseCopyWith<$Res>
    implements $ClinicDetailsResponseCopyWith<$Res> {
  factory _$$_ClinicDetailsResponseCopyWith(_$_ClinicDetailsResponse value,
          $Res Function(_$_ClinicDetailsResponse) then) =
      __$$_ClinicDetailsResponseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Output output});

  @override
  $OutputCopyWith<$Res> get output;
}

/// @nodoc
class __$$_ClinicDetailsResponseCopyWithImpl<$Res>
    extends _$ClinicDetailsResponseCopyWithImpl<$Res, _$_ClinicDetailsResponse>
    implements _$$_ClinicDetailsResponseCopyWith<$Res> {
  __$$_ClinicDetailsResponseCopyWithImpl(_$_ClinicDetailsResponse _value,
      $Res Function(_$_ClinicDetailsResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? output = null,
  }) {
    return _then(_$_ClinicDetailsResponse(
      output: null == output
          ? _value.output
          : output // ignore: cast_nullable_to_non_nullable
              as Output,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ClinicDetailsResponse implements _ClinicDetailsResponse {
  const _$_ClinicDetailsResponse({required this.output});

  factory _$_ClinicDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$$_ClinicDetailsResponseFromJson(json);

  @override
  final Output output;

  @override
  String toString() {
    return 'ClinicDetailsResponse(output: $output)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ClinicDetailsResponse &&
            (identical(other.output, output) || other.output == output));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, output);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ClinicDetailsResponseCopyWith<_$_ClinicDetailsResponse> get copyWith =>
      __$$_ClinicDetailsResponseCopyWithImpl<_$_ClinicDetailsResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ClinicDetailsResponseToJson(
      this,
    );
  }
}

abstract class _ClinicDetailsResponse implements ClinicDetailsResponse {
  const factory _ClinicDetailsResponse({required final Output output}) =
      _$_ClinicDetailsResponse;

  factory _ClinicDetailsResponse.fromJson(Map<String, dynamic> json) =
      _$_ClinicDetailsResponse.fromJson;

  @override
  Output get output;
  @override
  @JsonKey(ignore: true)
  _$$_ClinicDetailsResponseCopyWith<_$_ClinicDetailsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

Output _$OutputFromJson(Map<String, dynamic> json) {
  return _Output.fromJson(json);
}

/// @nodoc
mixin _$Output {
  Body get body => throw _privateConstructorUsedError;
  List<Message> get messages => throw _privateConstructorUsedError;
  String get result => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OutputCopyWith<Output> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OutputCopyWith<$Res> {
  factory $OutputCopyWith(Output value, $Res Function(Output) then) =
      _$OutputCopyWithImpl<$Res, Output>;
  @useResult
  $Res call({Body body, List<Message> messages, String result});

  $BodyCopyWith<$Res> get body;
}

/// @nodoc
class _$OutputCopyWithImpl<$Res, $Val extends Output>
    implements $OutputCopyWith<$Res> {
  _$OutputCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? body = null,
    Object? messages = null,
    Object? result = null,
  }) {
    return _then(_value.copyWith(
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as Body,
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<Message>,
      result: null == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $BodyCopyWith<$Res> get body {
    return $BodyCopyWith<$Res>(_value.body, (value) {
      return _then(_value.copyWith(body: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_OutputCopyWith<$Res> implements $OutputCopyWith<$Res> {
  factory _$$_OutputCopyWith(_$_Output value, $Res Function(_$_Output) then) =
      __$$_OutputCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Body body, List<Message> messages, String result});

  @override
  $BodyCopyWith<$Res> get body;
}

/// @nodoc
class __$$_OutputCopyWithImpl<$Res>
    extends _$OutputCopyWithImpl<$Res, _$_Output>
    implements _$$_OutputCopyWith<$Res> {
  __$$_OutputCopyWithImpl(_$_Output _value, $Res Function(_$_Output) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? body = null,
    Object? messages = null,
    Object? result = null,
  }) {
    return _then(_$_Output(
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as Body,
      messages: null == messages
          ? _value._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<Message>,
      result: null == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Output implements _Output {
  const _$_Output(
      {required this.body,
      required final List<Message> messages,
      required this.result})
      : _messages = messages;

  factory _$_Output.fromJson(Map<String, dynamic> json) =>
      _$$_OutputFromJson(json);

  @override
  final Body body;
  final List<Message> _messages;
  @override
  List<Message> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  final String result;

  @override
  String toString() {
    return 'Output(body: $body, messages: $messages, result: $result)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Output &&
            (identical(other.body, body) || other.body == body) &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            (identical(other.result, result) || other.result == result));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, body,
      const DeepCollectionEquality().hash(_messages), result);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OutputCopyWith<_$_Output> get copyWith =>
      __$$_OutputCopyWithImpl<_$_Output>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OutputToJson(
      this,
    );
  }
}

abstract class _Output implements Output {
  const factory _Output(
      {required final Body body,
      required final List<Message> messages,
      required final String result}) = _$_Output;

  factory _Output.fromJson(Map<String, dynamic> json) = _$_Output.fromJson;

  @override
  Body get body;
  @override
  List<Message> get messages;
  @override
  String get result;
  @override
  @JsonKey(ignore: true)
  _$$_OutputCopyWith<_$_Output> get copyWith =>
      throw _privateConstructorUsedError;
}

Body _$BodyFromJson(Map<String, dynamic> json) {
  return _Body.fromJson(json);
}

/// @nodoc
mixin _$Body {
  String get clinicID => throw _privateConstructorUsedError;
  String get colorAccent => throw _privateConstructorUsedError;
  String get colorBackgroud => throw _privateConstructorUsedError;
  String get colorPrimary => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get logo => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BodyCopyWith<Body> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BodyCopyWith<$Res> {
  factory $BodyCopyWith(Body value, $Res Function(Body) then) =
      _$BodyCopyWithImpl<$Res, Body>;
  @useResult
  $Res call(
      {String clinicID,
      String colorAccent,
      String colorBackgroud,
      String colorPrimary,
      String description,
      String logo,
      String name,
      String status});
}

/// @nodoc
class _$BodyCopyWithImpl<$Res, $Val extends Body>
    implements $BodyCopyWith<$Res> {
  _$BodyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clinicID = null,
    Object? colorAccent = null,
    Object? colorBackgroud = null,
    Object? colorPrimary = null,
    Object? description = null,
    Object? logo = null,
    Object? name = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      clinicID: null == clinicID
          ? _value.clinicID
          : clinicID // ignore: cast_nullable_to_non_nullable
              as String,
      colorAccent: null == colorAccent
          ? _value.colorAccent
          : colorAccent // ignore: cast_nullable_to_non_nullable
              as String,
      colorBackgroud: null == colorBackgroud
          ? _value.colorBackgroud
          : colorBackgroud // ignore: cast_nullable_to_non_nullable
              as String,
      colorPrimary: null == colorPrimary
          ? _value.colorPrimary
          : colorPrimary // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      logo: null == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_BodyCopyWith<$Res> implements $BodyCopyWith<$Res> {
  factory _$$_BodyCopyWith(_$_Body value, $Res Function(_$_Body) then) =
      __$$_BodyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String clinicID,
      String colorAccent,
      String colorBackgroud,
      String colorPrimary,
      String description,
      String logo,
      String name,
      String status});
}

/// @nodoc
class __$$_BodyCopyWithImpl<$Res> extends _$BodyCopyWithImpl<$Res, _$_Body>
    implements _$$_BodyCopyWith<$Res> {
  __$$_BodyCopyWithImpl(_$_Body _value, $Res Function(_$_Body) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clinicID = null,
    Object? colorAccent = null,
    Object? colorBackgroud = null,
    Object? colorPrimary = null,
    Object? description = null,
    Object? logo = null,
    Object? name = null,
    Object? status = null,
  }) {
    return _then(_$_Body(
      clinicID: null == clinicID
          ? _value.clinicID
          : clinicID // ignore: cast_nullable_to_non_nullable
              as String,
      colorAccent: null == colorAccent
          ? _value.colorAccent
          : colorAccent // ignore: cast_nullable_to_non_nullable
              as String,
      colorBackgroud: null == colorBackgroud
          ? _value.colorBackgroud
          : colorBackgroud // ignore: cast_nullable_to_non_nullable
              as String,
      colorPrimary: null == colorPrimary
          ? _value.colorPrimary
          : colorPrimary // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      logo: null == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Body implements _Body {
  const _$_Body(
      {required this.clinicID,
      required this.colorAccent,
      required this.colorBackgroud,
      required this.colorPrimary,
      required this.description,
      required this.logo,
      required this.name,
      required this.status});

  factory _$_Body.fromJson(Map<String, dynamic> json) => _$$_BodyFromJson(json);

  @override
  final String clinicID;
  @override
  final String colorAccent;
  @override
  final String colorBackgroud;
  @override
  final String colorPrimary;
  @override
  final String description;
  @override
  final String logo;
  @override
  final String name;
  @override
  final String status;

  @override
  String toString() {
    return 'Body(clinicID: $clinicID, colorAccent: $colorAccent, colorBackgroud: $colorBackgroud, colorPrimary: $colorPrimary, description: $description, logo: $logo, name: $name, status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Body &&
            (identical(other.clinicID, clinicID) ||
                other.clinicID == clinicID) &&
            (identical(other.colorAccent, colorAccent) ||
                other.colorAccent == colorAccent) &&
            (identical(other.colorBackgroud, colorBackgroud) ||
                other.colorBackgroud == colorBackgroud) &&
            (identical(other.colorPrimary, colorPrimary) ||
                other.colorPrimary == colorPrimary) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.logo, logo) || other.logo == logo) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, clinicID, colorAccent,
      colorBackgroud, colorPrimary, description, logo, name, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BodyCopyWith<_$_Body> get copyWith =>
      __$$_BodyCopyWithImpl<_$_Body>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BodyToJson(
      this,
    );
  }
}

abstract class _Body implements Body {
  const factory _Body(
      {required final String clinicID,
      required final String colorAccent,
      required final String colorBackgroud,
      required final String colorPrimary,
      required final String description,
      required final String logo,
      required final String name,
      required final String status}) = _$_Body;

  factory _Body.fromJson(Map<String, dynamic> json) = _$_Body.fromJson;

  @override
  String get clinicID;
  @override
  String get colorAccent;
  @override
  String get colorBackgroud;
  @override
  String get colorPrimary;
  @override
  String get description;
  @override
  String get logo;
  @override
  String get name;
  @override
  String get status;
  @override
  @JsonKey(ignore: true)
  _$$_BodyCopyWith<_$_Body> get copyWith => throw _privateConstructorUsedError;
}

Message _$MessageFromJson(Map<String, dynamic> json) {
  return _Message.fromJson(json);
}

/// @nodoc
mixin _$Message {
  String get code => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String get severity => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageCopyWith<Message> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageCopyWith<$Res> {
  factory $MessageCopyWith(Message value, $Res Function(Message) then) =
      _$MessageCopyWithImpl<$Res, Message>;
  @useResult
  $Res call({String code, String message, String severity});
}

/// @nodoc
class _$MessageCopyWithImpl<$Res, $Val extends Message>
    implements $MessageCopyWith<$Res> {
  _$MessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
    Object? severity = null,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MessageCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory _$$_MessageCopyWith(
          _$_Message value, $Res Function(_$_Message) then) =
      __$$_MessageCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String code, String message, String severity});
}

/// @nodoc
class __$$_MessageCopyWithImpl<$Res>
    extends _$MessageCopyWithImpl<$Res, _$_Message>
    implements _$$_MessageCopyWith<$Res> {
  __$$_MessageCopyWithImpl(_$_Message _value, $Res Function(_$_Message) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
    Object? severity = null,
  }) {
    return _then(_$_Message(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Message implements _Message {
  const _$_Message(
      {required this.code, required this.message, required this.severity});

  factory _$_Message.fromJson(Map<String, dynamic> json) =>
      _$$_MessageFromJson(json);

  @override
  final String code;
  @override
  final String message;
  @override
  final String severity;

  @override
  String toString() {
    return 'Message(code: $code, message: $message, severity: $severity)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Message &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.severity, severity) ||
                other.severity == severity));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, message, severity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MessageCopyWith<_$_Message> get copyWith =>
      __$$_MessageCopyWithImpl<_$_Message>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MessageToJson(
      this,
    );
  }
}

abstract class _Message implements Message {
  const factory _Message(
      {required final String code,
      required final String message,
      required final String severity}) = _$_Message;

  factory _Message.fromJson(Map<String, dynamic> json) = _$_Message.fromJson;

  @override
  String get code;
  @override
  String get message;
  @override
  String get severity;
  @override
  @JsonKey(ignore: true)
  _$$_MessageCopyWith<_$_Message> get copyWith =>
      throw _privateConstructorUsedError;
}

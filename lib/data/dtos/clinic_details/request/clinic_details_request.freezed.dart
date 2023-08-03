// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'clinic_details_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ClinicDetailsRequest _$ClinicDetailsRequestFromJson(Map<String, dynamic> json) {
  return _ClinicDetailsRequest.fromJson(json);
}

/// @nodoc
mixin _$ClinicDetailsRequest {
  String get clinicID => throw _privateConstructorUsedError;
  String get institute => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClinicDetailsRequestCopyWith<ClinicDetailsRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClinicDetailsRequestCopyWith<$Res> {
  factory $ClinicDetailsRequestCopyWith(ClinicDetailsRequest value,
          $Res Function(ClinicDetailsRequest) then) =
      _$ClinicDetailsRequestCopyWithImpl<$Res, ClinicDetailsRequest>;
  @useResult
  $Res call({String clinicID, String institute});
}

/// @nodoc
class _$ClinicDetailsRequestCopyWithImpl<$Res,
        $Val extends ClinicDetailsRequest>
    implements $ClinicDetailsRequestCopyWith<$Res> {
  _$ClinicDetailsRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clinicID = null,
    Object? institute = null,
  }) {
    return _then(_value.copyWith(
      clinicID: null == clinicID
          ? _value.clinicID
          : clinicID // ignore: cast_nullable_to_non_nullable
              as String,
      institute: null == institute
          ? _value.institute
          : institute // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ClinicDetailsRequestCopyWith<$Res>
    implements $ClinicDetailsRequestCopyWith<$Res> {
  factory _$$_ClinicDetailsRequestCopyWith(_$_ClinicDetailsRequest value,
          $Res Function(_$_ClinicDetailsRequest) then) =
      __$$_ClinicDetailsRequestCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String clinicID, String institute});
}

/// @nodoc
class __$$_ClinicDetailsRequestCopyWithImpl<$Res>
    extends _$ClinicDetailsRequestCopyWithImpl<$Res, _$_ClinicDetailsRequest>
    implements _$$_ClinicDetailsRequestCopyWith<$Res> {
  __$$_ClinicDetailsRequestCopyWithImpl(_$_ClinicDetailsRequest _value,
      $Res Function(_$_ClinicDetailsRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clinicID = null,
    Object? institute = null,
  }) {
    return _then(_$_ClinicDetailsRequest(
      clinicID: null == clinicID
          ? _value.clinicID
          : clinicID // ignore: cast_nullable_to_non_nullable
              as String,
      institute: null == institute
          ? _value.institute
          : institute // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ClinicDetailsRequest implements _ClinicDetailsRequest {
  const _$_ClinicDetailsRequest(
      {required this.clinicID, required this.institute});

  factory _$_ClinicDetailsRequest.fromJson(Map<String, dynamic> json) =>
      _$$_ClinicDetailsRequestFromJson(json);

  @override
  final String clinicID;
  @override
  final String institute;

  @override
  String toString() {
    return 'ClinicDetailsRequest(clinicID: $clinicID, institute: $institute)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ClinicDetailsRequest &&
            (identical(other.clinicID, clinicID) ||
                other.clinicID == clinicID) &&
            (identical(other.institute, institute) ||
                other.institute == institute));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, clinicID, institute);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ClinicDetailsRequestCopyWith<_$_ClinicDetailsRequest> get copyWith =>
      __$$_ClinicDetailsRequestCopyWithImpl<_$_ClinicDetailsRequest>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ClinicDetailsRequestToJson(
      this,
    );
  }
}

abstract class _ClinicDetailsRequest implements ClinicDetailsRequest {
  const factory _ClinicDetailsRequest(
      {required final String clinicID,
      required final String institute}) = _$_ClinicDetailsRequest;

  factory _ClinicDetailsRequest.fromJson(Map<String, dynamic> json) =
      _$_ClinicDetailsRequest.fromJson;

  @override
  String get clinicID;
  @override
  String get institute;
  @override
  @JsonKey(ignore: true)
  _$$_ClinicDetailsRequestCopyWith<_$_ClinicDetailsRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

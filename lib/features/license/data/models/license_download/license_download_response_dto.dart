// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LicenseDownloadResponseDto {
  final String content;
  LicenseDownloadResponseDto({
    required this.content,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'content': content,
    };
  }

  factory LicenseDownloadResponseDto.fromMap(Map<String, dynamic> map) {
    return LicenseDownloadResponseDto(
      content: map['content'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LicenseDownloadResponseDto.fromJson(String source) =>
      LicenseDownloadResponseDto.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LicenseDownloadResponseDto(content: $content)';

  @override
  bool operator ==(covariant LicenseDownloadResponseDto other) {
    if (identical(this, other)) return true;

    return other.content == content;
  }

  @override
  int get hashCode => content.hashCode;
}

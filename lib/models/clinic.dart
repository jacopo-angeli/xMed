import 'package:equatable/equatable.dart';

class Clinic extends Equatable {
  final String? status;
  final String? clinicID;

  final String? name;
  final String? description;

  final String? logoContentType;
  final String? logoContent;
  final String? logoSize;

  final String? colorPrimary;
  final String? colorAccent;
  final String? colorBackground;

  const Clinic(
      {required this.status,
      required this.clinicID,
      required this.name,
      required this.description,
      required this.logoContentType,
      required this.logoContent,
      required this.logoSize,
      required this.colorPrimary,
      required this.colorAccent,
      required this.colorBackground});

  @override
  List<Object?> get props => [
        status,
        clinicID,
        name,
        description,
        logoContentType,
        logoContent,
        logoSize,
        colorPrimary,
        colorAccent,
        colorBackground
      ];
}

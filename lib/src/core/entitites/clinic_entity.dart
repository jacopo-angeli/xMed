import 'dart:convert';

/// Questa classe rappresenta una clinica all'interno dell'applicazione.
///
/// Un [ClinicEntity] contiene informazioni come lo stato della clinica,
/// l'ID univoco della clinica, il nome e la descrizione, oltre a dettagli
/// sul logo come il tipo di contenuto, il contenuto effettivo e la dimensione.
///
/// Inoltre, la classe tiene traccia dei colori associati alla clinica per
/// personalizzare l'aspetto dell'interfaccia utente, inclusi i colori primari,
/// di accentuazione e di sfondo.
class ClinicEntity {
  /// Lo stato attuale della clinica.
  final String? status;

  /// L'ID univoco della clinica.
  final String? clinicID;

  /// Il nome della clinica.
  final String? name;

  /// La descrizione della clinica.
  final String? description;

  /// Il tipo di contenuto del logo.
  final String? logoContentType;

  /// Il contenuto del logo (in un formato specifico).
  final String? logoContent;

  /// La dimensione del logo.
  final String? logoSize;

  /// Il colore primario associato alla clinica.
  final String? colorPrimary;

  /// Il colore di accentuazione associato alla clinica.
  final String? colorAccent;

  /// Il colore di sfondo associato alla clinica.
  final String? colorBackground;

  /// Costruttore della classe [ClinicEntity].
  ClinicEntity({
    this.status,
    this.clinicID,
    this.name,
    this.description,
    this.logoContentType,
    this.logoContent,
    this.logoSize,
    this.colorPrimary,
    this.colorAccent,
    this.colorBackground,
  });

  /// Crea una copia della clinica con attributi opzionali sovrascritti.
  ClinicEntity copyWith({
    String? status,
    String? clinicID,
    String? name,
    String? description,
    String? logoContentType,
    String? logoContent,
    String? logoSize,
    String? colorPrimary,
    String? colorAccent,
    String? colorBackground,
  }) {
    return ClinicEntity(
      status: status ?? this.status,
      clinicID: clinicID ?? this.clinicID,
      name: name ?? this.name,
      description: description ?? this.description,
      logoContentType: logoContentType ?? this.logoContentType,
      logoContent: logoContent ?? this.logoContent,
      logoSize: logoSize ?? this.logoSize,
      colorPrimary: colorPrimary ?? this.colorPrimary,
      colorAccent: colorAccent ?? this.colorAccent,
      colorBackground: colorBackground ?? this.colorBackground,
    );
  }

  /// Converte la clinica in una mappa chiave-valore.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'clinicID': clinicID,
      'name': name,
      'description': description,
      'logoContentType': logoContentType,
      'logoContent': logoContent,
      'logoSize': logoSize,
      'colorPrimary': colorPrimary,
      'colorAccent': colorAccent,
      'colorBackground': colorBackground,
    };
  }

  /// Crea un'istanza di [ClinicEntity] da una mappa.
  factory ClinicEntity.fromMap(Map<String, dynamic> map) {
    return ClinicEntity(
      status: map['status'] != null ? map['status'] as String : null,
      clinicID: map['clinicID'] != null ? map['clinicID'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      logoContentType: map['logoContentType'] != null
          ? map['logoContentType'] as String
          : null,
      logoContent:
          map['logoContent'] != null ? map['logoContent'] as String : null,
      logoSize: map['logoSize'] != null ? map['logoSize'] as String : null,
      colorPrimary:
          map['colorPrimary'] != null ? map['colorPrimary'] as String : null,
      colorAccent:
          map['colorAccent'] != null ? map['colorAccent'] as String : null,
      colorBackground: map['colorBackground'] != null
          ? map['colorBackground'] as String
          : null,
    );
  }

  /// Converte la clinica in una stringa JSON.
  String toJson() => json.encode(toMap());

  /// Crea un'istanza di [ClinicEntity] da una stringa JSON.
  factory ClinicEntity.fromJson(String source) =>
      ClinicEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  /// Sovrascrive l'operatore di uguaglianza `==` per confrontare due oggetti [ClinicEntity].
  @override
  bool operator ==(covariant ClinicEntity other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        other.clinicID == clinicID &&
        other.name == name &&
        other.description == description &&
        other.logoContentType == logoContentType &&
        other.logoContent == logoContent &&
        other.logoSize == logoSize &&
        other.colorPrimary == colorPrimary &&
        other.colorAccent == colorAccent &&
        other.colorBackground == colorBackground;
  }

  /// Sovrascrive il metodo `hashCode` per calcolare un valore hash unico per [ClinicEntity].
  @override
  int get hashCode {
    return status.hashCode ^
        clinicID.hashCode ^
        name.hashCode ^
        description.hashCode ^
        logoContentType.hashCode ^
        logoContent.hashCode ^
        logoSize.hashCode ^
        colorPrimary.hashCode ^
        colorAccent.hashCode ^
        colorBackground.hashCode;
  }

  /// Restituisce una rappresentazione testuale della clinica.
  @override
  String toString() {
    return 'ClinicEntity(status: $status, clinicID: $clinicID, name: $name, description: $description, logoContentType: $logoContentType, logoContent: $logoContent, logoSize: $logoSize, colorPrimary: $colorPrimary, colorAccent: $colorAccent, colorBackground: $colorBackground)';
  }
}

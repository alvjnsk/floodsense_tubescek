class LaporanModel {
  final String id;
  final String alamat;
  final String koordinat;
  final String catatan;
  final String? fotoPath;
  final bool approved;

  LaporanModel({
    required this.id,
    required this.alamat,
    required this.koordinat,
    required this.catatan,
    this.fotoPath,
    required this.approved,
  });

  /// 🔹 DARI API (JSON → OBJECT)
  factory LaporanModel.fromJson(Map<String, dynamic> json) {
    return LaporanModel(
      id: json['id'].toString(),
      alamat: json['alamat'] ?? '',
      koordinat: json['koordinat'] ?? '',
      catatan: json['catatan'] ?? '',
      fotoPath: json['foto'],
      approved: json['approved'] == 1 || json['approved'] == true,
    );
  }

  /// 🔹 KE API (OBJECT → JSON)
  Map<String, dynamic> toJson() {
    return {
      'alamat': alamat,
      'koordinat': koordinat,
      'catatan': catatan,
      'approved': approved ? 1 : 0,
    };
  }

  LaporanModel copyWith({
    bool? approved,
  }) {
    return LaporanModel(
      id: id,
      alamat: alamat,
      koordinat: koordinat,
      catatan: catatan,
      fotoPath: fotoPath,
      approved: approved ?? this.approved,
    );
  }
}

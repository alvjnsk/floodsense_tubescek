class LaporanModel {
  final String id;
  final String alamat;
  final String koordinat;
  final String catatan;
  final String? fotoPath;
  final String status;

  LaporanModel({
    required this.id,
    required this.alamat,
    required this.koordinat,
    required this.catatan,
    this.fotoPath,
    required this.status,
  });

  factory LaporanModel.fromJson(Map<String, dynamic> json) {
    return LaporanModel(
      id: json['id_laporan']?.toString() ?? '',
      alamat: json['alamat'] ?? '',
      koordinat: json['koordinat'] ?? '',
      catatan: json['isi_laporan'] ?? '',
      fotoPath: json['foto'],
      status: json['status'] ?? 'Belum Divalidasi',
    );
  }

  bool get isApproved => status.toLowerCase() == 'divalidasi';

  Map<String, dynamic> toJson() {
    return {
      'id_laporan': id,
      'alamat': alamat,
      'koordinat': koordinat,
      'isi_laporan': catatan,
      'foto': fotoPath,
      'status': status,
    };
  }

  LaporanModel copyWith({
    String? status,
  }) {
    return LaporanModel(
      id: id,
      alamat: alamat,
      koordinat: koordinat,
      catatan: catatan,
      fotoPath: fotoPath,
      status: status ?? this.status,
    );
  }
}
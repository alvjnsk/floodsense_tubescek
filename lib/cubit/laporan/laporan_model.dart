class LaporanModel {
  final String id;
  final String alamat;
  final String koordinat;
  final String catatan;
  final String? fotoPath;
  final String status; // Menggunakan String sesuai database (divalidasi / Belum Divalidasi)

  LaporanModel({
    required this.id,
    required this.alamat,
    required this.koordinat,
    required this.catatan,
    this.fotoPath,
    required this.status,
  });

  /// 🔹 DARI API (JSON → OBJECT)
  factory LaporanModel.fromJson(Map<String, dynamic> json) {
    return LaporanModel(
      id: json['id_laporan']?.toString() ?? '', // Sesuai JSON database
      alamat: json['alamat'] ?? '',
      koordinat: json['koordinat'] ?? '', // Default kosong jika tidak ada di JSON
      catatan: json['isi_laporan'] ?? '', // Sesuai JSON database: isi_laporan
      fotoPath: json['foto'], // Sesuai JSON database: foto
      status: json['status'] ?? 'Belum Divalidasi', // Sesuai JSON database: status
    );
  }

  /// Helper untuk mengecek status di UI (misal: untuk warna icon)
  bool get isApproved => status.toLowerCase() == 'divalidasi';

  /// 🔹 KE API (OBJECT → JSON)
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
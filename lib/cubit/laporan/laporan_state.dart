part of 'laporan_cubit.dart';

enum LaporanStatus { initial, loading, success, error }

class LaporanState extends Equatable {
  final String alamat;
  final String koordinat;
  final String catatan;
  final File? foto;

  final List<LaporanModel> laporanList; 
  final LaporanStatus status;

  const LaporanState({
    this.alamat = '',
    this.koordinat = '',
    this.catatan = '',
    this.foto,
    this.laporanList = const [], 
    this.status = LaporanStatus.initial,
  });

  LaporanState copyWith({
    String? alamat,
    String? koordinat,
    String? catatan,
    File? foto,
    List<LaporanModel>? laporanList,
    LaporanStatus? status,
  }) {
    return LaporanState(
      alamat: alamat ?? this.alamat,
      koordinat: koordinat ?? this.koordinat,
      catatan: catatan ?? this.catatan,
      foto: foto ?? this.foto,
      laporanList: laporanList ?? this.laporanList,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        alamat,
        koordinat,
        catatan,
        foto,
        laporanList,
        status,
      ];
}

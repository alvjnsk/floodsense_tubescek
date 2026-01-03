import 'dart:io';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

import 'laporan_model.dart';

part 'laporan_state.dart';

class LaporanCubit extends Cubit<LaporanState> {
  LaporanCubit() : super(const LaporanState());

  /// 🔗 GANTI DENGAN IP / DOMAIN SERVER KAMU
  static const String baseUrl = 'http://10.0.2.2:8000/api';

  void updateAlamat(String value) {
    emit(state.copyWith(alamat: value));
  }

  void updateKoordinat(String value) {
    emit(state.copyWith(koordinat: value));
  }

  void updateCatatan(String value) {
    emit(state.copyWith(catatan: value));
  }

  void setFoto(File file) {
    emit(state.copyWith(foto: file));
  }

  // =============================
  // USER KIRIM LAPORAN KE API
  // =============================
  Future<void> submit() async {
    emit(state.copyWith(status: LaporanStatus.loading));

    try {
      final uri = Uri.parse('$baseUrl/laporan');

      final request = http.MultipartRequest('POST', uri);

      request.fields['alamat'] = state.alamat;
      request.fields['koordinat'] = state.koordinat;
      request.fields['catatan'] = state.catatan;

      if (state.foto != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'foto',
            state.foto!.path,
          ),
        );
      }

      final response = await request.send();

      if (response.statusCode == 201) {
        emit(state.copyWith(
          status: LaporanStatus.success,
          alamat: '',
          koordinat: '',
          catatan: '',
          foto: null,
        ));
      } else {
        emit(state.copyWith(status: LaporanStatus.error));
      }
    } catch (e) {
      emit(state.copyWith(status: LaporanStatus.error));
    }
  }

  // =============================
  // ADMIN AMBIL DATA LAPORAN
  // =============================
  Future<void> fetchLaporan() async {
    emit(state.copyWith(status: LaporanStatus.loading));

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/laporan'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;

        final laporanList = data
            .map((e) => LaporanModel.fromJson(e))
            .toList();

        emit(state.copyWith(
          laporanList: laporanList,
          status: LaporanStatus.success,
        ));
      } else {
        emit(state.copyWith(status: LaporanStatus.error));
      }
    } catch (e) {
      emit(state.copyWith(status: LaporanStatus.error));
    }
  }

  // =============================
  // ADMIN ACC LAPORAN
  // =============================
  Future<void> approveLaporan(String id) async {
    try {
      await http.put(
        Uri.parse('$baseUrl/laporan/$id/approve'),
      );

      fetchLaporan();
    } catch (_) {}
  }
}

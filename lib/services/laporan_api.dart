import 'dart:io';
import 'package:http/http.dart' as http;

class LaporanApi {
  // Menggunakan 10.0.2.2 agar emulator bisa mengakses localhost laptop Anda
  static const String baseUrl = 'http://10.0.2.2:8000/api';

  // USER: Kirim Laporan ke tabel 'laporan'
  static Future<bool> kirimLaporan({
    required String idMasyarakat, 
    required String alamat,
    required String koordinat,
    String? catatan,
    File? foto,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/laporan');
      final request = http.MultipartRequest('POST', uri);

      // Sinkronisasi field dengan Laravel Controller
      request.fields['id_masyarakat'] = idMasyarakat; 
      request.fields['alamat'] = alamat;
      request.fields['koordinat'] = koordinat;
      
      // Di Laravel $request->catatan akan masuk ke kolom 'isi_laporan'
      if (catatan != null) {
        request.fields['catatan'] = catatan;
      }

      if (foto != null) {
        request.files.add(
          await http.MultipartFile.fromPath('foto', foto.path),
        );
      }

      final response = await request.send();
      
      // Laravel mengembalikan 201 Created jika sukses
      return response.statusCode == 201;
    } catch (e) {
      print('Error kirim laporan: $e');
      return false;
    }
  }

  // ADMIN: Mengubah status menjadi 'divalidasi'
  static Future<bool> approveLaporan(String idLaporan) async {
    try {
      // idLaporan di DB menggunakan String (L1234)
      final uri = Uri.parse('$baseUrl/laporan/$idLaporan/approve');
      
      // Menggunakan PUT sesuai route di api.php
      final response = await http.put(uri); 
      
      return response.statusCode == 200;
    } catch (e) {
      print('Error approve laporan: $e');
      return false;
    }
  }
}
import 'dart:io';
import 'package:http/http.dart' as http;

class LaporanApi {
  static const String baseUrl = 'http://10.0.2.2:8000/api';

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

      request.fields['id_masyarakat'] = idMasyarakat; 
      request.fields['alamat'] = alamat;
      request.fields['koordinat'] = koordinat;
      
      if (catatan != null) {
        request.fields['catatan'] = catatan;
      }

      if (foto != null) {
        request.files.add(
          await http.MultipartFile.fromPath('foto', foto.path),
        );
      }

      final response = await request.send();
      
      return response.statusCode == 201;
    } catch (e) {
      print('Error kirim laporan: $e');
      return false;
    }
  }

  static Future<bool> approveLaporan(String idLaporan) async {
    try {
      final uri = Uri.parse('$baseUrl/laporan/$idLaporan/approve');
      
      final response = await http.put(uri); 
      
      return response.statusCode == 200;
    } catch (e) {
      print('Error approve laporan: $e');
      return false;
    }
  }
}
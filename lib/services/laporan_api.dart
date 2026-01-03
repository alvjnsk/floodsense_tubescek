import 'dart:io';
import 'package:http/http.dart' as http;

class LaporanApi {
  static const String baseUrl = 'http://IP_KOMPUTER/api';

  static Future<bool> kirimLaporan({
    required String alamat,
    required String koordinat,
    String? catatan,
    File? foto,
  }) async {
    final uri = Uri.parse('$baseUrl/laporan');
    final request = http.MultipartRequest('POST', uri);

    request.fields['alamat'] = alamat;
    request.fields['koordinat'] = koordinat;
    if (catatan != null) request.fields['catatan'] = catatan;

    if (foto != null) {
      request.files.add(
        await http.MultipartFile.fromPath('foto', foto.path),
      );
    }

    final response = await request.send();
    return response.statusCode == 201;
  }
}

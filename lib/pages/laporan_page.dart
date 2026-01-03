import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../cubit/laporan/laporan_cubit.dart';

/// ===============================
/// WRAPPER: PROVIDER
/// ===============================
class LaporanPage extends StatelessWidget {
  const LaporanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LaporanCubit(),
      child: const LaporanView(),
    );
  }
}

/// ===============================
/// VIEW / UI (TIDAK DIUBAH)
/// ===============================
class LaporanView extends StatelessWidget {
  const LaporanView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LaporanCubit, LaporanState>(
      listener: (context, state) {
        if (state.status == LaporanStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Laporan berhasil dikirim')),
          );

          Navigator.pop(context); // kembali ke halaman sebelumnya
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: const BackButton(color: Colors.black),
          title: const Text(
            "Laporan Banjir",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ALERT
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE9D6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info, color: Colors.orange),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "Laporkan kondisi banjir di sekitar anda untuk membantu peringatan dini dan penanganan cepat",
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              /// ALAMAT
              _textField(
                label: "Alamat",
                hint: "Jl. Sukabirus",
                onChanged: (v) =>
                    context.read<LaporanCubit>().updateAlamat(v),
              ),

              const SizedBox(height: 12),

              /// KOORDINAT
              _textField(
                label: "Koordinat",
                hint: "Masukkan koordinat atau link maps",
                onChanged: (v) =>
                    context.read<LaporanCubit>().updateKoordinat(v),
              ),

              const SizedBox(height: 16),

              /// UPLOAD FOTO
              const Text(
                "Unggah Foto",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              BlocBuilder<LaporanCubit, LaporanState>(
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () async {
                      final picker = ImagePicker();
                      final pickedFile = await picker.pickImage(
                        source: ImageSource.gallery,
                        imageQuality: 70,
                      );

                      if (pickedFile != null) {
                        context
                            .read<LaporanCubit>()
                            .setFoto(File(pickedFile.path));
                      }
                    },
                    child: Container(
                      height: 120,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: state.foto != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                state.foto!,
                                fit: BoxFit.cover,
                              ),
                            )
                          : const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.image, size: 32),
                                SizedBox(height: 8),
                                Text("Upload foto"),
                              ],
                            ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 16),

              /// CATATAN
              _textField(
                label: "Catatan Tambahan",
                hint: "Contoh: air mulai naik sejak sore",
                maxLines: 3,
                onChanged: (v) =>
                    context.read<LaporanCubit>().updateCatatan(v),
              ),

              const SizedBox(height: 24),

              /// BUTTON
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0B3470),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    context.read<LaporanCubit>().submit();
                  },
                  child: const Text(
                    "Kirim Laporan",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// TEXT FIELD
  static Widget _textField({
    required String label,
    required String hint,
    int maxLines = 1,
    ValueChanged<String>? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        TextField(
          maxLines: maxLines,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ],
    );
  }
}

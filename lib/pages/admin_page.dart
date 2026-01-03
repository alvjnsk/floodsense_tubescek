import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/laporan/laporan_cubit.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin - Laporan Masuk'),
        backgroundColor: const Color(0xFF0B3470),
      ),
      body: BlocBuilder<LaporanCubit, LaporanState>(
        builder: (context, state) {
          if (state.laporanList.isEmpty) {
            return const Center(
              child: Text('Belum ada laporan'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.laporanList.length,
            itemBuilder: (context, index) {
              final laporan = state.laporanList[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        laporan.alamat,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text('Koordinat: ${laporan.koordinat}'),
                      const SizedBox(height: 6),
                      Text('Catatan: ${laporan.catatan}'),

                      const SizedBox(height: 8),

                      if (laporan.fotoPath != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            File(laporan.fotoPath!),
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),

                      const SizedBox(height: 12),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            laporan.approved ? 'APPROVED' : 'PENDING',
                            style: TextStyle(
                              color: laporan.approved
                                  ? Colors.green
                                  : Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (!laporan.approved)
                            ElevatedButton(
                              onPressed: () {
                                context
                                    .read<LaporanCubit>()
                                    .approveLaporan(laporan.id);
                              },
                              child: const Text('ACC'),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

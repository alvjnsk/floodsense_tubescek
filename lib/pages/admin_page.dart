import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/laporan/laporan_cubit.dart';

/// =============================================================
/// WRAPPER: Menambahkan BlocProvider agar AdminView bisa jalan
/// =============================================================
class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LaporanCubit(),
      child: const AdminView(),
    );
  }
}

/// =============================================================
/// VIEW: Bagian utama UI Admin
/// =============================================================
class AdminView extends StatefulWidget {
  const AdminView({super.key});

  @override
  State<AdminView> createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  @override
  void initState() {
    super.initState();
    // ✅ Mengambil data terbaru secara otomatis saat halaman terbuka
    context.read<LaporanCubit>().fetchLaporan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin - Laporan Masuk'),
        backgroundColor: const Color(0xFF0B3470),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<LaporanCubit>().fetchLaporan(),
          )
        ],
      ),
      body: BlocBuilder<LaporanCubit, LaporanState>(
        builder: (context, state) {
          if (state.status == LaporanStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.laporanList.isEmpty) {
            return const Center(child: Text('Belum ada laporan'));
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

                      // Menampilkan gambar dari URL Server Laravel
                      if (laporan.fotoPath != null && laporan.fotoPath!.isNotEmpty)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            'http://10.0.2.2:8000/storage/${laporan.fotoPath}',
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 100,
                                color: Colors.grey[300],
                                child: const Icon(Icons.broken_image),
                              );
                            },
                          ),
                        ),

                      const SizedBox(height: 12),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            laporan.isApproved ? 'DIVALIDASI' : 'PENDING',
                            style: TextStyle(
                              color: laporan.isApproved
                                  ? Colors.green
                                  : Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (!laporan.isApproved)
                            ElevatedButton(
                              onPressed: () {
                                context
                                    .read<LaporanCubit>()
                                    .approveLaporan(laporan.id);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                              ),
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
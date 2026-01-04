import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/home/home_cubit.dart';
import 'laporan_page.dart';
import '../cubit/laporan/laporan_cubit.dart';
import 'cctv_page.dart';
import 'history.dart';
import 'map_full_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, int>(
      builder: (context, navIndex) {
        return Scaffold(
          backgroundColor: const Color(0xFFF5F6FA),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Image.asset(
                'assets/images/FloodBiru.png',
                height: 70,
                fit: BoxFit.contain,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications),
                color: const Color(0xFF0B3470),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.logout),
                color: Colors.redAccent,
                onPressed: () => _showLogoutDialog(context),
              ),
            ],
          ),
          body: _buildBody(context),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _locationHeader(),
          const SizedBox(height: 12),
          _dangerCard(),
          const SizedBox(height: 16),
          _infoSection(),
          const SizedBox(height: 16),
          _interactiveMapCard(context),
          const SizedBox(height: 16),
          const Text(
            "Aksi Cepat",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _quickActionsRow(context),
        ],
      ),
    );
  }

  Widget _locationHeader() {
    return Row(
      children: [
        const Icon(Icons.location_on, size: 16, color: Colors.grey),
        const SizedBox(width: 4),
        const Text(
          "Kab. Bandung, Bojongsoang",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const Spacer(),
        TextButton(onPressed: () {}, child: const Text("Ganti")),
      ],
    );
  }

  Widget _infoSection() {
    return Row(
      children: [
        Expanded(
          child: _infoCard(
            icon: Icons.water_drop,
            title: "Kedalaman Sungai",
            value: "75 cm",
            status: "Stabil",
            color: Colors.blue,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _infoCard(
            icon: Icons.cloud,
            title: "Curah Hujan (24 Jam)",
            value: "100 mm",
            status: "Sangat Tinggi",
            color: Colors.orange,
          ),
        ),
      ],
    );
  }

  Widget _interactiveMapCard(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MapFullPage())),
      child: Container(
        height: 160,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.map_outlined, size: 40, color: Colors.blue),
              SizedBox(height: 8),
              Text("Buka Peta Interaktif", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0B3470))),
            ],
          ),
        ),
      ),
    );
  }

  Widget _quickActionsRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _QuickAction(
          icon: Icons.report,
          label: "Laporan",
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => BlocProvider(create: (_) => LaporanCubit(), child: const LaporanPage()))),
        ),
        _QuickAction(icon: Icons.videocam, label: "CCTV", onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CctvPage()))),
        _QuickAction(icon: Icons.history, label: "Riwayat", onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const historyPage()))),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Apakah Anda yakin ingin logout?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Batal")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false),
            child: const Text("Logout", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _dangerCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFFD32F2F), borderRadius: BorderRadius.circular(12)),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Status Bahaya Banjir", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text("Ketinggian air tercatat 50 cm meningkat dalam 8 jam terakhir", style: TextStyle(color: Colors.white)),
          SizedBox(height: 8),
          Text("Pembaruan terakhir: 05 Des 2025, 16:30", style: TextStyle(color: Colors.white70, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _infoCard({required IconData icon, required String title, required String value, required String status, required Color color}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontSize: 12)),
          Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
          Text(status, style: TextStyle(color: color, fontSize: 12)),
        ],
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _QuickAction({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(backgroundColor: Colors.blue.shade50, child: Icon(icon, color: Colors.blue)),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class historyPage extends StatelessWidget {
  const historyPage ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Riwayat")),
      body: const Center(
        child: Text(
          "Halaman Riwayat",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

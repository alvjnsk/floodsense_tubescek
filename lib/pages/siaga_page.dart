import 'package:flutter/material.dart';

class SiagaPage extends StatelessWidget {
  const SiagaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Siaga")),
      body: const Center(
        child: Text(
          "Halaman Siaga",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

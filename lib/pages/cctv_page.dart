import 'package:flutter/material.dart';

class CctvPage extends StatelessWidget {
  const CctvPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("CCTV")),
      body: const Center(
        child: Text(
          "Halaman CCTV",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

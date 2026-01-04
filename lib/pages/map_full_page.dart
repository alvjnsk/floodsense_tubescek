import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapFullPage extends StatelessWidget {
  const MapFullPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Peta Lokasi Banjir (Gratis)",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF0B3470),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: FlutterMap(
        options: const MapOptions(
          initialCenter: LatLng(-6.9764, 107.6390),
          initialZoom: 15.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.floodsense',
          ),
          const MarkerLayer(
            markers: [
              Marker(
                point: LatLng(-6.9764, 107.6390),
                width: 80,
                height: 80,
                child: Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 40,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
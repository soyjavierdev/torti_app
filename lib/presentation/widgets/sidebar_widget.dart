import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F4F4),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Bar de Patri (SINDI)',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Teléfono: 635 612 118',
                    style: TextStyle(fontSize: 16),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.sizeOf(context).width * 0.22,
                        maxHeight: MediaQuery.sizeOf(context).height * 0.15),
                    child: const Text(
                      'C. de Hinojosa del Duque, 7, San Blas-Canillejas, 28037 Madrid',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.sizeOf(context).width * 0.22,
                  maxHeight: MediaQuery.sizeOf(context).height * 0.15),
              child: FlutterMap(
                  options: const MapOptions(
                      initialCenter:
                          LatLng(40.431016150225865, -3.6131659435135375),
                      initialZoom: 16,
                      interactionOptions:
                          InteractionOptions(flags: InteractiveFlag.none)),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    ),
                    const MarkerLayer(markers: [
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        point: LatLng(40.431016150225865, -3.6131659435135375),
                        child: Icon(Icons.location_on,
                            color: Colors.red, size: 40),
                      )
                    ])
                  ]),
            ),
            const SizedBox(height: 16),
            Container(
              margin: const EdgeInsets.only(bottom: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Restaurante Juvima',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Teléfono: 634 974 521',
                    style: TextStyle(fontSize: 16),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.sizeOf(context).width * 0.22,
                        maxHeight: MediaQuery.sizeOf(context).height * 0.15),
                    child: const Text(
                      'C. Herencia, 6, San Blas-Canillejas, 28037 Madrid',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,

                    ),
                  ),
                ],
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.sizeOf(context).width * 0.22,
                  maxHeight: MediaQuery.sizeOf(context).height * 0.15),
              child: FlutterMap(
                  options: const MapOptions(
                      initialCenter:
                          LatLng(40.43112611536816, -3.6128109626037506),
                      initialZoom: 16,
                      interactionOptions:
                          InteractionOptions(flags: InteractiveFlag.none)),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    ),
                    const MarkerLayer(markers: [
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        point: LatLng(40.43112611536816, -3.6128109626037506),
                        child: Icon(Icons.location_on,
                            color: Colors.red, size: 40),
                      )
                    ])
                  ]),
            ),
            const SizedBox(height: 16),

            // Sección para el nombre del bar, número y dirección
            Container(
              margin: const EdgeInsets.only(bottom: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Restaurante Campiño',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Teléfono: 913 241 213',
                    style: TextStyle(fontSize: 16),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.sizeOf(context).width * 0.22,
                        maxHeight: MediaQuery.sizeOf(context).height * 0.15),
                    child: const Text(
                      'C. de María Sevilla Diago, 5, San Blas-Canillejas, 28022 Madrid',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,

                    ),
                  ),
                ],
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.sizeOf(context).width * 0.22,
                  maxHeight: MediaQuery.sizeOf(context).height * 0.15),
              child: FlutterMap(
                  options: const MapOptions(
                      initialCenter:
                          LatLng(40.433080966864395, -3.6112322754109845),
                      initialZoom: 16,
                      interactionOptions:
                          InteractionOptions(flags: InteractiveFlag.none)),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    ),
                    const MarkerLayer(markers: [
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        point: LatLng(40.433080966864395, -3.6112322754109845),
                        child: Icon(Icons.location_on,
                            color: Colors.red, size: 40),
                      )
                    ])
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}

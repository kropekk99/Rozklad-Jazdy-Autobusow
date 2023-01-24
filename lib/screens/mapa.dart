import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Mapa extends StatefulWidget {
  final int przystanek;
  final int id;
  final int numer;
  Mapa(this.przystanek, this.id, this.numer);

  @override
  State<Mapa> createState() => MapSampleState();
}


class MapSampleState extends State<Mapa> {
  List _mapa = [];

  Future<void> readJsonFile() async {
    var url = 'https://api.npoint.io/102608878c0a16e1c13e';
    var res = await http.get(Uri.parse(url));
    var mapaData = await json.decode(res.body);

    setState(() {
      _mapa = mapaData['data'][widget.id]['linie'][widget.numer]['przystanki'];
    });
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');
    controller.setMapStyle(value);
  }

  @override
  Widget build(BuildContext context) {
    readJsonFile();
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        myLocationEnabled: true,
        markers: {
          Marker(
            markerId: MarkerId('_markerId'),
              infoWindow: InfoWindow(title: _mapa[widget.przystanek]["nazwa"]),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
              position: LatLng(double.parse(_mapa[widget.przystanek]["dl"]),double.parse(_mapa[widget.przystanek]["szer"]))
          )},
        initialCameraPosition: CameraPosition(
          target: LatLng(double.parse(_mapa[widget.przystanek]["dl"]),double.parse(_mapa[widget.przystanek]["szer"])),
          zoom: 14.90,
        ),
        onMapCreated: _onMapCreated,
      ),
    );
  }
}
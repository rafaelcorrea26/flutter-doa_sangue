import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';

class AgendamentoPage extends StatefulWidget {
  const AgendamentoPage({Key? key}) : super(key: key);

  @override
  State<AgendamentoPage> createState() => _AgendamentoPageState();
}

class _AgendamentoPageState extends State<AgendamentoPage> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _marcadores = {};
  Set<Marker> _marcadoresPostos = {};

  _recuperarLocalizacaoAtual() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print("localização atual:" + position.toString());
  }

  _carregarMarcadores() {
    Marker marcadorPosto1 = Marker(
        markerId: MarkerId("marcadorPosto1"),
        position: LatLng(-30.859936627097856, -51.801529488434994),
        infoWindow: InfoWindow(title: "Posto 1"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue));

    Marker marcadorPosto2 = Marker(
        markerId: MarkerId("marcadorPosto2"),
        position: LatLng(-30.859936627097856, -51.801529488434994),
        infoWindow: InfoWindow(title: "Posto 2"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue));

    Marker marcadorPosto3 = Marker(
        markerId: MarkerId("marcadorPosto3"),
        position: LatLng(-30.859936627097856, -51.801529488434994),
        infoWindow: InfoWindow(title: "Posto 3"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue));

    _marcadoresPostos.add(marcadorPosto1);
    _marcadoresPostos.add(marcadorPosto2);
    _marcadoresPostos.add(marcadorPosto3);

    setState(() {
      _marcadores = _marcadoresPostos;
    });
  }

  @override
  void initState() {
    _recuperarLocalizacaoAtual();
    _carregarMarcadores();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: corpo(context),
      appBar: barraSuperior(),
    );
  }

  barraSuperior() {
    return AppBar(
      title: Text("Tela agendamento de doação"),
      centerTitle: true,
      backgroundColor: Colors.red[400],
    );
  }

  _onMapCreated(GoogleMapController googleMapController) {
    _controller.complete(googleMapController);
  }

  Widget corpo(context) {
    return Container(
      child: GoogleMap(
          mapType: MapType.normal,
          // -30.859936627097856, -51.801529488434994
          initialCameraPosition: CameraPosition(target: LatLng(-30.859936627097856, -51.801529488434994), zoom: 18),
          onMapCreated: _onMapCreated),
    );
  }
}

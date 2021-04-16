import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps/models/placement.dart';
import 'package:maps/pages/placement_details.dart';
import 'package:geolocator/geolocator.dart';

class MapsPage extends StatefulWidget {
  final List<Placement> placements;

  MapsPage(this.placements);

  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  Completer<GoogleMapController> _controller = Completer();

  static CameraPosition _kCameraPos;

  static CameraPosition _kMyPosition;

  LatLng myPosition;

  @override
  void initState() {
    super.initState();
    _updateMyPosition();
  }

  @override
  Widget build(BuildContext context) {
    List<Marker> markers = [];

    _kCameraPos = CameraPosition(
      target: LatLng(widget.placements[0].lat ?? 37.42796133580664,
          widget.placements[0].lng ?? -122.085749655962),
      zoom: 14.4746,
    );

    _kMyPosition = CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(myPosition?.latitude ?? 37.43296265331129,
            myPosition?.longitude ?? -122.08832357078792),
        tilt: 59.440717697143555,
        zoom: 19.151926040649414);

    markers.add(Marker(
      markerId: MarkerId("My Position"),
      position: LatLng(myPosition?.latitude ?? 37.42796133580664,
          myPosition?.longitude ?? -122.08832357078792),
      infoWindow: InfoWindow(
          title: "My Position",
          snippet:
              "lat: ${myPosition?.latitude?.floor()}...lng: ${myPosition?.longitude?.floor()}..."),
    ));

    widget.placements.forEach((placement) {
      markers.add(Marker(
        markerId: MarkerId("marker-${widget.placements.indexOf(placement)}"),
        position: LatLng(placement.lat ?? 37.42796133580664,
            placement.lng ?? -122.085749655962),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PlacementDetailsPage(placement)));
        },
      ));
    });

    return new Scaffold(
      appBar: AppBar(
        title: Text("Maps"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        markers: markers.toSet(),
        initialCameraPosition: _kCameraPos,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToMyPosition,
        label: Text('My Position'),
        icon: Icon(Icons.gps_fixed_outlined),
      ),
    );
  }

  _updateMyPosition() async {
    Position p = await _determinePosition();

    if (p != null) {
      setState(() {
        myPosition = LatLng(p.latitude, p.longitude);
      });
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> _goToMyPosition() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kMyPosition));
  }
}

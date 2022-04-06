
/*import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  double latitude;
  double longitude;
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(36.894404715258254, 10.186415108375586),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(36.848206853908174, 10.194803935754303),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        myLocationButtonEnabled: true,
        onTap: (latlang) async {
          latitude= latlang.latitude;
          longitude= latlang.longitude;
     final coordinates = new Coordinates(
         latitude, longitude);
     var addresses = await Geocoder.local.findAddressesFromCoordinates(
         coordinates);
     var first = addresses.first;

         // first.removeWhere((key, value) => key == null || value == null);

          print(' ${first.locality}, ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}');
      // print(first.toString());
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To EY!'),
        icon: Icon(Icons.directions_boat),

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,

    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));

  }
}
*/

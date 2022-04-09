import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(36.806389, 10.181667),
    zoom: 14.4746,
  );

  Completer<GoogleMapController> _controller = Completer();
  List<Marker> markers = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width),
      height: (MediaQuery.of(context).size.width),
      child: GoogleMap(
        zoomGesturesEnabled: true, //enable Zoom in, out on map
        mapType: MapType.normal,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onTap: (LatLng latLng) {
          Marker newMaker = Marker(
              markerId: MarkerId("ii"),
              position: LatLng(latLng.latitude, latLng.longitude),
              infoWindow: InfoWindow(title: 'test'),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueRed));

          markers.add(newMaker);
          setState(() {});
          print("Our lat nad long is : $latLng");
        },

        markers: markers.map((e) => e).toSet(),
        initialCameraPosition:
            CameraPosition(target: LatLng(36.806389, 10.181667), zoom: 14),

        onMapCreated: (controller) {
          _controller.complete(controller);
        },
        gestureRecognizers: Set()
          ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
          ..add(
            Factory<VerticalDragGestureRecognizer>(
                () => VerticalDragGestureRecognizer()),
          )
          ..add(
            Factory<HorizontalDragGestureRecognizer>(
                () => HorizontalDragGestureRecognizer()),
          )
          ..add(
            Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()),
          ),
      ),
    );
  }
}

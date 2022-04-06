import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/gestures.dart';

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
  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width),
      height: (MediaQuery.of(context).size.width),
      child: GoogleMap(
        zoomGesturesEnabled: true, //enable Zoom in, out on map

        mapType: MapType.normal,
        initialCameraPosition:
            CameraPosition(target: LatLng(36.806389, 10.181667), zoom: 14),

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

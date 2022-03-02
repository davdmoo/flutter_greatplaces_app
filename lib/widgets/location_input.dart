import "package:flutter/material.dart";
import 'package:google_maps_flutter/google_maps_flutter.dart';
import "package:location/location.dart";

import "../helpers/location_helper.dart";
import "../screens/map_screen.dart";

class LocationInput extends StatefulWidget {
  final Function selectPlaceHandler;

  LocationInput(this.selectPlaceHandler);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;

  void _showPreview(double lat, double lng) {
    final staticMapUrl = LocationHelper.generateLocationPreviewImage(
      latitude: lat,
      longitude: lng,
    );

    setState(() {
      _previewImageUrl = staticMapUrl;
    });
  }

  Future<void> _getCurrentLocation() async {
    try {
      final locationData = await Location().getLocation();
      _showPreview(locationData.latitude, locationData.longitude);

      widget.selectPlaceHandler(locationData.latitude, locationData.longitude);
    } catch (error) {
      // throw error;
      return;
    }
  }

  Future<void> _selectOnMap() async {
    final LatLng selectedLocation = await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapScreen(isSelecting: true)
      )
    );

    if (selectedLocation == null) return;

    _showPreview(selectedLocation.latitude, selectedLocation.longitude);

    widget.selectPlaceHandler(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 150,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _previewImageUrl == null 
          ? const Text("No location chosen", textAlign: TextAlign.center)
          : Image.network(_previewImageUrl, fit: BoxFit.cover, width: double.infinity),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton.icon(
              icon: const Icon(Icons.location_on),
              label: const Text("Current Location"),
              onPressed: _getCurrentLocation,
            ),
            TextButton.icon(
              icon: const Icon(Icons.map),
              label: const Text("Choose a Location"),
              onPressed: _selectOnMap,
            ),
          ],
        ),
      ],
    );
  }
}
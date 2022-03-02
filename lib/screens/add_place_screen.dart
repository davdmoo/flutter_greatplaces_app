import "dart:io";

import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../providers/places.dart";
import "../widgets/image_input.dart";
import "../widgets/location_input.dart";
import "../models/place.dart";

class AddPlaceScreen extends StatefulWidget {
  static const routeName = "/add-place";

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _nameController = TextEditingController();
  File _pickedImage;
  PlaceLocation _pickedLocation;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _selectPlace(double lat, double lng) {
    _pickedLocation = PlaceLocation(latitude: lat, longitude: lng);
  }

  void _submitPlace() {
    if (_nameController.text.isEmpty || _pickedImage == null || _pickedLocation == null) {
      return;
    }

    Provider.of<PlacesProvider>(context, listen: false).addPlace(_nameController.text, _pickedImage, _pickedLocation);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a new place"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: "Name"),
                      controller: _nameController,
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: ImageInput(_selectImage),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: LocationInput(_selectPlace),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            label: const Text("Add Place"),
            icon: Icon(Icons.add),
            onPressed: _submitPlace,
          ),
        ],
      )
    );
  }
}
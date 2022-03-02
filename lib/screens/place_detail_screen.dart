import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../providers/places.dart";
import "./map_screen.dart";

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = "/place-detail";

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final place = Provider.of<PlacesProvider>(context, listen: false).fetchPlaceById(id);

    return Scaffold(
      appBar: AppBar(
        title: Text(place.name),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(place.image, fit: BoxFit.cover, width: double.infinity),
          ),
          SizedBox(height: 10),
          Text(
            place.location.address,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
          TextButton(
            child: const Text("View on Map"),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (ctx) => MapScreen(initialLocation: place.location),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
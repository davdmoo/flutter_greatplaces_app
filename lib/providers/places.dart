import "dart:io";

import "package:flutter/foundation.dart";

import "../helpers/db_helper.dart";
import "../helpers/location_helper.dart";
import "../models/place.dart";

class PlacesProvider with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Future<void> addPlace(String name, File image, PlaceLocation pickedLocation) async {
    final address = await LocationHelper.getPlaceAddress(pickedLocation.latitude, pickedLocation.longitude);
    final updatedLocation = PlaceLocation(
      latitude: pickedLocation.latitude,
      longitude: pickedLocation.longitude,
      address: address,
    );

    final newPlace = Place(
      id: DateTime.now().toString(),
      name: name,
      image: image,
      location: updatedLocation,
    );

    _items.add(newPlace);

    notifyListeners();
    DBHelper.insert(
      "user_places",
      {
        "id": newPlace.id,
        "name": newPlace.name,
        "image": newPlace.image.path,
        "loc_lat": newPlace.location.latitude,
        "loc_lng": newPlace.location.longitude,
        "address": newPlace.location.address,
      },
    );
  }

  Future<void> fetchPlaces() async {
    final placesList = await DBHelper.fetchData("user_places");
    _items = placesList.map((place) => Place(
      id: place["id"],
      name: place["name"],
      image: File(place["image"]),
      location: PlaceLocation(
        latitude: place["loc_lat"],
        longitude: place["loc_lng"],
        address: place["address"],
      ),
    )).toList();

    notifyListeners();
  }

  Place fetchPlaceById(String id) {
    return _items.firstWhere((place) => place.id == id);
  }
}
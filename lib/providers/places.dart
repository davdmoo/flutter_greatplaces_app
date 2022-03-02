import "dart:io";

import "package:flutter/foundation.dart";

import "../helpers/db_helper.dart";
import "../models/place.dart";

class PlacesProvider with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String name, File image) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      name: name,
      image: image,
      location: null,
    );

    _items.add(newPlace);

    notifyListeners();
    DBHelper.insert(
      "user_places",
      {
        "id": newPlace.id,
        "name": newPlace.name,
        "image": newPlace.image.path,
      },
    );
  }

  Future<void> fetchPlaces() async {
    final placesList = await DBHelper.fetchData("user_places");
    _items = placesList.map((place) => Place(
      id: place["id"],
      name: place["name"],
      image: File(place["image"]),
      location: null,
    )).toList();

    notifyListeners();
  }
}
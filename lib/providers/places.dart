import "dart:io";

import "package:flutter/foundation.dart";

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
  }
}
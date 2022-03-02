import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "./add_place_screen.dart";
import "../providers/places.dart";

class PlacesListScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Places"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<PlacesProvider>(context, listen: false).fetchPlaces(),
        builder: (ctx, snapshot) => 
          snapshot.connectionState == ConnectionState.waiting 
            ? Center(child: CircularProgressIndicator())
            : Consumer<PlacesProvider>(
              child: Center(
                child: const Text("No places yet!"),
              ),
              builder:(ctx, places, ch) => // ch refers to the child atop of this (Center)
                places.items.length <= 0
                  ? ch
                  : ListView.builder(
                      itemCount: places.items.length,
                      itemBuilder: (ctx, i) => ListTile(
                        leading: CircleAvatar(
                          backgroundImage: FileImage(places.items[i].image),
                        ),
                        title: Text(places.items[i].name),
                        onTap: () {
                          // Go to details
                        },
                      ),
                    ),
        ),
      ),
    );
  }
}
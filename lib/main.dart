import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";

import "./screens/places_list_screen.dart";
import "./screens/add_place_screen.dart";
import "./providers/places.dart";

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: PlacesProvider(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          colorScheme: ThemeData().colorScheme.copyWith(
            primary: Colors.indigo,
            secondary: Colors.blue[900],
          ),
        ),
        home: PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
        }
      ),
    );
  }
}

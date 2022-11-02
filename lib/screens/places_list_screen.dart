import 'package:flutter/material.dart';
import 'package:great_places_app/providers/places_provider.dart';
import 'package:great_places_app/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Places'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              },
              icon: const Icon(Icons.add),
            )
          ],
        ),
        body: FutureBuilder(
          future: Provider.of<PlacesProvider>(context, listen: false)
              .fetchAndSetPlaces(),
          builder: (context, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<PlacesProvider>(
                  builder: (context, places, child) => places.items.length <= 0
                      ? const Center(child: Text('You ain\'t got no places'))
                      : ListView.builder(
                          itemCount: places.items.length,
                          itemBuilder: (context, index) => ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  FileImage(places.items[index].image),
                            ),
                            title: Text(places.items[index].title),
                            onTap: () {},
                          ),
                        ),
                ),
        ));
  }
}

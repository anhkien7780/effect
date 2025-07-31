import 'package:effect/ui/parallax_recipe_app/models/entities/location.dart';
import 'package:effect/ui/parallax_recipe_app/widgets/location_list_item.dart';
import 'package:flutter/material.dart';

class ParallaxRecipeApp extends StatelessWidget {
  const ParallaxRecipeApp({super.key});

  @override
  Widget build(BuildContext context) {
    final locations = _getListLocation();
    return SingleChildScrollView(
      child: Column(
        children: List.generate(locations.length, (index) {
          return LocationListItem(
            imageUrl: locations[index].imageUrl,
            name: locations[index].name,
            country: locations[index].place,
          );
        }),
      ),
    );
  }

  List<Location> _getListLocation() {
    final urlPrefix =
        'https://docs.flutter.dev/cookbook/img-files/effects/parallax';
    final List<Location> locations = [
      Location(
        name: 'Mount Rushmore',
        place: 'U.S.A',
        imageUrl: '$urlPrefix/01-mount-rushmore.jpg',
      ),
      Location(
        name: 'Gardens By The Bay',
        place: 'Singapore',
        imageUrl: '$urlPrefix/02-singapore.jpg',
      ),
      Location(
        name: 'Machu Picchu',
        place: 'Peru',
        imageUrl: '$urlPrefix/03-machu-picchu.jpg',
      ),
      Location(
        name: 'Vitznau',
        place: 'Switzerland',
        imageUrl: '$urlPrefix/04-vitznau.jpg',
      ),
      Location(
        name: 'Bali',
        place: 'Indonesia',
        imageUrl: '$urlPrefix/05-bali.jpg',
      ),
      Location(
        name: 'Mexico City',
        place: 'Mexico',
        imageUrl: '$urlPrefix/06-mexico-city.jpg',
      ),
    ];
    return locations;
  }
}

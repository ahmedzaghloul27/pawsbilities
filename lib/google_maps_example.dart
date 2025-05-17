import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'api_keys.dart';

class GoogleMapsExample extends StatelessWidget {
  const GoogleMapsExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Maps Example'),
      ),
      body: Column(
        children: [
          // Example of using the API key
          Text('Using API key: ${ApiKeys.googleMapsApiKey.substring(0, 3)}...'),

          // In actual usage, you would use it like this:
          // GoogleMap(
          //   initialCameraPosition: CameraPosition(
          //     target: LatLng(37.42796133580664, -122.085749655962),
          //     zoom: 14.4746,
          //   ),
          // )

          // Note: To use Google Maps, you'll also need to add the API key
          // to your AndroidManifest.xml and Info.plist files
        ],
      ),
    );
  }
}

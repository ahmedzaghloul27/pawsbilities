import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:geolocator/geolocator.dart';

class SetLocationPage extends StatefulWidget {
  const SetLocationPage({super.key});

  @override
  State<SetLocationPage> createState() => _SetLocationPageState();
}

class _SetLocationPageState extends State<SetLocationPage> {
  final TextEditingController _searchController = TextEditingController();
  static const LatLng _initialPosition =
      LatLng(33.5207, -86.8025); // Birmingham, AL
  LatLng _markerPosition = _initialPosition;
  GoogleMapController? _mapController;
  List<AutocompletePrediction> _predictions = [];
  String _selectedLocationName = 'Alexandria, Egypt';
  bool _isLoading = false;

  final String _googleApiKey = 'AIzaSyD4JvQ5V1FZHEAtCluWpb8l0y3o-PJS7K8';
  late GooglePlace _googlePlace;

  @override
  void initState() {
    super.initState();
    _googlePlace = GooglePlace(_googleApiKey);
  }

  void _onMapCreated(GoogleMapController controller) {
    print('Map controller created');
    _mapController = controller;
  }

  void _searchLocation(String value) async {
    if (value.isEmpty) {
      setState(() {
        _predictions = [];
      });
      return;
    }
    var result = await _googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null) {
      setState(() {
        _predictions = result.predictions!;
      });
    }
  }

  void _selectPrediction(AutocompletePrediction prediction) async {
    try {
      setState(() {
        _isLoading = true;
      });

      print('Fetching details for place: ${prediction.placeId}');
      final details = await _googlePlace.details.get(prediction.placeId!);

      if (details == null) {
        throw Exception('Failed to get place details');
      }

      if (details.result == null) {
        throw Exception('Place details result is null');
      }

      if (details.result!.geometry == null) {
        throw Exception('Place geometry is null');
      }

      if (details.result!.geometry!.location == null) {
        throw Exception('Place location is null');
      }

      final lat = details.result!.geometry!.location!.lat;
      final lng = details.result!.geometry!.location!.lng;

      if (lat == null || lng == null) {
        throw Exception('Latitude or longitude is null');
      }

      print('Setting new position: lat=$lat, lng=$lng');
      final newPosition = LatLng(lat, lng);

      setState(() {
        _markerPosition = newPosition;
        _selectedLocationName =
            details.result!.name ?? prediction.description ?? '';
        _searchController.text = _selectedLocationName;
        _predictions = [];
      });

      if (_mapController != null) {
        print('Animating camera to new position');
        await _mapController!.animateCamera(
          CameraUpdate.newLatLngZoom(newPosition, 15.0),
        );
      } else {
        print('Map controller is null');
      }
    } catch (e) {
      print('Error selecting prediction: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      setState(() {
        _isLoading = true;
      });

      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permission denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permission permanently denied');
      }

      // Get current position
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final newPosition = LatLng(position.latitude, position.longitude);

      setState(() {
        _markerPosition = newPosition;
        _selectedLocationName = 'Current Location';
        _searchController.text = _selectedLocationName;
      });

      if (_mapController != null) {
        await _mapController!.animateCamera(
          CameraUpdate.newLatLngZoom(newPosition, 15.0),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error getting location: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onDone() {
    Navigator.of(context).pop({
      'lat': _markerPosition.latitude,
      'lng': _markerPosition.longitude,
      'name': _selectedLocationName,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              'Set your location',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
            child: Text(
              'Search your location for accurate matching.',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
            child: Stack(
              children: [
                TextField(
                  controller: _searchController,
                  onChanged: _searchLocation,
                  decoration: InputDecoration(
                    hintText: 'Search your location',
                    filled: true,
                    fillColor: const Color(0xFFF7F7F7),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                          color: Color(0xFFE0E0E0), width: 1.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                          color: Color(0xFFE0E0E0), width: 1.5),
                    ),
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  ),
                ),
                if (_predictions.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 50),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _predictions.length,
                      itemBuilder: (context, index) {
                        final p = _predictions[index];
                        return ListTile(
                          title: Text(p.description ?? ''),
                          onTap: () => _selectPrediction(p),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                  ),
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: const CameraPosition(
                      target: _initialPosition,
                      zoom: 13.0,
                    ),
                    markers: {
                      Marker(
                        markerId: const MarkerId('selected-location'),
                        position: _markerPosition,
                        draggable: true,
                        onDragEnd: (LatLng newPosition) {
                          setState(() {
                            _markerPosition = newPosition;
                          });
                        },
                      ),
                    },
                    myLocationButtonEnabled: false,
                    myLocationEnabled: true,
                  ),
                ),
                if (_isLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                Positioned(
                  right: 24,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 24,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FloatingActionButton(
                        onPressed: _getCurrentLocation,
                        backgroundColor: Colors.white,
                        child:
                            const Icon(Icons.my_location, color: Colors.black),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _onDone,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 2,
                        ),
                        child: const Text('Done',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

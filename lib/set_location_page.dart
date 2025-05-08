import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';

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

  
  final String _googleApiKey = 'AIzaSyD4JvQ5V1FZHEAtCluWpb8l0y3o-PJS7K8';
  late GooglePlace _googlePlace;

  @override
  void initState() {
    super.initState();
    _googlePlace = GooglePlace(_googleApiKey);
  }

  void _onMapCreated(GoogleMapController controller) {
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
    final details = await _googlePlace.details.get(prediction.placeId!);
    if (details != null &&
        details.result != null &&
        details.result!.geometry != null) {
      final lat = details.result!.geometry!.location!.lat;
      final lng = details.result!.geometry!.location!.lng;
      setState(() {
        _markerPosition = LatLng(lat!, lng!);
        _selectedLocationName =
            details.result!.name ?? prediction.description ?? '';
        _searchController.text = _selectedLocationName;
        _predictions = [];
      });
      _mapController?.animateCamera(CameraUpdate.newLatLng(_markerPosition));
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
                    myLocationEnabled: false,
                  ),
                ),
                Positioned(
                  right: 24,
                  bottom: 24,
                  child: ElevatedButton(
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

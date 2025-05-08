import 'package:flutter/material.dart';
import 'widgets/custom_nav_bar.dart';
import 'community_page.dart';
import 'lost_and_found_page.dart';
import 'matching_screen.dart';
import 'My_profilePage.dart';
import 'widgets/sticky_header.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'Notifications.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  int _selectedIndex = 3;
  GoogleMapController? _mapController;
  static const LatLng _center = LatLng(14.5995, 120.9842); // Manila coordinates
  Set<Marker> _markers = {};
  final Location _location = Location();
  bool _serviceEnabled = false;
  PermissionStatus? _permissionGranted;
  LocationData? _currentLocation;
  int _selectedToggle = 0;

  // Sample marker data for each category
  final List<Marker> _storeMarkers = [
    Marker(
      markerId: MarkerId('store1'),
      position: LatLng(14.6000, 120.9850),
      infoWindow: InfoWindow(title: 'Pet Store 1'),
    ),
    Marker(
      markerId: MarkerId('store2'),
      position: LatLng(14.6010, 120.9860),
      infoWindow: InfoWindow(title: 'Pet Store 2'),
    ),
  ];
  final List<Marker> _shelterMarkers = [
    Marker(
      markerId: MarkerId('shelter1'),
      position: LatLng(14.6020, 120.9870),
      infoWindow: InfoWindow(title: 'Animal Shelter 1'),
    ),
  ];
  final List<Marker> _vetMarkers = [
    Marker(
      markerId: MarkerId('vet1'),
      position: LatLng(14.6030, 120.9880),
      infoWindow: InfoWindow(title: 'Vet Clinic 1'),
    ),
  ];

  Set<Marker> get _allMarkers => {
        ..._storeMarkers,
        ..._shelterMarkers,
        ..._vetMarkers,
      };

  void _updateMarkers(int selected) {
    setState(() {
      _selectedToggle = selected;
      if (selected == 0) {
        _markers = Set<Marker>.from(_allMarkers);
      } else if (selected == 1) {
        _markers = Set<Marker>.from(_storeMarkers);
      } else if (selected == 2) {
        _markers = Set<Marker>.from(_shelterMarkers);
      } else if (selected == 3) {
        _markers = Set<Marker>.from(_vetMarkers);
      }
      print('Markers updated: [32m${_markers.length}[0m');
    });
  }

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
    _markers = _allMarkers;
  }

  Future<void> _checkLocationPermission() async {
    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentLocation = await _location.getLocation();
    if (_currentLocation != null && _mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
                _currentLocation!.latitude!, _currentLocation!.longitude!),
            zoom: 15,
          ),
        ),
      );
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _mapController = controller;
    });
  }

  void _locateMe() async {
    if (_currentLocation != null && _mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
                _currentLocation!.latitude!, _currentLocation!.longitude!),
            zoom: 15,
          ),
        ),
      );
    } else {
      await _checkLocationPermission();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const CommunityPage()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LostAndFoundPage()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MatchingScreen()),
        );
        break;
      case 3:
        // Already on discover page
        break;
      case 4:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyProfilePage()),
        );
        break;
    }
  }

  Widget _buildToggleButtons() {
    final List<String> labels = ['All', 'Stores', 'Shelters', 'Vets'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(labels.length, (index) {
          final bool isSelected = _selectedToggle == index;
          return Padding(
            padding: EdgeInsets.only(
                left: index == 0 ? 16 : 8,
                right: index == labels.length - 1 ? 16 : 0),
            child: GestureDetector(
              onTap: () {
                _updateMarkers(index);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF2D1313)
                      : const Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(61),
                  border: Border.all(color: const Color(0xFFC5C5C5), width: 2),
                ),
                child: Text(
                  labels[index],
                  style: TextStyle(
                    color: isSelected ? Colors.white : const Color(0xFF2D1313),
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: false,
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: StickyHeader(
              title: 'Discover',
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: SvgPicture.asset(
                      'assets/icons/Bell_icon.svg',
                      width: 24,
                      height: 24,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Notifications_AppPage(),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: SvgPicture.asset(
                      'assets/icons/Chat_icon.svg',
                      width: 24,
                      height: 24,
                    ),
                    onPressed: () {
                      // TODO: Navigate to chat screen
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: const CameraPosition(
                    target: _center,
                    zoom: 11.0,
                  ),
                  markers: Set<Marker>.from(_markers),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  mapType: MapType.normal,
                  zoomControlsEnabled: true,
                ),
                Positioned(
                  top: 12,
                  left: 0,
                  right: 0,
                  child: Center(child: _buildToggleButtons()),
                ),
                Positioned(
                  left: 16,
                  bottom: 16,
                  child: FloatingActionButton(
                    onPressed: _locateMe,
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    child: const Icon(Icons.my_location,
                        color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

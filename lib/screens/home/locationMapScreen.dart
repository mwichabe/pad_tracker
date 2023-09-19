import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class LocationMapScreen extends StatefulWidget {
  final String text;
  const LocationMapScreen({Key? key, required this.text}) : super(key: key);

  @override
  _LocationMapScreenState createState() => _LocationMapScreenState();
}

class _LocationMapScreenState extends State<LocationMapScreen> {
  late Position _currentPosition;
  LatLng? _currentLatLng;
  final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    _currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    _currentLatLng = LatLng(_currentPosition.latitude, _currentPosition.longitude);
    setState(() {});
  }
  void _showSearchDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: TextField(
            maxLines: null,
            controller: _searchController,
            decoration:  InputDecoration(
              hintText: widget.text,
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Search'),
              onPressed: () async {
                String query = _searchController.text;
                List<Location> locations = await locationFromAddress(query);

                if (locations.isNotEmpty) {
                  // Get the first location result
                  Location location = locations.first;
                  _mapController.move(LatLng(location.latitude!, location.longitude!), 13.0);
                }

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Map'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              _showSearchDialog(context);
            },
          ),
        ],
      ),
      body: Center(
        child: FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            center: _currentLatLng,
            zoom: 13.0,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
            ),
            MarkerLayer(
              markers: _currentLatLng != null
                  ? [
                Marker(
                  width: 40.0,
                  height: 40.0,
                  point: _currentLatLng!,
                  builder: (ctx) => Container(
                    child: const Icon(Icons.location_on),
                  ),
                ),
              ]
                  : [], // Empty list if _currentLatLng is null
            ),
          ],

        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

//flutter map
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SelectableMarker extends StatefulWidget {
  final LatLng point;
  final String title;
  final ValueChanged<bool> onSelect;

  SelectableMarker(
      {required this.point, required this.title, required this.onSelect});

  @override
  _SelectableMarkerState createState() => _SelectableMarkerState();
}

class _SelectableMarkerState extends State<SelectableMarker> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = !selected;
        });
        widget.onSelect(selected);
      },
      child: Column(
        children: [
          Icon(
            selected
                ? Icons.radio_button_checked
                : Icons.radio_button_unchecked,
            color: selected ? Colors.red : Colors.grey,
            size: 30,
          ),
          Text(widget.title, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<LatLng> route = [];
  List<LatLng> selectedPoints = [];

  void updateRoute(LatLng startPoint, LatLng endPoint) async {
    String apiKey = '5b3ce3597851110001cf6248f5496acb537c452e94b02911a671de33';

    try {
      List<LatLng> newRoute = await fetchRoute(startPoint, endPoint, apiKey);
      setState(() {
        route = newRoute;
      });
    } catch (e) {
      print('Error fetching route: $e');
    }
  }

  Future<List<LatLng>> fetchRoute(
      LatLng startPoint, LatLng endPoint, String apiKey) async {
    String url =
        'https://api.openrouteservice.org/v2/directions/foot-walking?api_key=$apiKey&start=${startPoint.longitude},${startPoint.latitude}&end=${endPoint.longitude},${endPoint.latitude}';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> coordinates =
          jsonDecode(response.body)['features'][0]['geometry']['coordinates'];
      return coordinates
          .map<LatLng>((coords) => LatLng(coords[1], coords[0]))
          .toList();
    } else {
      throw Exception('Failed to fetch route');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: FlutterMap(
          options: MapOptions(
            center: LatLng(21.285032,
                74.844323), // Replace with the coordinates of your college
            zoom: 16.0,
            minZoom: 10.0,
            maxZoom: 18.0,
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
            ),
            PolylineLayerOptions(
              polylines: [
                Polyline(
                  points: route, // Use the 'route' variable here
                  strokeWidth: 4.0,
                  color: Colors.blue,
                ),
              ],
            ),
            MarkerLayerOptions(
              markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: LatLng(21.285032, 74.844323),
                  builder: (ctx) => SelectableMarker(
                    point: LatLng(21.285032, 74.844323),
                    title: 'Building A',
                    onSelect: (selected) {
                      setState(() {
                        selected
                            ? selectedPoints.add(LatLng(21.285032, 74.844323))
                            : selectedPoints
                                .remove(LatLng(21.285032, 74.844323));
                        if (selectedPoints.length == 2) {
                          updateRoute(selectedPoints[0], selectedPoints[1]);
                        }
                      });
                    },
                  ),
                ),
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: LatLng(21.284702, 74.842006),
                  builder: (ctx) => SelectableMarker(
                    point: LatLng(21.284702, 74.842006),
                    title: 'Building A',
                    onSelect: (selected) {
                      setState(() {
                        selected
                            ? selectedPoints.add(
                                LatLng(21.284702, 74.842006),
                              )
                            : selectedPoints.remove(
                                LatLng(21.284702, 74.842006),
                              );
                        if (selectedPoints.length == 2) {
                          updateRoute(selectedPoints[0], selectedPoints[1]);
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}

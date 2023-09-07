import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:search_map_place_updated/search_map_place_updated.dart';
class LocationWidget extends StatefulWidget {
  const LocationWidget({super.key});

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  bool loaded = false;
  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(_currentMapPosition.toString()),
        position: _currentMapPosition,

        infoWindow: InfoWindow(
          title: 'Donation Place',
        ),

        icon: BitmapDescriptor.defaultMarker,
      ));
      print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
      print(_currentMapPosition.latitude);
      print(_currentMapPosition.longitude);
    });

  }
  // Future<void> center(LatLng center) async {
  //
  //   List placemarks = await placemarkFromCoordinates(_center.latitude, _center.longitude);
  //   print(placemarks);
  //   Placemark place = placemarks[0];
  //   var Address = '${place.street}k, ${place.subLocality};, ${place.locality}, ${place.postalCode}, ${place.country}';
  //   print("000000000");
  //   addressTFController?.text=place.street! ;
  //   cityTFController?.text=place.locality!;
  //   print(Address);
  //   setState(()  {
  //   });
  //   double zoom = await mapController!.getZoomLevel();
  //   _changeLocation(zoom, LatLng(_center.latitude, _center.longitude));
  //
  // }
  Geolocation? geo;
  late GoogleMapController mapcontroller;
  static LatLng _center = const LatLng(31.936783, 35.874772);
  LatLng _currentMapPosition = _center;
  final Set<Marker> _markers = {};
  void _onCameraMove(CameraPosition position) {
    _currentMapPosition = position.target;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        loaded
            ? GoogleMap(
          onMapCreated: (GoogleMapController contoller) {
            setState(() {
              mapcontroller = contoller;
            });
          },
          initialCameraPosition:
          CameraPosition(zoom: 15, target: _center),
          mapType: MapType.normal,
          markers: _markers,
          onCameraMove: _onCameraMove,
        )
            : Container(),
        // SearchMapPlaceWidget(
        //
        //   bgColor: Colors.white70,
        //
        //
        //   iconColor: Colors.white,
        //   // placeholder: 'Select Store',
        //   placeType: PlaceType.address,
        //   hasClearButton: true,
        //   textColor: Colors.black,
        //   apiKey: 'AIzaSyC7OA_kF9duRuHHew__jN_HdYh8yq0BCtE',
        //   onSelected: (Place place) async {
        //     _onAddMarkerButtonPressed();
        //     geo = await place.geolocation;
        //     mapcontroller.animateCamera(
        //         CameraUpdate.newLatLng(geo?.coordinates));
        //     mapcontroller.animateCamera(
        //         CameraUpdate.newLatLngBounds(geo?.bounds, 0));
        //     _center = geo?.coordinates;
        //     print(_center);
        //     //center(_center);
        //     print("center");
        //
        //     //     donationLocation = place.description;
        //   },
        // ),

      ],
    );
  }
}

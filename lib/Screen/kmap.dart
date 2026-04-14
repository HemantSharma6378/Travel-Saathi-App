//
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class MapScreen extends StatefulWidget {
//   const MapScreen({super.key});
//
//   @override
//   State<MapScreen> createState() => _MapState();
// }
//
// class _MapState extends State<MapScreen> {
//
//   GoogleMapController? mapController;
//
//   LatLng myLocation =  const LatLng(26.9124, 75.7873);
//   LatLng travelerLocation = const LatLng(26.8128, 75.8412);
//
//   Set<Marker> markers = {};
//
//   bool showRequestCard = false;
//   bool requestAccepted = false;
//
//   LatLng? meetingPoint;
//
//   @override
//   void initState() {
//     super.initState();
//     getCurrentLocation();
//   }
//
//   // 📍 Get Current Location
//   Future<void> getCurrentLocation() async {
//
//     LocationPermission permission = await Geolocator.requestPermission();
//
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//
//     myLocation = LatLng(position.latitude, position.longitude);
//
//     loadMarkers();
//
//     setState(() {});
//
//     moveCameraTo10KM(); // ✅ Zoom fix
//   }
//
//   // 🎯 Show 10KM Area
//   void moveCameraTo10KM() {
//
//     if (mapController == null) return;
//
//     double lat = myLocation.latitude;
//     double lng = myLocation.longitude;
//
//     LatLng southwest = LatLng(lat - 0.09, lng - 0.09);
//     LatLng northeast = LatLng(lat + 0.09, lng + 0.09);
//
//     LatLngBounds bounds = LatLngBounds(
//       southwest: southwest,
//       northeast: northeast,
//     );
//
//     mapController!.animateCamera(
//       CameraUpdate.newLatLngBounds(bounds, 50),
//     );
//   }
//
//   // 📍 Load Markers
//   // void loadMarkers() {
//   //   markers = {
//   //
//   //     Marker(
//   //       markerId: const MarkerId("me"),
//   //       position: myLocation,
//   //       infoWindow: const InfoWindow(title: "You"),
//   //       icon: BitmapDescriptor.defaultMarkerWithHue(
//   //           BitmapDescriptor.hueBlue),
//   //     ),
//   //
//   //     Marker(
//   //       markerId: const MarkerId("traveler"),
//   //       position: travelerLocation,
//   //       infoWindow: const InfoWindow(title: "Rahul"),
//   //       icon: BitmapDescriptor.defaultMarkerWithHue(
//   //           BitmapDescriptor.hueOrange),
//   //       onTap: showTravelerProfile(name:"Rahul",number:"9656365214"),
//   //     ),
//   //   };
//   // }
//
//   void loadMarkers() {
//     markers = {
//
//       /// 🔵 MY LOCATION
//       Marker(
//         markerId: const MarkerId("me"),
//         position: myLocation,
//         infoWindow: const InfoWindow(title: "You"),
//         icon: BitmapDescriptor.defaultMarkerWithHue(
//             BitmapDescriptor.hueBlue),
//       ),
//
//       /// 🟠 TRAVELER 1
//       Marker(
//         markerId: const MarkerId("traveler1"),
//         position: travelerLocation,
//         infoWindow: const InfoWindow(title: "Rahul"),
//         icon: BitmapDescriptor.defaultMarkerWithHue(
//             BitmapDescriptor.hueOrange),
//         onTap: () => showTravelerProfile(
//           name: "Rahul",
//           number: "9656365214",
//           location: travelerLocation,
//         ),
//       ),
//
//       /// 🟠 TRAVELER 2
//       Marker(
//         markerId: const MarkerId("traveler2"),
//         position: LatLng(26.8224, 75.8662),
//         infoWindow: const InfoWindow(title: "Karan"),
//         icon: BitmapDescriptor.defaultMarkerWithHue(
//             BitmapDescriptor.hueOrange),
//         onTap: () => showTravelerProfile(
//           name: "Karan",
//           number: "6352634525",
//           location: LatLng(26.8224, 75.8662),
//         ),
//       ),
//     };
//   }
//   // 👤 Traveler Profile
//   // void showTravelerProfile() {
//   //   double distance = Geolocator.distanceBetween(
//   //       myLocation.latitude,
//   //       myLocation.longitude,
//   //       travelerLocation.latitude,
//   //       travelerLocation.longitude) / 1000;
//   //
//   //   showDialog(
//   //       context: context,
//   //       builder: (context) {
//   //         return AlertDialog(
//   //           title: const Text("Traveler"),
//   //           content: Column(
//   //             mainAxisSize: MainAxisSize.min,
//   //             children: [
//   //               Text("Name: Rahul"),
//   //               Text("Bike: Royal Enfield"),
//   //               Text("Phone: 6345145256"),
//   //               const SizedBox(height: 10),
//   //               Text("Distance: ${distance.toStringAsFixed(2)} KM"),
//   //             ],
//   //           ),
//   //           actions: [
//   //             ElevatedButton(
//   //               onPressed: () {
//   //                 Navigator.pop(context);
//   //                 setState(() {
//   //                   showRequestCard = true;
//   //                 });
//   //               },
//   //               child: const Text("Send Request"),
//   //             )
//   //           ],
//   //         );
//   //       });
//   // }
//   void showTravelerProfile({
//     required String name,
//     required String number,
//     required LatLng location, // 👈 NEW
//   }) {
//
//     double distance = Geolocator.distanceBetween(
//       myLocation.latitude,
//       myLocation.longitude,
//       location.latitude,
//       location.longitude,
//     ) / 1000;
//
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text("Traveler"),
//
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//
//               Text("👤 Name: $name"),
//               Text("🏍 Bike: Royal Enfield"),
//               Text("📞 Phone: $number"),
//
//               const SizedBox(height: 10),
//
//               Text(
//                 "📍 Distance: ${distance.toStringAsFixed(2)} KM",
//                 style: const TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text("Close"),
//             ),
//
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(context);
//                 setState(() {
//                   showRequestCard = true;
//                 });
//               },
//               child: const Text("Send Request"),
//             )
//           ],
//         );
//       },
//     );
//   }
//   void rejectRequest() {
//     setState(() {
//       showRequestCard = false;
//       requestAccepted = false;
//     });
//
//     // 👇 Yaha daalo message
//     // ScaffoldMessenger.of(context).showSnackBar(
//     //   const SnackBar(content: Text("Request Rejected")),
//     // );
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: const Text("Request Rejected"),
//         backgroundColor: Colors.red,
//         duration: const Duration(seconds: 2),
//       ),
//     );
//   }
//   // ✅ Accept Request
//   void acceptRequest() {
//
//     double midLat =
//         (myLocation.latitude + travelerLocation.latitude) / 2;
//
//     double midLng =
//         (myLocation.longitude + travelerLocation.longitude) / 2;
//
//     meetingPoint = LatLng(midLat, midLng);
//
//     setState(() {
//       requestAccepted = true;
//
//       markers = Set.from(markers)..add(
//         Marker(
//           markerId: const MarkerId("meeting"),
//           position: meetingPoint!,
//           icon: BitmapDescriptor.defaultMarkerWithHue(
//               BitmapDescriptor.hueGreen),
//           infoWindow: const InfoWindow(title: "Meeting Point"),
//         ),
//       );
//     });
//   }
//
//   // 🗺 Open Google Maps
//   Future<void> openGoogleMaps() async {
//
//     if (meetingPoint == null) return;
//
//     final Uri url = Uri.parse(
//         "https://www.google.com/maps/dir/?api=1"
//             "&origin=${myLocation.latitude},${myLocation.longitude}"
//             "&destination=${meetingPoint!.latitude},${meetingPoint!.longitude}"
//             "&travelmode=driving"
//     );
//
//     if (await canLaunchUrl(url)) {
//       await launchUrl(url, mode: LaunchMode.externalApplication);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//
//       appBar: AppBar(
//         title: const Text("Travel Saathi"),
//       ),
//
//       body: Stack(
//         children: [
//
//           // 🗺 MAP
//           GoogleMap(
//             initialCameraPosition: CameraPosition(
//               target: myLocation,
//               zoom: 5,
//             ),
//             markers: markers,
//             myLocationEnabled: true,
//             onMapCreated: (controller) {
//               mapController = controller;
//               moveCameraTo10KM();
//             },
//           ),
//
//           // 🔵 Request Card
//           if (showRequestCard && !requestAccepted)
//             Positioned(
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: requestCard(),
//             ),
//
//           // 🟢 Meeting Card
//           if (requestAccepted)
//             Positioned(
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: moveToMeetingCard(),
//             ),
//         ],
//       ),
//     );
//   }
//
//   // 🔵 Request Card UI
//   Widget requestCard() {
//     return Container(
//       height: 160,
//       padding: const EdgeInsets.all(12),
//       decoration: const BoxDecoration(
//         color: Colors.blueAccent,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//       ),
//       child: Row(
//         children: [
//
//           const Expanded(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text("Rahul Sharma",
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold)),
//                 SizedBox(height: 6),
//                 Text("Vehicle: Royal Enfield",
//                     style: TextStyle(color: Colors.white)),
//               ],
//             ),
//           ),
//
//           // 🔴 Reject Button
//           ElevatedButton(
//             onPressed: rejectRequest,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.red,
//             ),
//             child: const Text("Reject"),
//           ),
//
//           const SizedBox(width: 10),
//
//           // 🟢 Accept Button
//           ElevatedButton(
//             onPressed: acceptRequest,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.green,
//             ),
//             child: const Text("Accept"),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // 🟢 Meeting Card UI
//   Widget moveToMeetingCard() {
//     return Container(
//       height: 160,
//       padding: const EdgeInsets.all(16),
//       decoration: const BoxDecoration(
//         color: Colors.green,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//
//           const Text(
//             "Meeting Point Ready",
//             style: TextStyle(color: Colors.white, fontSize: 18),
//           ),
//
//           const SizedBox(height: 12),
//
//           ElevatedButton.icon(
//             onPressed: openGoogleMaps,
//             icon: const Icon(Icons.navigation),
//             label: const Text("Move to Meeting Point"),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapState();
}

class _MapState extends State<MapScreen> {

  GoogleMapController? mapController;

  LatLng myLocation = const LatLng(26.9124, 75.7873);

  Set<Marker> markers = {};

  bool showRequestCard = false;
  bool requestAccepted = false;

  LatLng? meetingPoint;

  /// ✅ Selected Traveler Data
  String selectedName = "";
  String selectedPhone = "";
  LatLng? selectedLocation;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  /// 📍 Get Current Location
  Future<void> getCurrentLocation() async {
    await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    myLocation = LatLng(position.latitude, position.longitude);

    loadMarkers();

    setState(() {});

    moveCameraTo10KM();
  }

  /// 🎯 Zoom 10KM
  void moveCameraTo10KM() {
    if (mapController == null) return;

    double lat = myLocation.latitude;
    double lng = myLocation.longitude;

    LatLngBounds bounds = LatLngBounds(
      southwest: LatLng(lat - 0.09, lng - 0.09),
      northeast: LatLng(lat + 0.09, lng + 0.09),
    );

    mapController!.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, 50),
    );
  }

  /// 📍 Load Markers
  void loadMarkers() {
    markers = {

      /// 🔵 My Location
      Marker(
        markerId: const MarkerId("me"),
        position: myLocation,
        infoWindow: const InfoWindow(title: "You"),
        icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueBlue),
      ),

      /// 🟠 Rahul
      Marker(
        markerId: const MarkerId("t1"),
        position: const LatLng(26.8128, 75.8412),
        infoWindow: const InfoWindow(title: "Rahul"),
        icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueOrange),
        onTap: () => showTravelerProfile(
          name: "Rahul",
          number: "9656365214",
          location: const LatLng(26.8128, 75.8412),
        ),
      ),

      /// 🟠 Karan
      Marker(
        markerId: const MarkerId("t2"),
        position: const LatLng(26.8224, 75.8662),
        infoWindow: const InfoWindow(title: "Karan"),
        icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueOrange),
        onTap: () => showTravelerProfile(
          name: "Karan",
          number: "6352634525",
          location: const LatLng(26.8224, 75.8662),
        ),
      ),
    };
  }

  /// 👤 Traveler Profile
  void showTravelerProfile({
    required String name,
    required String number,
    required LatLng location,
  }) {

    double distance = Geolocator.distanceBetween(
      myLocation.latitude,
      myLocation.longitude,
      location.latitude,
      location.longitude,
    ) / 1000;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Traveler"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("👤 Name: $name"),
              Text("🏍 Bike: Royal Enfield"),
              Text("📞 Phone: $number"),
              const SizedBox(height: 10),
              Text(
                "📍 Distance: ${distance.toStringAsFixed(2)} KM",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);

                setState(() {
                  showRequestCard = true;
                  selectedName = name;
                  selectedPhone = number;
                  selectedLocation = location;
                  requestAccepted = false;
                });
              },
              child: const Text("Send Request"),
            )
          ],
        );
      },
    );
  }

  /// ❌ Reject
  void rejectRequest() {
    setState(() {
      showRequestCard = false;
      requestAccepted = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Request Rejected"),
        backgroundColor: Colors.red,
      ),
    );
  }

  /// ✅ Accept
  void acceptRequest() {

    if (selectedLocation == null) return;

    double midLat =
        (myLocation.latitude + selectedLocation!.latitude) / 2;

    double midLng =
        (myLocation.longitude + selectedLocation!.longitude) / 2;

    meetingPoint = LatLng(midLat, midLng);

    setState(() {
      requestAccepted = true;

      markers = Set.from(markers)..add(
        Marker(
          markerId: const MarkerId("meeting"),
          position: meetingPoint!,
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueGreen),
          infoWindow: InfoWindow(
            title: "Meeting with $selectedName",
          ),
        ),
      );
    });
  }

  /// 🗺 Open Google Maps
  Future<void> openGoogleMaps() async {

    if (meetingPoint == null) return;

    final Uri url = Uri.parse(
        "https://www.google.com/maps/dir/?api=1"
            "&origin=${myLocation.latitude},${myLocation.longitude}"
            "&destination=${meetingPoint!.latitude},${meetingPoint!.longitude}"
            "&travelmode=driving"
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Travel Saathi")),

      body: Stack(
        children: [

          /// 🗺 MAP
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: myLocation,
              zoom: 5,
            ),
            markers: markers,
            myLocationEnabled: true,
            onMapCreated: (controller) {
              mapController = controller;
              moveCameraTo10KM();
            },
          ),

          /// 🔵 Request Card
          if (showRequestCard && !requestAccepted)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: requestCard(),
            ),

          /// 🟢 Meeting Card
          if (requestAccepted)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: moveToMeetingCard(),
            ),
        ],
      ),
    );
  }

  /// 🔵 Request Card
  Widget requestCard() {
    return Container(
      height: 160,
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        children: [

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(selectedName,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                const Text("Vehicle: Royal Enfield",
                    style: TextStyle(color: Colors.white)),
              ],
            ),
          ),

          ElevatedButton(
            onPressed: rejectRequest,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("Reject"),
          ),

          const SizedBox(width: 10),

          ElevatedButton(
            onPressed: acceptRequest,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text("Accept"),
          ),
        ],
      ),
    );
  }

  /// 🟢 Meeting Card
  Widget moveToMeetingCard() {
    return Container(
      height: 160,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          const Text(
            "Meeting Point Ready",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),

          const SizedBox(height: 12),

          ElevatedButton.icon(
            onPressed: openGoogleMaps,
            icon: const Icon(Icons.navigation),
            label: const Text("Move to Meeting Point"),
          ),
        ],
      ),
    );
  }
}
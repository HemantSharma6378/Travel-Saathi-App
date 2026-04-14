
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BookingHistoryScreen extends StatefulWidget {
  @override
  State<BookingHistoryScreen> createState() => _BookingHistoryScreenState();
}

class _BookingHistoryScreenState extends State<BookingHistoryScreen>
    with SingleTickerProviderStateMixin {

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  String formatDate(DateTime d) {
    return "${d.day}/${d.month}/${d.year}";
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        body: Center(child: Text("Please login first")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("My Bookings"),
        backgroundColor: Colors.deepPurple,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: "Hotel"),
            Tab(text: "Vehicle"),
            Tab(text: "Places"),
          ],

        ),
      ),

      body: TabBarView(
        controller: _tabController,
        children: [
          buildHotelBookings(user.email!),
          buildVehicleBookings(user.email!),
          buildPlaceBookings(user.email!),
        ],
      ),
    );
  }

  // ================= HOTEL =================
  Widget buildHotelBookings(String email) {
    return buildStream(
      collection: "hotelBookings",
      email: email,
      builder: (data) => buildCard(
        title: data["hotelName"] ?? "Hotel",
        total: getTotal(data["total"]),
        subtitle:
        "Rooms: ${data["rooms"] ?? 0} • Days: ${data["days"] ?? 0}",
        startDate: data["checkIn"],
        endDate: data["checkOut"],
        userName: data["userName"],
        status: "Confirmed",
      ),
    );
  }

  // ================= VEHICLE =================
  Widget buildVehicleBookings(String email) {
    return buildStream(
      collection: "vehicleBookings",
      email: email,
      builder: (data) => buildCard(
        title: data["vehicleName"] ?? "Vehicle",
        total: getTotal(data["total"]),
        subtitle: "Days: ${data["days"] ?? 0}",
        startDate: data["startDate"],
        endDate: data["endDate"],
        userName: data["userName"],
        status: data["status"] ?? "Confirmed",
      ),
    );
  }

  // ================= PLACE =================
  Widget buildPlaceBookings(String email) {
    return buildStream(
      collection: "placeBookings",
      email: email,
      builder: (data) {
        List members = data["members"] ?? [];
        List places = data["places"] ?? [];

        String placeNames = places
            .map((p) => p["name"])
            .join(", ");
        String memberNames = members
            .map((m) => m["name"])
            .join(", ");

        return buildCard(
          title: "Travel Booking",
          total: getTotal(data["total"]),
          subtitle: "Places: $placeNames\nMembers: ${members.length}",
          startDate: data["date"],
          memberNames: memberNames,
          status: "Confirmed",
        );
      },
    );
  }

  // ================= COMMON STREAM =================
  Widget buildStream({
    required String collection,
    required String email,
    required Widget Function(Map<String, dynamic>) builder,
  }) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(collection)
          .where("userEmail", isEqualTo: email)
          .snapshots(),
      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text("No Data Found"));
        }

        var docs = snapshot.data!.docs;

        return ListView.builder(
          itemCount: docs.length,
          itemBuilder: (context, index) {
            var data = docs[index].data() as Map<String, dynamic>;
            return builder(data);
          },
        );
      },
    );
  }

  // ================= COMMON CARD =================
  Widget buildCard({
    required String title,
    required num total,
    required String subtitle,
    required dynamic startDate,
    dynamic endDate,
    String? userName,
    String? memberNames,
    String status = "Confirmed",
  }) {
    DateTime? start =
    startDate != null ? (startDate as Timestamp).toDate() : null;

    DateTime? end =
    endDate != null ? (endDate as Timestamp).toDate() : null;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// TITLE + PRICE
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              Text("₹$total",
                  style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold)),
            ],
          ),

          SizedBox(height: 6),

          /// USER NAME
          if (userName != null)
            Text("👤 $userName",
                style: TextStyle(fontWeight: FontWeight.w500)),

          /// MEMBERS
          if (memberNames != null)
            Text("👥 $memberNames",
                style: TextStyle(fontWeight: FontWeight.w500)),

          SizedBox(height: 6),

          /// DETAILS
          Text(subtitle),

          SizedBox(height: 6),

          /// DATE
          if (start != null && end != null)
            Text("📅 ${formatDate(start)} → ${formatDate(end)}")
          else if (start != null)
            Text("📅 ${formatDate(start)}"),

          SizedBox(height: 6),

          /// STATUS
          Row(
            children: [
              Icon(Icons.check_circle,
                  color: Colors.green, size: 18),
              SizedBox(width: 5),
              Text(status,
                  style: TextStyle(color: Colors.green)),
            ],
          )
        ],
      ),
    );
  }

  // ================= HELPER =================
  int getTotal(dynamic total) {
    if (total is int) return total;
    if (total is double) return total.toInt();
    return 0;
  }
}
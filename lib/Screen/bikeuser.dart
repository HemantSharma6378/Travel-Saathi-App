import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../statestravel/PaymentScreen.dart';

class Vehicle {
  final String name;
  final String type;
  final double price;
  final String image;

  Vehicle(this.name, this.type, this.price, this.image);
}

// // 🚗 Vehicle List
List<Vehicle> vehicles = [
  Vehicle(
    "Royal Enfield Classic 350",
    "Bike",
    800,
    "https://cdn-s3.autocarindia.com/RoyalEnfield/Classic-350/_DSF2307.JPG?w=728&q=75",
  ),
  Vehicle("Hero Splendor", "Bike", 400, "https://auto.hindustantimes.com/cms-images/hero_splendorplus/images/exterior_hero-splendor-plus-xtec_front-left-view_600x400.jpg"),
  Vehicle("Bajaj Pulsar 220", "Bike", 650, "https://www.carandbike.com/_next/image?url=https%3A%2F%2Fimages.carandbike.com%2Fbike-images%2Fgallery%2Fbajaj%2Fpulsar-220%2Fexterior%2F14.jpg%3Fv%3D1765885709&w=640&q=90"),
  Vehicle("Honda Activa 6G", "Bike", 400,"https://media.zigcdn.com/media/model/2024/Mar/front-left-view-2062556714_930x620.jpg"),


  Vehicle("TVS Apache RTR", "Bike", 600, "https://imgd.aeplcdn.com/1280x720/n/cw/ec/97549/right-front-three-quarter.jpeg"),
  Vehicle("Swift", "Car", 1500, "https://cdn-s3.autocarindia.com/legacy/cdni/mmv_images/colors/20250704042224_Maruti_Suzuki_Swift_Pearl_Arctic_White_with_Bluish_Black_Roof[1].jpg?w=1200"),
  Vehicle("Hyundai i20", "Car", 1600, "https://www.abrbuzz.co.za/images/2024/july/hyundai-1800i20NLine_FRONT_01.jpg"),
  Vehicle("Baleno", "Car", 1700, "https://auto.hindustantimes.com/cms-images/marutisuzuki_baleno/images/exterior_marutisuzuki-baleno-facelift_front-right-view_1150x648.jpeg"),
  Vehicle("Honda City", "Car", 2000, "https://etimg.etb2bimg.com/thumb/msid-98359212,width-1200,height-900,resizemode-4/.jpg"),
  Vehicle("Creta", "Car", 2200, "https://www.team-bhp.com/sites/default/files/styles/amp_high_res/public/2024_hyundai_creta_facelift_exterior_01_0.jpg"),
  Vehicle("Toyota Innova", "Car", 2800, "https://auto.hindustantimes.com/cms-images/toyota_innovacrysta/images/exterior_toyata-innova-crysta_front-left-side_1160x642.jpeg"),
  // Vehicle("Tata Nexon", "Car", 1800, "https://akm-img-a-in.tosshub.com/businesstoday/images/story/202309/ezgif-sixteen_nine_105.jpg"),
  Vehicle("Ford EcoSport", "Car", 1900, "https://s1.cdn.autoevolution.com/images/news/2026-ford-ecosport-digitally-returns-to-the-americas-to-battle-corolla-cross-and-hr-v-243787_1.jpg"),
  // Vehicle("Kia Seltos", "Car", 2100, "https://www.kia.com/content/dam/kia2/in/en/our-vehicles/new-seltos/seltos_d_1.jpg"),
  Vehicle("Force Traveller", "Caravan", 3000, "https://buscdn.cardekho.com/in/force/traveller-wider-body/force-traveller-wider-body-63641.jpg?imwidth=480&impolicy=resize"),
  Vehicle("Tempo Traveller 12 Seater", "Caravan", 3200, "https://shelketravels.com/wp-content/uploads/2024/01/WhatsApp-Image-2024-01-04-at-11.19.48-PM-1-1-1024x768.jpeg"),
  Vehicle("Luxury Caravan Van", "Caravan", 5000, "https://jcbl.com/jcbl-images/products/caravan/caravan9m-1.jpg"),
  Vehicle("Mini Camper Van", "Caravan", 3500, "https://www.practicalmotorhome.com/wp-content/uploads/2023/10/PMH278.awards_budget_small_luxury_campervans.1695655605561.jpg"),
  Vehicle("Family Caravan", "Caravan", 4000, "https://static.vecteezy.com/system/resources/previews/029/633/507/large_2x/family-vacation-travel-rv-holiday-trip-in-motorhome-caravan-car-vacation-beautiful-nature-norway-natural-landscape-free-photo.jpeg"),
  Vehicle("Offroad Camper", "Caravan", 4500, "https://lh5.googleusercontent.com/JQ8TAiGcTiGK9LAG8-M5TKcPOsK8YLFhJToY2yWkdPd6V3qvpD3X_dcgJD7aghqrlzsa9el5LyFMQcbTWzYobVzBVADtDHmHl4KpcAaxgYXmaKc-tXRWkr8arAwdILOh09TldnMt"),

  Vehicle("Mahindra Thar", "Car", 2500, "https://images.indianexpress.com/2020/10/mahindra-thar-red-1200.jpg"),
];

class VehicleListScreen extends StatelessWidget {

  Map<String, List<Vehicle>> groupVehicles() {
    Map<String, List<Vehicle>> grouped = {
      "Bike": [],
      "Car": [],
      "Caravan": [],
    };

    for (var v in vehicles) {
      if (grouped.containsKey(v.type)) {
        grouped[v.type]!.add(v);
      }
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context) {

    final grouped = groupVehicles();

    return Scaffold(
      backgroundColor: Color(0xFFF5F6FA),

      appBar: AppBar(
        title: Text("Vehicle Rental"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),

      body: ListView(
        padding: EdgeInsets.all(10),
        children: [

          if (grouped["Bike"]!.isNotEmpty) ...[
            sectionTitle("Bikes 🚲"),
            ...grouped["Bike"]!.map((v) => vehicleCard(context, v)),
          ],

          if (grouped["Car"]!.isNotEmpty) ...[
            sectionTitle("Cars 🚗"),
            ...grouped["Car"]!.map((v) => vehicleCard(context, v)),
          ],

          if (grouped["Caravan"]!.isNotEmpty) ...[
            sectionTitle("Caravan 🚐"),
            ...grouped["Caravan"]!.map((v) => vehicleCard(context, v)),
          ],
        ],
      ),
    );
  }

  // 🔥 Modern Section Title
  Widget sectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 6),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: Colors.black87,
        ),
      ),
    );
  }

  // 🔥 Modern Card
  Widget vehicleCard(BuildContext context, Vehicle v) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          )
        ],
      ),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [

            // Image
            Image.network(
              v.image,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),

            // Gradient Overlay
            Container(
              height: 180,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),

            // Content
            Positioned(
              bottom: 15,
              left: 15,
              right: 15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        v.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        v.type,
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),

                  // Price badge
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "₹${v.price}/day",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Tap Effect
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            VehicleBookingForm(vehicle: v),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ================= BOOKING FORM =================
class VehicleBookingForm extends StatefulWidget {
  final Vehicle vehicle;

  VehicleBookingForm({required this.vehicle});

  @override
  State<VehicleBookingForm> createState() =>
      _VehicleBookingFormState();
}

class _VehicleBookingFormState extends State<VehicleBookingForm> {

  DateTime? startDate;
  DateTime? endDate;

  final name = TextEditingController();
  final phoneController = TextEditingController();
  final licenceController = TextEditingController();

  final user = FirebaseAuth.instance.currentUser;

  @override
  void dispose() {
    name.dispose();
    phoneController.dispose();
    licenceController.dispose();
    super.dispose();
  }

  // ✅ DATE PICKER WITH PROPER LOGIC
  Future<void> pickDate(bool isStart) async {

    DateTime now = DateTime.now();
    DateTime firstDate;

    if (isStart) {
      firstDate = now;
    } else {
      if (startDate == null) {
        showMsg("Please select start date first");
        return;
      }
      firstDate = startDate!.add(Duration(days: 1));
    }

    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: firstDate,
      firstDate: firstDate,
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {

        if (isStart) {
          startDate = picked;

          // Reset end date if invalid
          if (endDate != null &&
              endDate!.isBefore(startDate!.add(Duration(days: 1)))) {
            endDate = null;
          }

        } else {
          endDate = picked;
        }
      });
    }
  }

  String format(DateTime? d) {
    if (d == null) return "Select Date";
    return "${d.day}/${d.month}/${d.year}";
  }

  void showMsg(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }

  int getDays() {
    if (startDate == null || endDate == null) return 0;
    int days = endDate!.difference(startDate!).inDays;
    return days <= 0 ? 1 : days;
  }

  @override
  Widget build(BuildContext context) {

    if (user == null) {
      return Scaffold(
        body: Center(child: Text("Please login first")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.vehicle.name),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [

              // 🚗 Vehicle Card
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 5,
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      widget.vehicle.image,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          Icon(Icons.directions_car),
                    ),
                  ),
                  title: Text(widget.vehicle.name,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(widget.vehicle.type),
                  trailing: Text("₹${widget.vehicle.price}/day"),
                ),
              ),

              SizedBox(height: 15),

              // 👤 USER DETAILS
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 6,
                child: Padding(
                  padding: EdgeInsets.all(18),
                  child: Column(
                    children: [

                      TextField(
                        controller: name,
                        decoration: InputDecoration(
                          labelText: "Full Name",
                          prefixIcon: Icon(Icons.person),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(12),
                              borderSide: BorderSide.none),
                        ),
                      ),

                      SizedBox(height: 12),

                      TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        decoration: InputDecoration(
                          labelText: "Phone Number",
                          hintText: "10 digits only",
                          prefixIcon: Icon(Icons.phone),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(12),
                              borderSide: BorderSide.none),
                        ),
                      ),

                      SizedBox(height: 12),

                      TextField(
                        controller: licenceController,
                        textCapitalization:
                        TextCapitalization.characters,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(16),
                        ],
                        decoration: InputDecoration(
                          labelText: "Driving Licence",
                          hintText: "RJ14XXXXXXXXXX",
                          prefixIcon: Icon(Icons.badge),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(12),
                              borderSide: BorderSide.none),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 15),

              // 📅 Date Card
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [

                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => pickDate(true),
                              child: Text(format(startDate)),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => pickDate(false),
                              child: Text(format(endDate)),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 10),

                      if (getDays() > 0)
                        Text(
                          "Duration: ${getDays()} days",
                          style: TextStyle(color: Colors.green),
                        ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),

              // 🚀 Continue Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: EdgeInsets.all(15),
                  ),
                  onPressed: () async {

                    if (name.text.isEmpty ||
                        phoneController.text.isEmpty ||
                        licenceController.text.isEmpty ||
                        startDate == null ||
                        endDate == null) {
                      showMsg("Please fill all details");
                      return;
                    }

                    if (!RegExp(r'^[6-9]\d{9}$')
                        .hasMatch(phoneController.text)) {
                      showMsg("Enter a valid phone number");
                      return;
                    }

                    if (licenceController.text.length < 10) {
                      showMsg("Enter a valid licence number");
                      return;
                    }

                    if (endDate!.isBefore(startDate!.add(Duration(days: 1)))) {
                      showMsg("End date must be after start date");
                      return;
                    }

                    int days =
                        endDate!.difference(startDate!).inDays;
                    if (days <= 0) days = 1;

                    double total =
                        days * widget.vehicle.price;

                    try {
                      // await FirebaseFirestore.instance
                      //     .collection("bookings")
                      //     .add({
                      //   "vehicleName": widget.vehicle.name,
                      //   "userName": name.text,
                      //   "phone": phoneController.text,
                      //   "licence": licenceController.text,
                      //   "userId": user!.uid,
                      //   "userEmail": user!.email,
                      //   "startDate": Timestamp.fromDate(startDate!),
                      //   "endDate": Timestamp.fromDate(endDate!),
                      //   "days": days,
                      //   "total": total,
                      //   "type": "vehicle",
                      //   "status": "confirmed",
                      //
                      // });

                      await FirebaseFirestore.instance
                          .collection("vehicleBookings")
                          .add({
                        "vehicleName": widget.vehicle.name,
                        "userName": name.text,
                        "phone": phoneController.text,
                        "licence": licenceController.text,
                        "userId": user!.uid,
                        "userEmail": user!.email,
                        "startDate": Timestamp.fromDate(startDate!),
                        "endDate": Timestamp.fromDate(endDate!),
                        "days": days,
                        "total": total,
                        "status": "confirmed",

                      });

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => VehicleSummaryScreen(
                            vehicle: widget.vehicle,
                            total: total,
                            days: days,
                            name: name.text,
                          ),
                        ),
                      );

                    } catch (e) {
                      showMsg("Booking failed, please try again");
                    }
                  },
                  child: Text("Continue",style: TextStyle(color:Colors.white70),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ================= SUMMARY =================
class VehicleSummaryScreen extends StatelessWidget {
  final Vehicle vehicle;
  final double total;
  final int days;
  final String name;

  VehicleSummaryScreen({
    required this.vehicle,
    required this.total,
    required this.days,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Summary"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [

            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Text(vehicle.name,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text("Days: $days"),
                    Text("Total: ₹$total"),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: EdgeInsets.all(15),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          PaymentScreen(Rupies: total.toString()),
                    ),
                  );
                },
                child: Text("Pay Now",style: TextStyle(color:Colors.white70),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
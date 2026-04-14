
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travel_saathi/statestravel/PaymentScreen.dart';


class Hotel {
  final String name;
  final String location;
  final double price;
  final double rating;
  final String image;

  Hotel(this.name, this.location, this.price, this.rating, this.image);
}

List<Hotel> hotels = [
  Hotel(
    "Ocean View Resort",
    "Goa",
    1800,
    4.5,
    "https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=800&q=80",
  ),
  Hotel(
    "Mountain Paradise",
    "Manali",
    1500,
    4.2,
    "https://images.unsplash.com/photo-1582719508461-905c673771fd?auto=format&fit=crop&w=800&q=80",
  ),
  Hotel(
    "City Light Hotel",
    "Delhi",
    1200,
    4.0,
    "https://images.unsplash.com/photo-1551882547-ff40c63fe5fa?auto=format&fit=crop&w=800&q=80",
  ),
];

class RoomsScreen extends StatefulWidget {
  State<RoomsScreen> createState() {
    return RoomsState();
  }
}

class RoomsState extends State<RoomsScreen> {
  RangeValues priceRange = RangeValues(500, 3000);
  String searchQuery = "";



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Travel Saathi ✈️"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
              decoration: InputDecoration(
                hintText: "Search location...",
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                Text("Filter by Price"),
                RangeSlider(
                  values: priceRange,
                  min: 500,
                  max: 5000,
                  divisions: 10,
                  labels: RangeLabels(
                    priceRange.start.round().toString(),
                    priceRange.end.round().toString(),
                  ),
                  onChanged: (values) {
                    setState(() {
                      priceRange = values;
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: hotels.length,
              itemBuilder: (context, index) {
                final hotel = hotels[index];

                if (hotel.price >= priceRange.start &&
                    hotel.price <= priceRange.end &&
                    hotel.location.toLowerCase().contains(searchQuery)) {
                  return HotelCard(hotel: hotel);
                }

                return SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class HotelCard extends StatelessWidget {
  final Hotel hotel;

  HotelCard({required this.hotel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HotelDetailScreen(hotel: hotel),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.all(12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 6,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              child: SafeNetworkImage(url: hotel.image, height: 200),
            ),
            ListTile(
              title: Text(
                hotel.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle:
              Text("${hotel.location} • ⭐ ${hotel.rating}"),
              trailing: Text(
                "₹${hotel.price}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HotelDetailScreen extends StatelessWidget {
  final Hotel hotel;

  HotelDetailScreen({required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hotel.name),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView(
        children: [
          SafeNetworkImage(url: hotel.image, height: 250),
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              hotel.name,
              style:
              TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          GallerySection(),
          Padding(
            padding: EdgeInsets.all(16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Colors.deepPurple,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        BookingFormScreen(hotel: hotel),
                  ),
                );
              },
              child: Text("Book Now",style:TextStyle(color:Colors.white),),
            ),
          ),
        ],
      ),
    );
  }
}

class GallerySection extends StatelessWidget {
  final List<String> images = [
    "https://images.unsplash.com/photo-1618773928121-c32242e63f39?auto=format&fit=crop&w=800&q=80",
    "https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=800&q=80",
    "https://images.unsplash.com/photo-1590490360182-c33d57733427?auto=format&fit=crop&w=800&q=80",
    "https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?auto=format&fit=crop&w=800&q=80",
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child:
              SafeNetworkImage(url: images[index], height: 120, width: 150),
            ),
          );
        },
      ),
    );
  }
}

class BookingSummaryScreen extends StatelessWidget {
  final Hotel hotel;
  final double total;
  final String name;
  final int rooms;
  final int days;
  final DateTime checkIn;
  final DateTime checkOut;

  BookingSummaryScreen({
    required this.hotel,
    required this.total,
    required this.name,
    required this.rooms,
    required this.days,
    required this.checkIn,
    required this.checkOut
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(hotel.name,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      Text("Location: ${hotel.location}"),
                      Text("Rating: ⭐ ${hotel.rating}"),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),

              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Guest Details",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      Text("Name: $name"),
                      Text("Rooms: $rooms"),
                      Text("Days: $days"),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),

              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Price Details",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      Text("Price per Night: ₹${hotel.price}"),
                      Text("Rooms × Days: ₹${hotel.price} × $rooms × $days"),
                      Text("Service Fee: ₹200"),
                      Divider(),
                      Text("Total: ₹$total",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width:double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () async {

                    String? userEmail = FirebaseAuth.instance.currentUser?.email;
                    await FirebaseFirestore.instance.collection("hotelBookings").add({
                      "hotelName": hotel.name,
                      "userName": name,
                      "rooms": rooms,
                      "days": days,
                      "total": total,
                      "checkIn": Timestamp.fromDate(checkIn),
                      "checkOut": Timestamp.fromDate(checkOut),
                      "userEmail": userEmail,


                    });
                    Navigator.pushReplacement(context,MaterialPageRoute(builder:(context){
                      return PaymentScreen(Rupies:total.toString());
                    }));
                  },
                  child: Center(child: Text("Pay Now",style:TextStyle(fontSize: 16,fontWeight:FontWeight.bold),)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SafeNetworkImage extends StatelessWidget {
  final String url;
  final double height;
  final double? width;

  SafeNetworkImage({
    required this.url,
    required this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      height: height,
      width: width ?? double.infinity,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Container(
          height: height,
          width: width ?? double.infinity,
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Container(
          height: height,
          width: width ?? double.infinity,
          color: Colors.grey[300],
          child: Icon(Icons.broken_image, size: 50),
        );
      },
    );
  }
}

class BookingFormScreen extends StatefulWidget {
  final Hotel hotel;

  BookingFormScreen({required this.hotel});

  @override
  _BookingFormScreenState createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {
  DateTime? checkIn;
  DateTime? checkOut;
  int rooms = 1;

  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();

  // ✅ Dispose (memory leak fix)
  @override
  void dispose() {
    name.dispose();
    phone.dispose();
    super.dispose();
  }

  // ✅ Improved Date Picker
  Future<void> pickDate(bool isCheckIn) async {
    DateTime now = DateTime.now();
    DateTime firstDate;

    if (isCheckIn) {
      firstDate = now;
    } else {
      if (checkIn == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please select Check-in first")),
        );
        return;
      }
      firstDate = checkIn!.add(Duration(days: 1));
    }

    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: firstDate,
      firstDate: firstDate,
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        if (isCheckIn) {
          checkIn = picked;

          // reset checkout if invalid
          if (checkOut != null && checkOut!.isBefore(checkIn!)) {
            checkOut = null;
          }
        } else {
          checkOut = picked;
        }
      });
    }
  }

  String formatDate(DateTime? date) {
    if (date == null) return "Select Date";
    return "${date.day}/${date.month}/${date.year}";
  }

  int getDays() {
    if (checkIn == null || checkOut == null) return 0;
    int days = checkOut!.difference(checkIn!).inDays;
    return days <= 0 ? 1 : days;
  }

  double getTotal() {
    int days = getDays();
    return widget.hotel.price * rooms * days + 200;
  }

  @override
  Widget build(BuildContext context) {
    int days = getDays();
    double total = getTotal();

    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Details"),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [

              // 🏨 Hotel Card
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 5,
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(widget.hotel.image,
                        width: 60, height: 60, fit: BoxFit.cover),
                  ),
                  title: Text(widget.hotel.name,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(widget.hotel.location),
                  trailing: Text("₹${widget.hotel.price}",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),

              SizedBox(height: 15),

              // 👤 Guest Details
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
                          Icon(Icons.person, color: Colors.deepPurple),
                          SizedBox(width: 8),
                          Text("Guest Details",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: name,
                        decoration: InputDecoration(
                          labelText: "Guest Name",
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: phone,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          labelText: "Phone Number",
                          prefixIcon: Icon(Icons.phone),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          counterText: "",
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 15),

              // 📅 Date Selection
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
                          Icon(Icons.calendar_today,
                              color: Colors.deepPurple),
                          SizedBox(width: 8),
                          Text("Select Dates",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(height: 10),

                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => pickDate(true),
                              child: Text(formatDate(checkIn)),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => pickDate(false),
                              child: Text(formatDate(checkOut)),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 10),

                      // ✅ Show Days
                      if (days > 0)
                        Text("Stay: $days days",
                            style: TextStyle(color: Colors.green)),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 15),

              // 🛏️ Room Selection
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.hotel,
                              color: Colors.deepPurple),
                          SizedBox(width: 8),
                          Text("Rooms",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              if (rooms > 1) setState(() => rooms--);
                            },
                            icon: Icon(Icons.remove_circle),
                          ),
                          Text("$rooms",
                              style: TextStyle(fontSize: 16)),
                          IconButton(
                            onPressed: () {
                              setState(() => rooms++);
                            },
                            icon: Icon(Icons.add_circle),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),

              // 💰 Total Price UI
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Text("Total Price",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      Text("₹$total",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green)),
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
                    padding: EdgeInsets.all(15),
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {

                    String phoneNumber = phone.text.trim();

                    if (checkIn == null ||
                        checkOut == null ||
                        name.text.isEmpty ||
                        phoneNumber.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please fill all details")),
                      );
                      return;
                    }

                    if (!RegExp(r'^[6-9]\d{9}$').hasMatch(phoneNumber)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Enter valid mobile number")),
                      );
                      return;
                    }

                    if (checkOut!.isBefore(checkIn!)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                "Check-out must be after Check-in")),
                      );
                      return;
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookingSummaryScreen(
                          hotel: widget.hotel,
                          total: total,
                          name: name.text,
                          rooms: rooms,
                          days: days,
                          checkIn: checkIn!,
                          checkOut: checkOut!,
                        ),
                      ),
                    );
                  },
                  child: Text("Continue",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,color:Colors.white70)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



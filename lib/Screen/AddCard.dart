import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_saathi/Containt/Product/Product.dart';
import 'package:travel_saathi/Containt/Product/cardlist.dart';

import '../statestravel/PaymentScreen.dart';

class AddCard extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return AddCardState();
  }

}

class AddCardState extends State<AddCard>{
  List<Product> addcard=cardlist;
  @override
  void didChangeDependencies() {
    for (var item in addcard) {
      precacheImage(NetworkImage(item.image), context);
    }
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(child:Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            Text("ADD CART",style:TextStyle(fontSize:25,fontWeight:FontWeight.bold),),
            SizedBox(height:20,),
            Expanded(
              child: ListView.builder(
                scrollDirection:Axis.vertical,
                itemBuilder:(context,index){
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Stack(
                      children:[
                        // ClipRRect(
                        //   borderRadius:BorderRadius.circular(20),
                        //   child:Image.network(addcard[index].image,width:double.infinity,height:220,fit:BoxFit.cover,),
                        // ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: CachedNetworkImage(
                            imageUrl:addcard[index].image,
                            width: double.infinity,

                            height: 250,
                            fit: BoxFit.cover,

                            /// Loading UI
                            placeholder: (context, url) => Container(
                              height: 250,
                              color: Colors.grey.shade300,
                              child: const Center(
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                            ),

                            /// Error UI
                            errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                          ),
                        ),
                        Positioned(
                            left:10,
                            bottom:10,
                            child:Row(
                              children: [
                                Icon(Icons.location_on_sharp,color:Colors.white,size:18,),
                                SizedBox(width:4,),
                                Text(addcard[index].name,style:TextStyle(fontWeight:FontWeight.bold,color:Colors.white),)

                              ],
                            )),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              "₹${addcard[index].price}", // 👈 fix
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        // Positioned(
                        //     bottom:10,
                        //     right:10,
                        //     child:Container(
                        //       padding:EdgeInsets.symmetric(horizontal:10,vertical:4),
                        //       decoration:BoxDecoration(
                        //         color:Colors.black54,
                        //         borderRadius:BorderRadius.circular(20),
                        //       ),
                        //       child:Text(addcard[index].price,style:TextStyle(color:Colors.white,fontWeight:FontWeight.bold),),
                        //     )),
                        Positioned(top:10,right:10,
                          child:IconButton(onPressed:(){
                            showDialog(context: context, builder:(context){
                              return AlertDialog(
                                title:Text("Delete Item"),
                                content:Row(
                                  children: [
                                    Icon(Icons.delete),
                                    SizedBox(width:10,),
                                    Text("Are you sure?"),
                                  ],
                                ),
                                actions: [
                                  TextButton(onPressed:(){
                                    Navigator.pop(context);
                                  }, child:Text("Cancel")),
                                  TextButton(onPressed:(){
                                    setState(() {
                                      addcard.removeAt(index);

                                    });
                                    Navigator.pop(context);
                                  }, child:Text("Delete"))
                                ],
                              );
                            });
                          }, icon:Icon(Icons.close_rounded,color:Colors.white,size:20,),
                          style:IconButton.styleFrom(
                            backgroundColor:Colors.black26,
                            shape:CircleBorder()
                          ),),
                        ),
                      ]
                  ),
                );
              },itemCount:addcard.length,),
            ),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "₹${getTotalPrice()}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CheckoutScreen(addcard),
                  ),
                );
              },
              child: Text("Proceed to Checkout"),
            ),

          ],
        ),
      )),
    );
  }

  int getTotalPrice() {
    int total = 0;

    for (var item in addcard) {
      total += item.price; // 👈 direct add
    }

    return total;
  }

}


class Member {
  String name;
  int age;
  String aadhar;

  Member({
    required this.name,
    required this.age,
    required this.aadhar,
  });
}
class CheckoutScreen extends StatefulWidget {
  final List<Product> cartItems;

  CheckoutScreen(this.cartItems);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {

  DateTime? selectedDate;
  List<Member> members = [];

  /// Total Price
  int getTotal() {
    if (members.isEmpty) return 0; // 🔥 important

    int cartTotal = 0;

    for (var item in widget.cartItems) {
      cartTotal += item.price;
    }

    return cartTotal * members.length;
  }

  /// Date Picker
  Future<void> pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  /// Add Member Dialog (VALIDATION)
  void addMemberDialog() {
    final formKey = GlobalKey<FormState>();

    TextEditingController name = TextEditingController();
    TextEditingController age = TextEditingController();
    TextEditingController aadhar = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Center(child: Text("Add Member 👤")),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              /// Name
              TextFormField(
                controller: name,
                decoration: InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                validator: (v) => v!.isEmpty ? "Enter name" : null,
              ),

              SizedBox(height: 10),

              /// Age
              TextFormField(
                controller: age,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Age",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                validator: (v) {
                  if (v!.isEmpty) return "Enter age";
                  int val = int.parse(v);
                  if (val > 90) return "Age must ≤ 90";
                  return null;
                },
              ),

              SizedBox(height: 10),

              /// Aadhaar
              TextFormField(
                controller: aadhar,
                keyboardType: TextInputType.number,
                maxLength: 12,
                decoration: InputDecoration(
                  labelText: "Aadhaar Number",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                validator: (v) {
                  if (v!.length != 12) return "Enter 12 digit Aadhaar";
                  return null;
                },
              ),
            ],
          ),
        ),

        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                setState(() {
                  members.add(
                    Member(
                      name: name.text,
                      age: int.parse(age.text),
                      aadhar: aadhar.text,
                    ),
                  );
                });
                Navigator.pop(context);
              }
            },
            child: Text("Add"),
          )
        ],
      ),
    );
  }

  /// Firebase Save
  Future<void> saveBooking() async {
    String? userEmail = FirebaseAuth.instance.currentUser?.email;

    await FirebaseFirestore.instance.collection("placeBookings").add({
      "userEmail":userEmail,
      "date": Timestamp.fromDate(selectedDate!),
      "total": getTotal(),
      "createdAt": Timestamp.now(),
      /// 👇 ADD THIS (IMPORTANT)
      "places": widget.cartItems.map((item) => {
        "name": item.name,
        "price": item.price,
        "image": item.image,
      }).toList(),
      "members": members.map((m) => {
        "name": m.name,
        "age": m.age,
        "aadhar": m.aadhar,
      }).toList(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Checkout")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// Date UI
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                leading: Icon(Icons.calendar_today, color: Colors.green),
                title: Text("Booking Date"),
                subtitle: Text(
                  selectedDate == null
                      ? "Select Date"
                      : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                ),
                onTap: pickDate,
              ),
            ),

            SizedBox(height: 10),

            /// Add Member Button
            ElevatedButton.icon(
              onPressed: addMemberDialog,
              icon: Icon(Icons.person_add),
              label: Text("Add Member"),
            ),

            SizedBox(height: 10),

            /// Members List
            Expanded(
              child: ListView.builder(
                itemCount: members.length,
                itemBuilder: (context, index) {
                  final m = members[index];

                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.green,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      title: Text(m.name),
                      subtitle: Text("Age: ${m.age}"),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() => members.removeAt(index));
                        },
                      ),
                    ),
                  );
                },
              ),
            ),

            /// Total
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total"),
                  Text("₹${getTotal()}",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green)),
                ],
              ),
            ),

            SizedBox(height: 10),

            /// Payment Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () async {

                if (selectedDate == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Select date")),
                  );
                  return;
                }

                if (members.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Add members")),
                  );
                  return;
                }

                await saveBooking();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SummaryScreen(
                      cartItems: widget.cartItems,
                      members: members,
                      selectedDate: selectedDate!,
                      total: getTotal(),
                    ),
                  ),
                );
              },
              child: Text("Proceed to Summary"),
            )
          ],
        ),
      ),
    );
  }
}



class SummaryScreen extends StatelessWidget {
  final List<Product> cartItems;
  final List<Member> members;
  final DateTime selectedDate;
  final int total;

  SummaryScreen({
    required this.cartItems,
    required this.members,
    required this.selectedDate,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        elevation: 0,
        title: Text("Booking Summary"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// 🏝️ PLACE CARD (MODERN)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.purple],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 10)
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Selected Places",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),

                  SizedBox(height: 10),

                  ...cartItems.map((item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(item.name,
                            style: TextStyle(color: Colors.white,fontSize:11)),
                        Text("₹${item.price}",
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ))
                ],
              ),
            ),

            SizedBox(height: 15),

            /// 👤 MEMBERS + DATE ROW
            Row(
              children: [

                /// MEMBERS CARD
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 8)
                      ],
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.people, color: Colors.blue, size: 30),
                        SizedBox(height: 5),
                        Text("${members.length}",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        Text("Members"),
                      ],
                    ),
                  ),
                ),

                SizedBox(width: 10),

                /// DATE CARD
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 8)
                      ],
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.calendar_today,
                            color: Colors.orange, size: 30),
                        SizedBox(height: 5),
                        Text(
                          "${selectedDate.day}/${selectedDate.month}",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text("Date"),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),

            /// 💰 TOTAL BIG CARD
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green, Colors.teal],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: Colors.black26, blurRadius: 10)
                ],
              ),
              child: Column(
                children: [
                  Text("Total Amount",
                      style: TextStyle(color: Colors.white70)),

                  SizedBox(height: 10),

                  Text("₹$total",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ],
              ),
            ),

            Spacer(),

            /// 🔥 CONFIRM BUTTON (MODERN)
            GestureDetector(
              onTap: () {
                Navigator.push(context,MaterialPageRoute(builder:(context) => PaymentScreen(Rupies:"${total}")));
              },
              child: Container(
                height: 55,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.deepPurple, Colors.blue],
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text("Confirm Booking",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
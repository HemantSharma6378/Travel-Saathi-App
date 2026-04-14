// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
//
//
// class profile extends StatefulWidget{
//   @override
//   State<profile> createState(){
//     return profilestate();
//   }
//
// }
//
// class profilestate extends State<profile>{
//   String? Name;
//   String? Email;
//   String? Phone_Number;
//   Future<void> getuserdata() async{
//     DocumentSnapshot snapshot=await FirebaseFirestore.instance
//         .collection("Users")
//         .doc(docuser).get();
//     if(snapshot.exists){
//       Name=snapshot["Name"];
//       Email=snapshot["Email"];
//       Phone_Number=snapshot["Phone_Number"];
//     }
//   }
//   Future<void> loadUserData() async {
//     await getdata();      // pehle email lao
//     await getuserdata(); // phir firestore call
//     setState(() {});     // UI update
//   }
//   File? imageFile;
//
//   final ImagePicker imagePicker=ImagePicker();
//   Future<void> PickerImage(ImageSource source) async{
//     final XFile? image = await imagePicker.pickImage(source: source);
//     if(image != null){
//       final prefs=await SharedPreferences.getInstance();
//       await prefs.setString("profile_image",image.path);
//       setState((){
//         imageFile=File(image.path);
//       });
//     }
//   }
//   @override
//   void initState(){
//     super.initState();
//     loadImage();
//     loadUserData();
//   }
//   Future<void> loadImage() async{
//     final prefs = await SharedPreferences.getInstance();
//     final path=prefs.getString("profile_image");
//     if(path != null){
//       setState(() {
//         imageFile=File(path);
//       });
//     }
//   }
//   String? docuser;
//   Future<void> getdata() async{
//     SharedPreferences prefsdata= await SharedPreferences.getInstance();
//     docuser=await prefsdata.getString("email");
//
//   }
//   void showImagePicker(){
//     // showModalBottomSheet(context: context, builder:(context){
//     //   return Column(
//     //     mainAxisSize:MainAxisSize.min,
//     //     children: [
//     //       ListTile(
//     //         leading:Icon(Icons.camera_alt),
//     //         title:Text("camera"),
//     //         onTap:(){
//     //           Navigator.pop(context);
//     //           PickerImage(ImageSource.camera);
//     //         },
//     //       ),
//     //       ListTile(
//     //         leading:Icon(Icons.photo),
//     //         title:Text("Gallery"),
//     //         onTap:(){
//     //           Navigator.pop(context);
//     //           PickerImage(ImageSource.gallery);
//     //
//     //         },
//     //       )
//     //     ],
//     //   );
//     // });
//
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text("Select Photo"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(
//                 leading: Icon(Icons.camera_alt),
//                 title: Text("Camera"),
//                 onTap: () {
//                   Navigator.pop(context);
//                   PickerImage(ImageSource.camera);
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.photo),
//                 title: Text("Gallery"),
//                 onTap: () {
//                   Navigator.pop(context);
//                   PickerImage(ImageSource.gallery);
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//
//   }
//   @override
//   Widget build(BuildContext context){
//     return Scaffold(
//         body:SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment:CrossAxisAlignment.start,
//               mainAxisAlignment:MainAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment:MainAxisAlignment.center,
//                   crossAxisAlignment:CrossAxisAlignment.center,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(top:40.0),
//                       child: Column(
//                         children: [
//                           Stack(
//                             children :[
//                               CircleAvatar(
//                               radius:52,
//                               // backgroundColor:Colors.red,
//                               child: CircleAvatar(
//                                 radius:50,
//                                 backgroundImage: imageFile != null ? FileImage(imageFile!) : AssetImage("assets/images/profileimage.png"),
//                               ),
//                             ),
//                               Positioned(
//                                   child:IconButton(onPressed:showImagePicker, icon:Icon(Icons.add_a_photo,color:Colors.white)),
//                                 bottom:3,
//                                 right:1,
//                               )
//                             ]
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(top:16),
//                             child: Column(
//                               crossAxisAlignment:CrossAxisAlignment.center,
//                               mainAxisAlignment:MainAxisAlignment.start,
//                               children: [
//                                 Text("$Name",style:TextStyle(fontSize: 21,fontWeight:FontWeight.bold),),
//                                 Text("$Email"),
//                                 Text("$Phone_Number")
//                               ],
//                             ),
//                           ),
//                           SizedBox(width: 50,)
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 Padding(
//                   padding: const EdgeInsets.only(top:20,left: 25,right: 25,bottom: 20),
//                   child: Column(
//                     crossAxisAlignment:CrossAxisAlignment.start,
//                     mainAxisAlignment:MainAxisAlignment.start,
//                     children: [
//                       Text("Phone Number",style:TextStyle(fontSize:21,fontWeight:FontWeight.w600),),
//                       TextField(
//                         readOnly:true,
//                         controller:TextEditingController(text:"$Phone_Number"),
//                         decoration: InputDecoration(
//                           border:OutlineInputBorder(
//                             borderRadius:BorderRadius.circular(20)
//                           )
//                         ),
//                       ),
//                       SizedBox(height: 20,),
//                       Text("Gender (Optional)",style:TextStyle(fontSize:21,fontWeight:FontWeight.w600),),
//                       TextField(
//                         readOnly:true,
//                         controller:TextEditingController(text:"$Phone_Number"),
//                         decoration: InputDecoration(
//                           border:OutlineInputBorder(
//                             borderRadius:BorderRadius.circular(20)
//                           )
//                         ),
//                       ),
//                       SizedBox(height: 20,),
//                       Text("Date of Birth",style:TextStyle(fontSize:21,fontWeight:FontWeight.w600),),
//                       TextField(
//                         readOnly:true,
//                         controller:TextEditingController(text:"$Phone_Number"),
//                         decoration: InputDecoration(
//                           border:OutlineInputBorder(
//                             borderRadius:BorderRadius.circular(20)
//                           )
//                         ),
//                       ),
//                       SizedBox(height: 20,),
//                       Text("Address / City",style:TextStyle(fontSize:21,fontWeight:FontWeight.w600),),
//                       Text("$Phone_Number",style:TextStyle(fontSize:18),),
//                       SizedBox(height: 10,),
//
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//     );
//   }
//
// }



// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class profile extends StatefulWidget {
//   @override
//   State<profile> createState() => ProfileState();
// }
//
// class ProfileState extends State<profile> {
//
//   String? docuser;
//   String? Name;
//   String? Email;
//   String? Phone_Number;
//   String? Gender;
//   String? Address;
//   DateTime? Dob;
//
//   File? imageFile;
//   final ImagePicker imagePicker = ImagePicker();
//
//   @override
//   void initState() {
//     super.initState();
//     loadImage();
//     loadUserData();
//   }
//
//   // ---------------- GET EMAIL FROM SHARED PREF ----------------
//   Future<void> getdata() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     docuser = prefs.getString("email");
//   }
//
//   // ---------------- LOAD FIRESTORE DATA ----------------
//   Future<void> getuserdata() async {
//     if (docuser == null) return;
//
//     DocumentSnapshot snapshot = await FirebaseFirestore.instance
//         .collection("Users")
//         .doc(docuser)
//         .get();
//
//     if (snapshot.exists) {
//       setState(() {
//         Name = snapshot["Name"];
//         Email = snapshot["Email"];
//         Phone_Number = snapshot["Phone_Number"];
//         Gender = snapshot["Gender"];
//         Address = snapshot["Address"];
//         Dob = snapshot["Dob"] != null
//             ? DateTime.parse(snapshot["Dob"])
//             : null;
//       });
//     }
//   }
//
//   Future<void> loadUserData() async {
//     await getdata();
//     await getuserdata();
//   }
//
//   // ---------------- IMAGE PICKER ----------------
//   Future<void> PickerImage(ImageSource source) async {
//     final XFile? image = await imagePicker.pickImage(source: source);
//     if (image != null) {
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setString("profile_image", image.path);
//       setState(() {
//         imageFile = File(image.path);
//       });
//     }
//   }
//
//   Future<void> loadImage() async {
//     final prefs = await SharedPreferences.getInstance();
//     final path = prefs.getString("profile_image");
//     if (path != null) {
//       setState(() {
//         imageFile = File(path);
//       });
//     }
//   }
//
//   void showImagePicker() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text("Select Photo"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(
//                 leading: Icon(Icons.camera_alt),
//                 title: Text("Camera"),
//                 onTap: () {
//                   Navigator.pop(context);
//                   PickerImage(ImageSource.camera);
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.photo),
//                 title: Text("Gallery"),
//                 onTap: () {
//                   Navigator.pop(context);
//                   PickerImage(ImageSource.gallery);
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   // ---------------- EDIT DIALOG ----------------
//   void openEditDialog() {
//
//     TextEditingController phoneController =
//     TextEditingController(text: Phone_Number);
//
//     TextEditingController addressController =
//     TextEditingController(text: Address);
//
//     String selectedGender = Gender ?? "Male";
//     DateTime? selectedDate = Dob;
//
//     showDialog(
//       context: context,
//       builder: (context) {
//         return StatefulBuilder(
//           builder: (context, setStateDialog) {
//             return AlertDialog(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20)),
//               title: Text("Edit Profile"),
//               content: SingleChildScrollView(
//                 child: Column(
//                   children: [
//
//                     TextField(
//                       controller: phoneController,
//                       keyboardType: TextInputType.phone,
//                       decoration: InputDecoration(
//                         labelText: "Phone Number",
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15)),
//                       ),
//                     ),
//
//                     SizedBox(height: 15),
//
//                     DropdownButtonFormField(
//                       value: selectedGender,
//                       items: ["Male", "Female", "Other"]
//                           .map((e) => DropdownMenuItem(
//                         value: e,
//                         child: Text(e),
//                       ))
//                           .toList(),
//                       onChanged: (value) {
//                         setStateDialog(() {
//                           selectedGender = value!;
//                         });
//                       },
//                       decoration: InputDecoration(
//                         labelText: "Gender",
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15)),
//                       ),
//                     ),
//
//                     SizedBox(height: 15),
//
//                     TextField(
//                       readOnly: true,
//                       decoration: InputDecoration(
//                         labelText: selectedDate == null
//                             ? "Select Date of Birth"
//                             : selectedDate.toString().split(" ")[0],
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15)),
//                       ),
//                       onTap: () async {
//                         DateTime? picked = await showDatePicker(
//                           context: context,
//                           initialDate:
//                           selectedDate ?? DateTime.now(),
//                           firstDate: DateTime(1950),
//                           lastDate: DateTime.now(),
//                         );
//                         if (picked != null) {
//                           setStateDialog(() {
//                             selectedDate = picked;
//                           });
//                         }
//                       },
//                     ),
//
//                     SizedBox(height: 15),
//
//                     TextField(
//                       controller: addressController,
//                       decoration: InputDecoration(
//                         labelText: "Address",
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15)),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               actions: [
//
//                 TextButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: Text("Cancel"),
//                 ),
//
//                 ElevatedButton(
//                   onPressed: () async {
//
//                     await FirebaseFirestore.instance
//                         .collection("Users")
//                         .doc(docuser)
//                         .update({
//                       "Phone_Number": phoneController.text,
//                       "Gender": selectedGender,
//                       "Dob": selectedDate?.toString(),
//                       "Address": addressController.text,
//                     });
//
//                     await loadUserData();
//
//                     Navigator.pop(context);
//
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text("Profile Updated Successfully")),
//                     );
//                   },
//                   child: Text("Save"),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }
//
//   // ---------------- UI ----------------
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Profile"),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.edit),
//             onPressed: openEditDialog,
//           )
//         ],
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//
//               SizedBox(height: 20),
//
//               Stack(
//                 children: [
//                   CircleAvatar(
//                     radius: 55,
//                     child: CircleAvatar(
//                       radius: 52,
//                       backgroundImage: imageFile != null
//                           ? FileImage(imageFile!)
//                           : AssetImage("assets/images/profileimage.png")
//                       as ImageProvider,
//                     ),
//                   ),
//                   Positioned(
//                     bottom: 0,
//                     right: 0,
//                     child: IconButton(
//                       onPressed: showImagePicker,
//                       icon: Icon(Icons.add_a_photo,
//                           color: Colors.white),
//                     ),
//                   )
//                 ],
//               ),
//
//               SizedBox(height: 15),
//
//               Text(Name ?? "",
//                   style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold)),
//               Text(Email ?? ""),
//               Text(Phone_Number ?? ""),
//
//               SizedBox(height: 30),
//
//               ListTile(
//                 title: Text("Gender"),
//                 subtitle: Text(Gender ?? "Not Set"),
//               ),
//
//               ListTile(
//                 title: Text("Date of Birth"),
//                 subtitle: Text(
//                     Dob == null
//                         ? "Not Set"
//                         : Dob.toString().split(" ")[0]),
//               ),
//
//               ListTile(
//                 title: Text("Address"),
//                 subtitle: Text(Address ?? "Not Set"),
//               ),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class profile extends StatefulWidget {
//   @override
//   State<profile> createState() => ProfileState();
// }
//
// class ProfileState extends State<profile> {
//
//   String? docuser;
//   String? Name;
//   String? Email;
//   String? Phone_Number;
//   String? Gender;
//   String? Address;
//   DateTime? Dob;
//
//   File? imageFile;
//   final ImagePicker imagePicker = ImagePicker();
//
//   @override
//   void initState() {
//     super.initState();
//     loadImage();
//     loadUserData();
//   }
//
//   // ---------------- GET EMAIL ----------------
//   Future<void> getdata() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     docuser = prefs.getString("email");
//   }
//
//   // ---------------- LOAD USER DATA ----------------
//   Future<void> getuserdata() async {
//     if (docuser == null) return;
//
//     DocumentSnapshot snapshot = await FirebaseFirestore.instance
//         .collection("Users")
//         .doc(docuser)
//         .get();
//
//     if (snapshot.exists) {
//       setState(() {
//         Name = snapshot["Name"];
//         Email = snapshot["Email"];
//         Phone_Number = snapshot["Phone_Number"];
//         Gender = snapshot["Gender"];
//         Address = snapshot["Address"];
//         Dob = snapshot["Dob"] != null
//             ? (snapshot["Dob"] as Timestamp).toDate()
//             : null;
//       });
//     }
//   }
//
//   Future<void> loadUserData() async {
//     await getdata();
//     await getuserdata();
//   }
//
//   // ---------------- IMAGE PICKER ----------------
//   Future<void> pickImage(ImageSource source) async {
//     final XFile? image = await imagePicker.pickImage(source: source);
//     if (image != null) {
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setString("profile_image", image.path);
//       setState(() {
//         imageFile = File(image.path);
//       });
//     }
//   }
//
//   Future<void> loadImage() async {
//     final prefs = await SharedPreferences.getInstance();
//     final path = prefs.getString("profile_image");
//     if (path != null) {
//       setState(() {
//         imageFile = File(path);
//       });
//     }
//   }
//
//   void showImagePicker() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text("Select Photo"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(
//                 leading: Icon(Icons.camera_alt),
//                 title: Text("Camera"),
//                 onTap: () {
//                   Navigator.pop(context);
//                   pickImage(ImageSource.camera);
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.photo),
//                 title: Text("Gallery"),
//                 onTap: () {
//                   Navigator.pop(context);
//                   pickImage(ImageSource.gallery);
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   // ---------------- EDIT DIALOG ----------------
//   void openEditDialog() {
//
//     TextEditingController phoneController =
//     TextEditingController(text: Phone_Number ?? "");
//
//     TextEditingController addressController =
//     TextEditingController(text: Address ?? "");
//
//     String selectedGender = Gender ?? "Male";
//     DateTime? selectedDate = Dob;
//
//     showDialog(
//       context: context,
//       builder: (context) {
//         return StatefulBuilder(
//           builder: (context, setStateDialog) {
//             return AlertDialog(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20)),
//               title: Text("Edit Profile"),
//               content: SingleChildScrollView(
//                 child: Column(
//                   children: [
//
//                     TextField(
//                       controller: phoneController,
//                       keyboardType: TextInputType.phone,
//                       decoration: InputDecoration(
//                         labelText: "Phone Number",
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15)),
//                       ),
//                     ),
//
//                     SizedBox(height: 15),
//
//                     DropdownButtonFormField(
//                       value: selectedGender,
//                       items: ["Male", "Female", "Other"]
//                           .map((e) => DropdownMenuItem(
//                         value: e,
//                         child: Text(e),
//                       ))
//                           .toList(),
//                       onChanged: (value) {
//                         setStateDialog(() {
//                           selectedGender = value!;
//                         });
//                       },
//                       decoration: InputDecoration(
//                         labelText: "Gender",
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15)),
//                       ),
//                     ),
//
//                     SizedBox(height: 15),
//
//                     TextField(
//                       readOnly: true,
//                       decoration: InputDecoration(
//                         labelText: selectedDate == null
//                             ? "Select Date of Birth"
//                             : "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}",
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15)),
//                       ),
//                       onTap: () async {
//                         DateTime? picked = await showDatePicker(
//                           context: context,
//                           initialDate:
//                           selectedDate ?? DateTime.now(),
//                           firstDate: DateTime(1950),
//                           lastDate: DateTime.now(),
//                         );
//                         if (picked != null) {
//                           setStateDialog(() {
//                             selectedDate = picked;
//                           });
//                         }
//                       },
//                     ),
//
//                     SizedBox(height: 15),
//
//                     TextField(
//                       controller: addressController,
//                       decoration: InputDecoration(
//                         labelText: "Address",
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15)),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               actions: [
//
//                 TextButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: Text("Cancel"),
//                 ),
//
//                 ElevatedButton(
//                   onPressed: () async {
//
//                     await FirebaseFirestore.instance
//                         .collection("Users")
//                         .doc(docuser)
//                         .update({
//                       "Phone_Number": phoneController.text,
//                       "Gender": selectedGender,
//                       "Dob": selectedDate != null
//                           ? Timestamp.fromDate(selectedDate!)
//                           : null,
//                       "Address": addressController.text,
//                     });
//
//                     await loadUserData();
//
//                     Navigator.pop(context);
//
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text("Profile Updated Successfully")),
//                     );
//                   },
//                   child: Text("Save"),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }
//
//   // ---------------- UI ----------------
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         title: Text("Profile"),
//         centerTitle: true,
//         elevation: 0,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.edit),
//             onPressed: openEditDialog,
//           )
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//
//             SizedBox(height: 25),
//
//             Stack(
//               children: [
//                 CircleAvatar(
//                   radius: 60,
//                   backgroundColor: Colors.blue,
//                   child: CircleAvatar(
//                     radius: 56,
//                     backgroundImage: imageFile != null
//                         ? FileImage(imageFile!)
//                         : AssetImage("assets/images/profileimage.png")
//                     as ImageProvider,
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 0,
//                   right: 0,
//                   child: GestureDetector(
//                     onTap: showImagePicker,
//                     child: CircleAvatar(
//                       backgroundColor: Colors.blue,
//                       child: Icon(Icons.camera_alt,
//                           color: Colors.white),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//
//             SizedBox(height: 15),
//
//             Text(Name ?? "User Name",
//                 style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold)),
//
//             Text(Email ?? ""),
//             Text(Phone_Number ?? ""),
//
//             SizedBox(height: 25),
//
//             Card(
//               margin: EdgeInsets.symmetric(horizontal: 15),
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15)),
//               child: Column(
//                 children: [
//
//                   ListTile(
//                     leading: Icon(Icons.person),
//                     title: Text("Gender"),
//                     subtitle: Text(Gender ?? "Not Set"),
//                   ),
//
//                   Divider(),
//
//                   ListTile(
//                     leading: Icon(Icons.cake),
//                     title: Text("Date of Birth"),
//                     subtitle: Text(
//                         Dob == null
//                             ? "Not Set"
//                             : "${Dob!.day}-${Dob!.month}-${Dob!.year}"),
//                   ),
//
//                   Divider(),
//
//                   ListTile(
//                     leading: Icon(Icons.location_on),
//                     title: Text("Address"),
//                     subtitle: Text(Address ?? "Not Set"),
//                   ),
//
//                 ],
//               ),
//             ),
//
//             SizedBox(height: 30),
//
//           ],
//         ),
//       ),
//     );
//   }
// }




import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

class profile extends StatefulWidget {
  @override
  State<profile> createState() => ProfileState();
}

class ProfileState extends State<profile> {

  String? uid;

  String? Name;
  String? Email;
  String? Phone_Number;
  String? Gender;
  String? Address;
  DateTime? Dob;

  File? imageFile;
  final ImagePicker imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    uid = FirebaseAuth.instance.currentUser?.uid; // ✅ UID
    loadUserData();
    loadImage();
  }

  // ---------------- LOAD USER DATA ----------------
  Future<void> loadUserData() async {

    if (uid == null) return;

    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("Users")
        .doc(uid)
        .get();

    if (snapshot.exists) {
      var data = snapshot.data() as Map<String, dynamic>;

      setState(() {
        Name = data["Name"];
        Email = data["Email"];
        Phone_Number = data["Phone_Number"];
        Gender = data["Gender"];
        Address = data["Address"];
        Dob = data["Dob"] != null
            ? (data["Dob"] as Timestamp).toDate()
            : null;
      });
    }
  }

  // ---------------- IMAGE PICKER ----------------
  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await imagePicker.pickImage(source: source);

    if (image != null) {
      setState(() {
        imageFile = File(image.path);
      });
    }
  }

  Future<void> loadImage() async {
    // (optional: Firebase Storage future use)
  }

  void showImagePicker() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Select Photo"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text("Camera"),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo),
                title: Text("Gallery"),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // ---------------- EDIT PROFILE ----------------
  void openEditDialog() {

    TextEditingController phoneController =
    TextEditingController(text: Phone_Number ?? "");

    TextEditingController addressController =
    TextEditingController(text: Address ?? "");

    String selectedGender = Gender ?? "Male";
    DateTime? selectedDate = Dob;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: Text("Edit Profile"),
              content: SingleChildScrollView(
                child: Column(
                  children: [

                    TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      maxLength: 10, // ✅ limit
                      decoration: InputDecoration(
                        labelText: "Phone Number",
                        counterText: "",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                    ),

                    SizedBox(height: 15),

                    DropdownButtonFormField(
                      value: selectedGender,
                      items: ["Male", "Female", "Other"]
                          .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                          .toList(),
                      onChanged: (value) {
                        setStateDialog(() {
                          selectedGender = value!;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: "Gender",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                    ),

                    SizedBox(height: 15),

                    TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: selectedDate == null
                            ? "Select Date of Birth"
                            : "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      onTap: () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: selectedDate ?? DateTime.now(),
                          firstDate: DateTime(1950),
                          lastDate: DateTime.now(),
                        );
                        if (picked != null) {
                          setStateDialog(() {
                            selectedDate = picked;
                          });
                        }
                      },
                    ),

                    SizedBox(height: 15),

                    TextField(
                      controller: addressController,
                      decoration: InputDecoration(
                        labelText: "Address",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [

                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel"),
                ),

                ElevatedButton(
                  onPressed: () async {

                    if (uid == null) return;

                    await FirebaseFirestore.instance
                        .collection("Users")
                        .doc(uid) // ✅ UID
                        .update({
                      "Phone_Number": phoneController.text.trim(),
                      "Gender": selectedGender,
                      "Dob": selectedDate != null
                          ? Timestamp.fromDate(selectedDate!)
                          : null,
                      "Address": addressController.text.trim(),
                    });

                    await loadUserData();

                    Navigator.pop(context);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Profile Updated Successfully")),
                    );
                  },
                  child: Text("Save"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // ---------------- UI ----------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: openEditDialog,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            SizedBox(height: 25),

            Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.blue,
                  child: CircleAvatar(
                    radius: 56,
                    backgroundImage: imageFile != null
                        ? FileImage(imageFile!)
                        : AssetImage("assets/images/profileimage.png")
                    as ImageProvider,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: showImagePicker,
                    child: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.camera_alt,
                          color: Colors.white),
                    ),
                  ),
                )
              ],
            ),

            SizedBox(height: 15),

            Text(Name ?? "User Name",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold)),

            Text(Email ?? ""),
            Text(Phone_Number ?? ""),

            SizedBox(height: 25),

            Card(
              margin: EdgeInsets.symmetric(horizontal: 15),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [

                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text("Gender"),
                    subtitle: Text(Gender ?? "Not Set"),
                  ),

                  Divider(),

                  ListTile(
                    leading: Icon(Icons.cake),
                    title: Text("Date of Birth"),
                    subtitle: Text(
                        Dob == null
                            ? "Not Set"
                            : "${Dob!.day}-${Dob!.month}-${Dob!.year}"),
                  ),

                  Divider(),

                  ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text("Address"),
                    subtitle: Text(Address ?? "Not Set"),
                  ),

                ],
              ),
            ),

            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
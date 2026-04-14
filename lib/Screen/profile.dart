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

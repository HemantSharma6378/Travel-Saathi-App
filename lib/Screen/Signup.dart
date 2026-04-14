//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:travel_saathi/Screen/login.dart';
//
// class SignupScreen extends StatefulWidget{
//   @override
//   State<StatefulWidget> createState() {
//     return SignupScreenState();
//   }
//
// }
//
// class SignupScreenState extends State<SignupScreen> {
//
//   TextEditingController namectr = TextEditingController();
//   TextEditingController emailctr = TextEditingController();
//   TextEditingController phonectr = TextEditingController();
//   TextEditingController passwordctr = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   bool ispasswordhidden = true;
//
//   Future<void> signupuser() async{
//     try{
//       await FirebaseAuth.instance.createUserWithEmailAndPassword(
//           email:emailctr.text.trim(), password:passwordctr.text.trim()
//       );
//       SharedPreferences prefsdata=await SharedPreferences.getInstance();
//       await prefsdata.setString("email",emailctr.text.toString());
//       await uploaddata();
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Signup Successful")));
//       Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) => login()));
//     } on FirebaseAuthException catch(e){
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(e.message ?? "Error")));
//     }
//   }
//
//   Future<void> uploaddata()async{
//     await FirebaseFirestore.instance
//         .collection("Users")
//         .doc(emailctr.text.toString())
//         .set(
//       {
//         "Name":namectr.text.toString(),
//         "Phone_Number":phonectr.text.toString(),
//         "Email":emailctr.text.toString(),
//         "Gender":null,
//         "Dob":null,
//         "Address":null,
//       }
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Color(0xff9DC7E8),
//               Color(0xffF7D7B8),
//             ],
//           ),
//         ),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//
//                   // 🔹 Top Logo
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 20),
//                     child: Text(
//                       "Travel Saathi",
//                       style: TextStyle(
//                         fontSize: 34,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//
//                   // 🔹 White Card
//                   Container(
//                     margin: EdgeInsets.all(16),
//                     padding: EdgeInsets.all(16),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Center(
//                           child: Text("Sign Up", style: TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 22),),
//                         ),
//                         SizedBox(height: 20,),
//                         Padding(padding: EdgeInsets.only(bottom: 15),
//                           child: TextFormField(
//                             keyboardType: TextInputType.name,
//                             controller: namectr,
//                             decoration: InputDecoration(
//                                 labelText: "User Name",
//                                 border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(12.0)
//                                 )
//                             ),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return "Name required";
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//
//                         Padding(padding: EdgeInsets.only(bottom: 15.0),
//                           child: TextFormField(
//                             keyboardType: TextInputType.phone,
//                             controller: phonectr,
//                             decoration: InputDecoration(
//                                 labelText: "Phone Number",
//                                 border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(12.0)
//                                 )
//                             ),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return "Phone Number required";
//                               }
//                               if (value.length != 10) {
//                                 return "Enter valid 10 digit phone number";
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//
//                         Padding(padding: EdgeInsets.only(bottom: 15.0),
//                           child: TextFormField(
//                             keyboardType: TextInputType.emailAddress,
//                             controller: emailctr,
//                             decoration: InputDecoration(
//                                 labelText: "Email",
//                                 border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(12.0)
//                                 )
//                             ),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return "Email required";
//                               }
//                               final emailRegex = RegExp(
//                                   r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'
//                               );
//                               if (!emailRegex.hasMatch(value)) {
//                                 return "Enter valid email";
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//
//
//                         Padding(
//                           padding: const EdgeInsets.only(bottom: 15.0),
//                           child: TextFormField(
//                             keyboardType: TextInputType.visiblePassword,
//                             controller: passwordctr,
//                             obscureText: ispasswordhidden,
//                             decoration: InputDecoration(
//                                 border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(12)
//                                 ),
//                                 labelText: "Password",
//                                 suffixIcon: IconButton(onPressed: () {
//                                   setState(() {
//                                     ispasswordhidden = !ispasswordhidden;
//                                   });
//                                 }, icon: Icon(
//                                   ispasswordhidden ? Icons
//                                       .visibility_off_rounded : Icons
//                                       .visibility_rounded,
//                                 ))
//                             ),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return "Password required";
//                               }
//                               if (value.length < 6) {
//                                 return "Password must be 6 characters";
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//
//                         SizedBox(height: 20),
//
//                         // 🔹 Button
//                         SizedBox(
//                           width: double.infinity,
//                           height: 50,
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.black,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(30),
//                               ),
//                             ),
//                             onPressed: () {
//                               if(_formKey.currentState!.validate()){
//
//                                 signupuser();
//                               }
//                             },
//                             child: Text(
//                               "Signup",
//                               style: TextStyle(fontSize: 16),
//                             ),
//                           ),
//                         ),
//
//                         SizedBox(height: 10),
//                         Center(
//                           child: Text.rich(
//                               TextSpan(
//                                   children: [
//                                     TextSpan(
//                                       text: "Already have an account? ",
//                                       style: TextStyle(color: Colors.grey),
//                                     ),
//                                     TextSpan(
//                                         text: "Login",
//                                         style: TextStyle(color: Colors.blue,
//                                             fontWeight: FontWeight.bold),
//                                         recognizer: TapGestureRecognizer()
//                                           ..onTap = () {
//                                             Navigator.pushReplacement(context,
//                                                 MaterialPageRoute(
//                                                     builder: (context) =>
//                                                         login()));
//                                           }
//                                     )
//                                   ]
//                               )
//                           ),
//                         )
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:travel_saathi/Screen/login.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SignupScreenState();
  }
}

class SignupScreenState extends State<SignupScreen> {

  TextEditingController namectr = TextEditingController();
  TextEditingController emailctr = TextEditingController();
  TextEditingController phonectr = TextEditingController();
  TextEditingController passwordctr = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool ispasswordhidden = true;
  bool isLoading = false;

  // 🔐 SIGNUP FUNCTION
  Future<void> signupuser() async {

    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {

      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailctr.text.trim(),
        password: passwordctr.text.trim(),
      );

      String uid = userCredential.user!.uid;

      // 🔥 Store user data in Firestore
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(uid)
          .set({
        "Name": namectr.text.trim(),
        "Phone_Number": phonectr.text.trim(),
        "Email": emailctr.text.trim(),
        "Gender": null,
        "Dob": null,
        "Address": null,
        "CreatedAt": FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Signup Successful ✅")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => login()),
      );

    } on FirebaseAuthException catch (e) {

      String message = "Something went wrong";

      if (e.code == 'email-already-in-use') {
        message = "Email already registered";
      } else if (e.code == 'weak-password') {
        message = "Password is too weak";
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));

    } finally {
      setState(() => isLoading = false);
    }
  }

  // 🧹 Dispose controllers
  @override
  void dispose() {
    namectr.dispose();
    emailctr.dispose();
    phonectr.dispose();
    passwordctr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff9DC7E8),
              Color(0xffF7D7B8),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [

                  // 🔹 App Title
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      "Travel Saathi",
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // 🔹 White Card
                  Container(
                    margin: EdgeInsets.all(16),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Center(
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                          ),
                        ),

                        SizedBox(height: 20),

                        // 👤 NAME
                        Padding(
                          padding: EdgeInsets.only(bottom: 15),
                          child: TextFormField(
                            controller: namectr,
                            decoration: InputDecoration(
                              labelText: "User Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            validator: (value) =>
                            value!.isEmpty ? "Name required" : null,
                          ),
                        ),

                        // 📱 PHONE
                        Padding(
                          padding: EdgeInsets.only(bottom: 15),
                          child: TextFormField(
                            controller: phonectr,
                            keyboardType: TextInputType.phone,
                            maxLength: 10, // ✅ limit
                            decoration: InputDecoration(
                              labelText: "Phone Number",
                              counterText: "",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Phone Number required";
                              }
                              if (value.length != 10) {
                                return "Enter valid 10 digit number";
                              }
                              return null;
                            },
                          ),
                        ),

                        // 📧 EMAIL
                        Padding(
                          padding: EdgeInsets.only(bottom: 15),
                          child: TextFormField(
                            controller: emailctr,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: "Email",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Email required";
                              }
                              final emailRegex = RegExp(
                                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                              if (!emailRegex.hasMatch(value)) {
                                return "Enter valid email";
                              }
                              return null;
                            },
                          ),
                        ),

                        // 🔐 PASSWORD
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: TextFormField(
                            controller: passwordctr,
                            obscureText: ispasswordhidden,
                            decoration: InputDecoration(
                              labelText: "Password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(ispasswordhidden
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    ispasswordhidden = !ispasswordhidden;
                                  });
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Password required";
                              }
                              if (value.length < 6) {
                                return "Minimum 6 characters required";
                              }
                              return null;
                            },
                          ),
                        ),

                        SizedBox(height: 20),

                        // 🔘 BUTTON
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: signupuser,
                            child: isLoading
                                ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                                : Text("Signup",
                                style: TextStyle(fontSize: 16)),
                          ),
                        ),

                        SizedBox(height: 10),

                        // 🔗 LOGIN
                        Center(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "Already have an account? ",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                TextSpan(
                                  text: "Login",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => login()),
                                      );
                                    },
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
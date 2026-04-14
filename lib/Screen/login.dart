import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:travel_saathi/Screen/BottomNavigationBarScreen.dart';
import 'package:travel_saathi/Screen/Signup.dart';

class login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return loginState();
  }

}
class loginState extends State<login>{
  final _formkey=GlobalKey<FormState>();

  bool ispasswordhidden=true;
  TextEditingController emailctr=TextEditingController();
  TextEditingController passwordctr=TextEditingController();

  Future<void> loginuser() async{
    try{
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email:emailctr.text.trim(), password:passwordctr.text.trim());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Login Successful")));
        // Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => BottomNavigationBarScreen()));
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => BottomNavigationBarScreen()),
              (route) => false,
        );
    } on FirebaseAuthException catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
      Text(e.message ?? "Error")));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        width:double.infinity,
        height:double.infinity,
        decoration:BoxDecoration(
          gradient:LinearGradient(
              begin:Alignment.topCenter,
              end:Alignment.bottomCenter,
              colors:[
                Color(0xff9DC7E8),
                Color(0xffF7D7B8),
          ]),
        ),
        child:SafeArea(
            child:SingleChildScrollView(
              child:Column(
                children: [
                  Padding(padding:EdgeInsets.symmetric(vertical: 20.0),
                  child:Text("Travel Saathi",
                    style:TextStyle(
                      fontSize:34,
                      fontWeight:FontWeight.bold,
                    ),
                  ),
                  ),
                  Container(
                    margin:EdgeInsets.all(16),
                    padding:EdgeInsets.all(16),
                    decoration:BoxDecoration(
                      color:Colors.white,
                      borderRadius:BorderRadius.circular(20)
                    ),
                    child:Form(
                      key:_formkey,
                      child: Column(
                        crossAxisAlignment:CrossAxisAlignment.start,
                        children: [
                          Center(child: Text("Login",style:TextStyle(
                            fontSize: 22,
                            fontWeight:FontWeight.bold
                          ),)),
                          SizedBox(height:20,),
                          Padding(padding: EdgeInsets.only(bottom: 15.0),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller:emailctr,
                              decoration: InputDecoration(
                                  labelText: "Email",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0)
                                  )
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Email required";
                                }
                                final emailRegex = RegExp(
                                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'
                                );
                                if (!emailRegex.hasMatch(value)) {
                                  return "Enter valid email";
                                }
                                return null;
                              },
                            ),
                          ),


                          Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: TextFormField(
                              keyboardType: TextInputType.visiblePassword,
                              controller:passwordctr,
                              obscureText: ispasswordhidden,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12)
                                  ),
                                  labelText: "Password",
                                  suffixIcon: IconButton(onPressed: () {
                                    setState(() {
                                      ispasswordhidden = !ispasswordhidden;
                                    });
                                  }, icon: Icon(
                                    ispasswordhidden ? Icons
                                        .visibility_off_rounded : Icons
                                        .visibility_rounded,
                                  ))
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Password required";
                                }
                                if (value.length < 6) {
                                  return "Password must be 6 characters";
                                }
                                return null;
                              },
                            ),
                          ),

                          Align(
                            alignment:Alignment.centerRight,
                            child:Text("Forgot Password?",
                            style:TextStyle(color:Colors.blue),
                            ),
                          ),
                          SizedBox(height: 20,),
                          SizedBox(
                            width:double.infinity,
                            height:50,
                            child:ElevatedButton(
                                style:ElevatedButton.styleFrom(
                                  backgroundColor:Colors.black,
                                  shape:RoundedRectangleBorder(
                                    borderRadius:BorderRadius.circular(30)
                                  )
                                ),
                                onPressed:(){
                                  if(_formkey.currentState!.validate()){
                                    loginuser();
                                  }

                            }, child:Text("Login",style:TextStyle(fontSize:16),)),
                          ),
                          SizedBox(height:15,),
                          Center(
                            child:Text.rich(
                              TextSpan(
                                text:"Don't have an account?",
                                style:TextStyle(color:Colors.grey),
                                children:[
                                  TextSpan(
                                    text:" Sign up",
                                    style:TextStyle(
                                      fontWeight:FontWeight.bold,
                                      color:Colors.blue
                                    ),
                                    recognizer:TapGestureRecognizer()
                                      ..onTap=(){
                                      Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) => SignupScreen()));
                                  }
                                  )
                                ]
                              )
                            ),
                          )


                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
        ),
      )
    );
  }

}

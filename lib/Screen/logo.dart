import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_saathi/Containt/AsestImages.dart';
import 'package:travel_saathi/Screen/BottomNavigationBarScreen.dart';
import 'package:travel_saathi/Screen/login.dart';

class logo extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return logostate();
  }

}


class logostate extends State<logo> with SingleTickerProviderStateMixin{
  late AnimationController controller;
  late Animation<double> animation;
  late Animation<double> scaleanim;
  @override
  void initState(){
    super.initState();
    controller=AnimationController(vsync:this,duration:Duration(seconds:3));
    animation=Tween(begin:0.0,end: 1.0).animate(controller);
    // animate(CurvedAnimation(parent: controller, curve:Curves.easeInOut));
    scaleanim=Tween(begin: 0.7,end: 1.0).animate(CurvedAnimation(parent: controller, curve:Curves.easeOutBack));
    controller.forward();
    // Future.delayed(Duration(seconds:4),(){
    //   Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) => login()));
    //   // Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) => BottomNavigationBarScreen()));
    // });
    Future.delayed(Duration(seconds: 4), () {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // ✅ user already logged in
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => BottomNavigationBarScreen()),
              (route) => false,
        );
      } else {
        // ❌ first time / logout user
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => login()),
              (route) => false,
        );
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        decoration:BoxDecoration(
          gradient:LinearGradient(
              begin:Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors:[
                // Color(0xff0B8457), // Emerald Green
                // Color(0xff0F2027),
                // Color(0xff1FA2A8), // Teal
                Color(0xff0F4C75),
                Color(0xffF5F7FA),
                Color(0xffE4ECF1),
          ])
        ),
        child: Center(
          child:FadeTransition(opacity: animation,
          child:Column(
            crossAxisAlignment:CrossAxisAlignment.center,
            mainAxisAlignment:MainAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: scaleanim,
                child:ClipRRect(
                  borderRadius:BorderRadius.circular(30),
                  child:Image.asset(AssetsImage.img.logo,width: 300,height: 300,fit:BoxFit.cover,),
                ),
              ),

              SizedBox(height:20,),
              ScaleTransition(
                  scale: animation,
                  child: Text("Travel Saathi",style:TextStyle(fontSize:24,fontWeight:FontWeight.bold),)),
              
              SizedBox(height:6,),
              ScaleTransition(
                  scale:animation,
                  child: Text("Your Trusted Travel Partner",style:TextStyle(fontSize:13,fontWeight:FontWeight.bold,color:Color(0xFF8A8A8A)),))

            ],
          )
          )
        ),
      ),
    );
  }

}
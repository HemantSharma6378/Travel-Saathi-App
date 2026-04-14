import 'dart:async';

import 'package:flutter/material.dart';
import 'package:travel_saathi/Screen/BottomNavigationBarScreen.dart';
import 'package:travel_saathi/Screen/Home.dart';
import 'package:travel_saathi/statestravel/booking_history.dart';

class PaymentScreen extends StatefulWidget{
  String? Rupies;
  PaymentScreen({required this.Rupies});
  @override
  State<StatefulWidget> createState(){
    return PaymentScreenState();
  }
}
class PaymentScreenState extends State<PaymentScreen>{
  void processing(){
    Future.delayed(Duration(seconds:1),(){
      Navigator.push(context,MaterialPageRoute(builder:(context) => PaymentSuccessScreen()));
    });
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(
        title:Text("Payment"),
        backgroundColor:Colors.blue,
      ),
      body:Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("₹${widget.Rupies}",style:TextStyle(fontSize:32,fontWeight:FontWeight.bold),),
            SizedBox(height: 20,),
            GestureDetector(
              onTap:(){
                processing();
              },
              child: Container(
                  margin:EdgeInsets.all(10),
                  padding:EdgeInsets.all(10),

                  width:double.infinity,
                  height:60,
                  decoration:BoxDecoration(
                      borderRadius:BorderRadius.circular(10),
                      color:Colors.white,
                      boxShadow:[
                        BoxShadow(
                            color:Colors.grey,
                            blurRadius:10,
                            spreadRadius: 2,
                            offset:Offset(0,4)
                        )
                      ]
                  ),
                  child:Row(
                    children: [
                      Image.asset("assets/images/payment/upi.png",width: 30,height: 30,),
                      SizedBox(width:10,),
                      Text("UPI",style:TextStyle(fontSize:21,fontWeight:FontWeight.bold),)
                    ],
                  )

              ),
            ),
            GestureDetector(
              onTap:(){
                processing();
              },
              child: Container(
                  margin:EdgeInsets.all(10),
                  padding:EdgeInsets.all(10),

                  width:double.infinity,
                  height:60,
                  decoration:BoxDecoration(
                      borderRadius:BorderRadius.circular(10),
                      color:Colors.white,
                      boxShadow:[
                        BoxShadow(
                            color:Colors.grey,
                            blurRadius:10,
                            spreadRadius: 2,
                            offset:Offset(0,4)
                        )
                      ]
                  ),
                  child:Row(
                    children: [
                      Image.asset("assets/images/payment/creditcard.png",width: 30,height: 30,),
                      SizedBox(width:10,),
                      Text("Card",style:TextStyle(fontSize:21,fontWeight:FontWeight.bold),)
                    ],
                  )

              ),
            ),
            GestureDetector(
              onTap:(){
                processing();
              },
              child: Container(
                  margin:EdgeInsets.all(10),
                  padding:EdgeInsets.all(10),

                  width:double.infinity,
                  height:60,
                  decoration:BoxDecoration(
                      borderRadius:BorderRadius.circular(10),
                      color:Colors.white,
                      boxShadow:[
                        BoxShadow(
                            color:Colors.grey,
                            blurRadius:10,
                            spreadRadius: 2,
                            offset:Offset(0,4)
                        )
                      ]
                  ),
                  child:Row(
                    children: [
                      Image.asset("assets/images/payment/banking.png",width: 30,height: 30,),
                      SizedBox(width:10,),
                      Text("Netbanking",style:TextStyle(fontSize:21,fontWeight:FontWeight.bold),)
                    ],
                  )

              ),
            ),
            GestureDetector(
              onTap:(){
                processing();
              },
              child: Container(
                margin:EdgeInsets.all(10),
                padding:EdgeInsets.all(10),

                width:double.infinity,
                height:60,
                decoration:BoxDecoration(
                    borderRadius:BorderRadius.circular(10),
                    color:Colors.white,
                    boxShadow:[
                      BoxShadow(
                          color:Colors.grey,
                          blurRadius:10,
                          spreadRadius: 2,
                          offset:Offset(0,4)
                      )
                    ]
                ),
                child:Row(
                  children: [
                    Image.asset("assets/images/payment/wallet.png",width: 30,height: 30,),
                    SizedBox(width:10,),
                    Text("Wallet",style:TextStyle(fontSize:21,fontWeight:FontWeight.bold),)
                  ],
                ),


              ),
            ),
          ],
        ),
      ),
    );
  }
}
class PaymentSuccessScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return PaymentSuccessScreenState();
  }

}

class PaymentSuccessScreenState extends State<PaymentSuccessScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds:2),(){
      Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder:(context)=>BottomNavigationBarScreen()),(route)=>false);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Icon(Icons.check_circle, color: Colors.green, size: 80),

            SizedBox(height: 20),

            Text(
              "Payment Successful",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10),

            Text("Transaction ID: TXN123456"),
          ],
        ),
      ),
    );
  }
}



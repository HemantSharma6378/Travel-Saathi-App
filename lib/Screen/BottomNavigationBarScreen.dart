import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_saathi/Screen/AddCard.dart';
import 'package:travel_saathi/Screen/Home.dart';
import 'package:travel_saathi/Screen/bikeuser.dart';
import 'package:travel_saathi/Screen/kmap.dart';
import 'package:travel_saathi/Screen/profile.dart';
import 'package:travel_saathi/Screen/rooms.dart';
import 'package:travel_saathi/statestravel/booking_history.dart';

class BottomNavigationBarScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return BNBS();
  }

}

class BNBS extends State<BottomNavigationBarScreen>{
  List<Widget> pages=[
    Home(),
    AddCard(),
    RoomsScreen(),
    MapScreen(),
    VehicleListScreen(),
    BookingHistoryScreen(),
    profile(),

  ];
  int _countindex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:pages[_countindex],
      bottomNavigationBar:BottomNavigationBar(items:[
        BottomNavigationBarItem(icon:Icon(Icons.home),label:"Home"),
        BottomNavigationBarItem(icon:Icon(Icons.add_card),label:"card"),
        BottomNavigationBarItem(icon: Icon(Icons.meeting_room),label:"Rooms"),
        BottomNavigationBarItem(icon:Icon(Icons.map),label:"Map"),
        BottomNavigationBarItem(icon: Icon(Icons.card_travel),label: "Vehical rant"),
        BottomNavigationBarItem(icon:Icon(Icons.history_outlined),label:"Booking History"),
        BottomNavigationBarItem(icon:Icon(Icons.person),label:"Profile"),

      ],
        selectedItemColor:Colors.blue,
        unselectedItemColor:Colors.grey,
        currentIndex:_countindex,
        showSelectedLabels: true,
        showUnselectedLabels:false,
        onTap:(index){
        setState(() {
          _countindex=index;
        });
        },
        type:BottomNavigationBarType.fixed,
      ),
    );
  }

}
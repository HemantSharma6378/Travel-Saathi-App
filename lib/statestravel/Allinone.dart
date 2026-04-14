
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../Containt/Product/Product.dart';
import '../Containt/Product/cardlist.dart';

class Allinone extends StatefulWidget {
  List<String> PlaceImage;
  List<String> PlaceName;
  String TitleName;
  Color TitleColor;
  List<int> PlacePrice;

  Allinone({
    required this.TitleName,
    required this.TitleColor,
    required this.PlaceImage,
    required this.PlaceName,
    required this.PlacePrice,
  });

  @override
  State<Allinone> createState() => AllinoneState();
}

class AllinoneState extends State<Allinone> {

  /// 🔥 Image preload (scroll lag kam karega)
  @override
  void didChangeDependencies() {
    for (var img in widget.PlaceImage) {
      precacheImage(NetworkImage(img), context);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.TitleName,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: widget.TitleColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left:10,right:10,bottom:15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),
                CoustomLSV(
                  Limage: widget.PlaceImage,
                  Lname: widget.PlaceName,
                  Lprice: widget.PlacePrice,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ======================================================

class CoustomLSV extends StatefulWidget {
  List<String> Limage;
  List<String> Lname;
  List<int> Lprice;

  CoustomLSV({
    required this.Limage,
    required this.Lname,
    required this.Lprice,
  });

  @override
  State<CoustomLSV> createState() => _CoustomLSVState();
}

class _CoustomLSVState extends State<CoustomLSV> {

  void showOneMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Cart"),
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 22),
              const SizedBox(width: 10),
              Text(message),
            ],
          ),
        );
      },
    );

    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.Limage.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Stack(
            children: [
              /// 🔥 Cached Network Image
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(20),
              //   child:Image.network(widget.Limage[index],width:double.infinity,height:250,fit:BoxFit.cover,)
              // ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  imageUrl: widget.Limage[index],
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

              /// Place Name
              Positioned(
                left: 10,
                bottom: 10,
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.white,
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      widget.Lname[index],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              /// Add Button
              Positioned(
                bottom: 10,
                right: 10,
                child: GestureDetector(
                  onTap: () {
                    bool alreadyAdd = cardlist.any(
                          (item) => item.name == widget.Lname[index],
                    );

                    if (!alreadyAdd) {
                      setState(() {
                        cardlist.add(
                          Product(
                            name: widget.Lname[index],
                            image: widget.Limage[index],
                            price: widget.Lprice[index],
                          ),
                        );
                      });
                      showOneMessage("Added to Cart");
                    } else {
                      showOneMessage("Item already in cart");
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.add, size: 16, color: Colors.black),
                        SizedBox(width: 4),
                        Text(
                          "Add",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              /// 💰 Price Tag
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    "₹${widget.Lprice[index]}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}





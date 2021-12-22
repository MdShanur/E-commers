
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/page/products.dart';
import 'package:flutter_application_2/page/search.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  TextEditingController _searchController = TextEditingController();

  List<String> _carouselImage = [];
  List _products = [];
  var _dotPosition = 0;

  fatchCarouselImage() async {
    var _firestoreInstance = FirebaseFirestore.instance;
    QuerySnapshot qn =
        await _firestoreInstance.collection("carsoul-image").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _carouselImage.add(
          qn.docs[i]["img-path"],
        );
        print(qn.docs[i]["img-path"]);
      }
    });

    return qn.docs;
  }

  fatchproductImage() async {
    var _firestoreInstance = FirebaseFirestore.instance;
    QuerySnapshot qn = await _firestoreInstance.collection("products").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _products.add({
          'product-img': qn.docs[i]['product-img'],
          'product-disruption': qn.docs[i]['product-disruption'],
          'product-name': qn.docs[i]['product-name'],
          'product-price': qn.docs[i]['product-price'],
        });
      }
    });

    return qn.docs;
  }

  void initState() {
    fatchCarouselImage();
    fatchproductImage();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 60.h,
                        child: TextFormField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0)),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                )),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(0)),
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            hintText: "Search Product Here",
                            hintStyle: TextStyle(fontSize: 20.sp),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                colors: [
                              Colors.redAccent,
                              Colors.amber,
                              Colors.blue,
                              Colors.red,
                              Colors.green
                            ])),
                        height: 60.h,
                        width: 60.w,
                        child: Center(
                          child: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchScreen()));
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              AspectRatio(
                aspectRatio: 3.5,
                child: CarouselSlider(
                  items: _carouselImage
                      .map((item) => Padding(
                            padding: const EdgeInsets.only(left: 3, right: 3),
                            child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(item),
                                        fit: BoxFit.fitWidth))),
                          ))
                      .toList(),
                  options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: 0.8,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      onPageChanged: (val, carouselPageChangedReason) {
                        setState(() {
                          _dotPosition = val;
                        });
                      }),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              DotsIndicator(
                dotsCount:
                    _carouselImage.length == 0 ? 1 : _carouselImage.length,
                position: _dotPosition.toDouble(),
                decorator: DotsDecorator(
                  activeColor: Colors.blue,
                  spacing: EdgeInsets.all(2),
                  activeSize: Size(8, 8),
                  size: Size(6, 6),
                ),
              ),
              Expanded(
                child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: _products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 1),
                    itemBuilder: (_, index) {
                      return GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => productDetalis(_products[index]))),
                        child: Card(
                          elevation: 3,
                          child: Column(
                            children: [
                              AspectRatio(
                                  aspectRatio: 2,
                                  child: Image.network(
                                      _products[index]["product-img"][0])),
                              Text("${_products[index]["product-name"]}"),
                              Text(
                                  "${_products[index]["product-price"].toString()}"),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

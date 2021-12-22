import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class productDetalis extends StatefulWidget {
  var _product;
  productDetalis(this._product);

  @override
  _productDetalisState createState() => _productDetalisState();
}

class _productDetalisState extends State<productDetalis> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
        ),
        title: Center(
          child: Text(
            'Products Detalis',
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 30,
            ),
            child: Icon(
              Icons.favorite,
              color: Colors.red,
              size: 30,
            ),
          )
        ],
      ),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 2.5,
            child: CarouselSlider(
              items: widget._product['product-img']
                  .map<Widget>((item) => Padding(
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
                    setState(() {});
                  }),
            ),
          ),
          SizedBox(
            height: 50.h,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget._product['product-price'].toString(),
                  style: TextStyle(fontSize: 30.sp),
                ),
              ),
              SizedBox(
                width: 400,
              ),
              ElevatedButton(onPressed: () {}, child: Text('Add to Cart')),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            widget._product['product-name'],
            style: TextStyle(fontSize: 27.sp),
          ),
          SizedBox(
            height: 10,
          ),
          Text(widget._product['product-disruption']),
        ],
      )),
    );
  }
}

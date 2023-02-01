import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:sharq_crm/features/orders/presentation/page/car/car_service_page.dart';
import 'package:sharq_crm/features/services/club/presentation/page/customer_part/club_home_page.dart';

import 'album/presentation/page/customer_part/album_home_page.dart';
import 'photo_studio/presentation/page/customer_part/photostudio_home_page.dart';
import 'video/presentation/page/customer_part/video_home_page.dart';

class ServicePage extends StatefulWidget {
  ServicePage({Key? key, required this.customerId}) : super(key: key);
  String customerId;

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              //header part
              _headerPart(),

              // Car order
              // _carOrder(),

              //photoStudio order
              _photoStudioOrder(),

              //clubOrder
              _clubOrder(),

              //album order
              _albumOrder(),

              //video order
              _videoOrder(),
            ],
          ),
        ),
      ),
    );
  }

  Container _headerPart() {
    return Container(
      margin: const EdgeInsets.all(14),
      padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent),
          borderRadius: BorderRadius.all(Radius.circular(14))
        ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: const Text(
              'Sharq Club',
              style: TextStyle(
                  color: Colors.cyanAccent,
                  fontSize: 40.0,

                  fontWeight: FontWeight.bold),
            ),
          ),

        ],
      ),
    );
  }

  // Container _carOrder() {
  //   return Container(
  //     margin: EdgeInsets.all(4),
  //     padding: EdgeInsets.all(4),
  //     decoration: BoxDecoration(
  //         color: Colors.blue.shade600,
  //         borderRadius: BorderRadius.all(Radius.circular(20))),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         Text(
  //           'Cars',
  //           style: TextStyle(
  //               color: Colors.white,
  //               fontSize: 30.0,
  //               fontWeight: FontWeight.bold),
  //         ),
  //         Card(
  //           child: ListTile(
  //             onTap: () {
  //               Navigator.push(context,
  //                   MaterialPageRoute(builder: (_) => CarServicePage()));
  //             },
  //             style: ListTileStyle.list,
  //             leading: Icon(Icons.car_crash_outlined),
  //             trailing: Icon(Icons.arrow_forward_ios_rounded),
  //             title: Text('New Cars For Your Wedding Days'),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  Container _photoStudioOrder() {
    return Container(
      margin: EdgeInsets.all(4),
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Photo Studio',
            style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                fontWeight: FontWeight.bold),
          ),
          Card(
            child: ListTile(
              onTap: () {
                print("Service page dagi customer ID: ${widget.customerId}");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => PhotoStudioHomePage(
                              customerId: widget.customerId,
                            )));
              },
              style: ListTileStyle.list,
              leading: Icon(Icons.photo),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
              title: Text('Photo Studio For Your Wedding Days'),
            ),
          )
        ],
      ),
    );
  }

  Container _clubOrder() {
    return Container(
      margin: EdgeInsets.all(4),
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: Colors.blue.shade600,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Club',
            style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                fontWeight: FontWeight.bold),
          ),
          Card(
            child: ListTile(
              onTap: () {
                print("Service page dagi customer ID: ${widget.customerId}");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ClubHomePage(
                              customerId: widget.customerId,
                            )));
              },
              style: ListTileStyle.list,
              leading: Icon(Icons.photo),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
              title: Text('Club For Your Wedding Days'),
            ),
          )
        ],
      ),
    );
  }

  Container _albumOrder() {
    return Container(
      margin: EdgeInsets.all(4),
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Album',
            style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                fontWeight: FontWeight.bold),
          ),
          Card(
            child: ListTile(
              onTap: () {
                print("Service page dagi customer ID: ${widget.customerId}");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => AlbumHomePage(
                              customerId: widget.customerId,
                            )));
              },
              style: ListTileStyle.list,
              leading: Icon(Icons.photo),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
              title: Text('Album For Your Wedding Days'),
            ),
          )
        ],
      ),
    );
  }
  Container _videoOrder() {
    return Container(
      margin: EdgeInsets.all(4),
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: Colors.blue.shade600,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Video Studio',
            style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                fontWeight: FontWeight.bold),
          ),
          Card(
            child: ListTile(
              onTap: () {
                print("Service page dagi customer ID: ${widget.customerId}");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => VideoHomePage(
                          customerId: widget.customerId,
                        )));
              },
              style: ListTileStyle.list,
              leading: Icon(Icons.photo),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
              title: Text('Video For Your Wedding Days'),
            ),
          )
        ],
      ),
    );
  }
}

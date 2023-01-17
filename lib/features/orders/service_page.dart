import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:sharq_crm/features/orders/presentation/page/car/car_service_page.dart';

import '../services/photo_studio/presentation/page/photostudio_home_page.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({Key? key}) : super(key: key);

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
              Container(
                margin: const EdgeInsets.all(4),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: Colors.blue.shade600,
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      '"Sharq Club" services',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Card(
                      child: Column(
                        children: <Widget>[
                          // new Image.network('https://i.ytimg.com/vi/fq4N0hgOWzU/maxresdefault.jpg'),
                          Padding(
                              padding: EdgeInsets.all(7.0),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(7.0),
                                    child: Icon(Icons.add_a_photo),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(7.0),
                                    child: Icon(Icons.car_crash_outlined),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(7.0),
                                    child: Icon(Icons.car_crash_outlined),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(7.0),
                                    child: Text('Comments',
                                        style: TextStyle(fontSize: 18.0)),
                                  )
                                ],
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
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
                      '"Car" service',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => CarServicePage()));
                        },
                        style: ListTileStyle.list,
                        leading: Icon(Icons.car_crash_outlined),
                        trailing: Icon(Icons.arrow_forward_ios_rounded),
                        title: Text('New Cars For Your Wedding Days'),
                      ),
                    )
                  ],
                ),
              ),
              Container(
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
                      '"Photo Studio" service',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => PhotoStudioHomePage()));
                        },
                        style: ListTileStyle.list,
                        leading: Icon(Icons.photo),
                        trailing: Icon(Icons.arrow_forward_ios_rounded),
                        title: Text('Photo Studio For Your Wedding Days'),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/features/orders/presentation/bloc/car_bloc/car_bloc.dart';
import 'package:sharq_crm/features/orders/presentation/bloc/car_bloc/car_state.dart';
import 'package:sharq_crm/features/orders/presentation/page/car/car_page.dart';
import 'package:sharq_crm/features/orders/presentation/page/car/car_service_page.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({Key? key}) : super(key: key);

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarBloc, CarStates>(builder: (context, carState) {
      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(4),
                  padding: new EdgeInsets.all(4),
                  decoration: new BoxDecoration(
                      color: Colors.blue.shade600,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '"Sharq Club" services',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold),
                      ),
                      new Card(
                        child: new Column(
                          children: <Widget>[
                            // new Image.network('https://i.ytimg.com/vi/fq4N0hgOWzU/maxresdefault.jpg'),
                            new Padding(
                                padding: new EdgeInsets.all(7.0),
                                child: new Row(
                                  children: <Widget>[
                                    new Padding(
                                      padding: new EdgeInsets.all(7.0),
                                      child: new Icon(Icons.add_a_photo),
                                    ),
                                    new Padding(
                                      padding: new EdgeInsets.all(7.0),
                                      child: new Icon(Icons.car_crash_outlined),
                                    ),
                                    new Padding(
                                      padding: new EdgeInsets.all(7.0),
                                      child: new Icon(Icons.car_crash_outlined),
                                    ),
                                    new Padding(
                                      padding: new EdgeInsets.all(7.0),
                                      child: new Text('Comments',
                                          style: new TextStyle(fontSize: 18.0)),
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
                  padding: new EdgeInsets.all(4),
                  decoration: new BoxDecoration(
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
                      new Card(
                        child: ListTile(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>CarServicePage()));
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
                  padding: new EdgeInsets.all(4),
                  decoration: new BoxDecoration(
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
                      new Card(
                        child: ListTile(
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
                  padding: new EdgeInsets.all(4),
                  decoration: new BoxDecoration(
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
                      new Card(
                        child: ListTile(
                          style: ListTileStyle.list,
                          leading: Icon(Icons.car_crash_outlined),
                          trailing: Icon(Icons.arrow_forward_ios_rounded),
                          title: Text('New Cars For Your Wedding Days'),
                        ),
                      )
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),

        // Column(
        //   children: [
        //     // Spacer(),
        //      _card(size),
        //      ElevatedCardExample(),
        //       FilledCardExample(),
        //
        //     OutlinedCardExample(),
        //
        //     Spacer(),
        //   ],
        // ),
      );
    });
  }
}

class ElevatedCardExample extends StatelessWidget {
  const ElevatedCardExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Card(
        child: SizedBox(
          width: 190,
          height: 100,
          child: Center(child: Text('Elevated Card')),
        ),
      ),
    );
  }
}

class FilledCardExample extends StatelessWidget {
  const FilledCardExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 0,
        color: Theme.of(context).colorScheme.surfaceVariant,
        child: const SizedBox(
          width: 300,
          height: 100,
          child: Center(child: Text('Filled Card')),
        ),
      ),
    );
  }
}

class OutlinedCardExample extends StatelessWidget {
  const OutlinedCardExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: const SizedBox(
          width: 300,
          height: 100,
          child: Center(child: Text('Outlined Card')),
        ),
      ),
    );
  }
}

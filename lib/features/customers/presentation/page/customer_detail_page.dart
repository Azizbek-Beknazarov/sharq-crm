import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sharq_crm/features/customers/domain/entity/customer_entity.dart';
import 'package:sharq_crm/features/orders/presentation/bloc/car_bloc/car_bloc.dart';
import 'package:sharq_crm/features/orders/presentation/bloc/car_bloc/car_state.dart';
import 'package:sharq_crm/features/orders/presentation/page/car/car_page.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerDetailPage extends StatefulWidget {
  const CustomerDetailPage({Key? key, required this.customer})
      : super(key: key);
  final CustomerEntity customer;

  @override
  State<CustomerDetailPage> createState() => _CustomerDetailPageState();
}

class _CustomerDetailPageState extends State<CustomerDetailPage> {
  @override
  Widget build(BuildContext context) {
    DateTime time = DateTime.parse(widget.customer.dateOfSignUp.toString());
    return BlocBuilder<CarBloc, CarStates>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.customer.name),
          centerTitle: true,
        ),
        body: Container(
          child: Center(
            child: Column(
              children: [
                _customerPhone(widget.customer.phone),
                Text(widget.customer.id),
                Text(time.toString()),
              ],
            ),
          ),
        ),
        floatingActionButton: _floatingActionButton(),
      );
    });
  }

  //1
  _floatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        MaterialPageRoute route = MaterialPageRoute(
            builder: (_) => CarPage(
                  customer: widget.customer,
                ));
        Navigator.push(context, route);
      },
      child: Icon(Icons.add),
    );
  }

  Widget _customerPhone(String phone) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
        padding: EdgeInsets.all(2),
        alignment: Alignment.center,
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 3),
            color: Colors.amber.shade300,
            borderRadius: BorderRadius.all(Radius.circular(11))),
        child: GestureDetector(
          onTap: ()async{
            final Uri phoneUrl = Uri(
              scheme: 'tel',
              path: phone.toString(),
            );
            if(await canLaunchUrl(phoneUrl)){
              launchUrl(phoneUrl);
            }else{
              throw 'Could not launch $phoneUrl :(';
            }
          },
          child: Text(
            phone,
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ),
    );
  }
}

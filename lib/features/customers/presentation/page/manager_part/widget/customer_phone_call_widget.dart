import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entity/customer_entity.dart';




class CustomerCallWidget extends StatelessWidget {
   CustomerCallWidget({Key? key,required this.customer}) : super(key: key);
   CustomerEntity customer;
  @override
  Widget build(BuildContext context) {
    return _customerPhone(customer.phone);
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
          onTap: () async {
            // final Uri phoneUrl = Uri(
            //   scheme: 'tel',
            //   path: phone.toString(),
            // );
            // if (await canLaunchUrl(phoneUrl)) {
            //   launchUrl(phoneUrl);
            // } else {
            //   throw 'Could not launch $phoneUrl :(';
            // }
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

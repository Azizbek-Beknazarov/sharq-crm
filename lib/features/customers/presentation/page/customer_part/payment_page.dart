import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Payment Page'),),
      body: ListView(
        children: [
          Text('Tulov amalga oshiriladi, plastik karta malumotlari kiritiladi.'),
          TextButton(onPressed: (){

          }, child: Text('Tulash'))
        ],
      ),
    );
  }
}

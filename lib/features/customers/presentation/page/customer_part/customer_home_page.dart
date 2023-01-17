import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sharq_crm/features/customers/presentation/page/customer_part/payment_page.dart';
import 'package:sharq_crm/features/orders/service_page.dart';

class CustomerHomePage extends StatefulWidget {
  const CustomerHomePage({Key? key}) : super(key: key);

  @override
  State<CustomerHomePage> createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Customer Home Page'),leading: IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (ctx)=>ServicePage()));},icon: Icon(Icons.home_repair_service),),),
      body: ListView(
        children: [
          Text('mijoz qilgan zakazlar buladi'),
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (ctx)=>PaymentPage()));
          }, child: Text('tulov qilish'))
        ],
      ),
    );
  }
}

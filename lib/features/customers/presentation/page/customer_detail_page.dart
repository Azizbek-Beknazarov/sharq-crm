import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sharq_crm/features/customers/data/model/customer_model.dart';

class CustomerDetailPage extends StatefulWidget {
  const CustomerDetailPage({Key? key, required this.customer})
      : super(key: key);
  final CustomerModel customer;

  @override
  State<CustomerDetailPage> createState() => _CustomerDetailPageState();
}

class _CustomerDetailPageState extends State<CustomerDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.customer.name),
      ),
      body: Center(
        child: Text(widget.customer.id),
      ),
    );
  }
}

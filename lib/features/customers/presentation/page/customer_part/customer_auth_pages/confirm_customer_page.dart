import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sharq_crm/features/customers/presentation/page/customer_part/customer_home_page.dart';
import 'package:sharq_crm/features/orders/service_page.dart';

class ConfirmationPageCustomer extends StatelessWidget {
  ConfirmationPageCustomer({Key? key}) : super(key: key);
  TextEditingController _confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              decoration: InputDecoration(
                  hintText: 'Enter code from SMS which shared you', border: OutlineInputBorder()),
              controller: _confirmController,
            ),
            Divider(
              color: Colors.black,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (_) => CustomerHomePage()),
                      (route) => false);
                },
                child: Text('Sign Up!')),
          ],
        ),
      ),
    );
  }
}

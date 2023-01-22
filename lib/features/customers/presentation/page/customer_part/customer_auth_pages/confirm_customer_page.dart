import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sharq_crm/features/customers/presentation/page/customer_part/customer_home_page.dart';
import 'package:sharq_crm/features/orders/service_page.dart';

class ConfirmationPageCustomer extends StatefulWidget {
  ConfirmationPageCustomer({Key? key, required this.verificationId})
      : super(key: key);
  final String verificationId;

  @override
  State<ConfirmationPageCustomer> createState() =>
      _ConfirmationPageCustomerState();
}

class _ConfirmationPageCustomerState extends State<ConfirmationPageCustomer> {
  TextEditingController _confirmController = TextEditingController();
  final auth = FirebaseAuth.instance;

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
                  hintText: 'Enter code from SMS which shared you',
                  border: OutlineInputBorder()),
              controller: _confirmController,
            ),
            Divider(
              color: Colors.black,
            ),
            ElevatedButton(
                onPressed: () async{
                  final credential = PhoneAuthProvider.credential(
                      verificationId: widget.verificationId,
                      smsCode: _confirmController.text.trim().toString());
                  try{
                    await auth.signInWithCredential(credential);
                  }catch(e){}


                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => CustomerHomePage()),
                      (route) => false);
                },
                child: Text('Sign Up!')),
          ],
        ),
      ),
    );
  }
}

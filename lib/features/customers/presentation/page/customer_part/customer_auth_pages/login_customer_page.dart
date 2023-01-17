import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sharq_crm/features/customers/presentation/page/customer_part/customer_auth_pages/signup_customer_page.dart';
import 'package:sharq_crm/features/customers/presentation/page/customer_part/customer_home_page.dart';
import 'package:sharq_crm/features/orders/service_page.dart';


class LogInCustomerPage extends StatelessWidget {
  LogInCustomerPage({Key? key}) : super(key: key);
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          verticalDirection: VerticalDirection.down,
          children: [
            TextFormField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(

                  hintText: 'Phone', border: OutlineInputBorder()),
              controller: _phoneController,
            ),
            Divider(
              color: Colors.black,
            ),
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                  hintText: 'Password', border: OutlineInputBorder()),
              controller: _passController,
            ),
            Divider(
              color: Colors.black,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => CustomerHomePage()),
                      (route) => false);
                },
                child: Text('Log In!')),
            Row(
              children: [
                Text('Have not a account?'),
                TextButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (_) => SignUpCustomerPage()),
                          (route) => false);
                    },
                    child: Text('Sign Up'))
              ],
            )
          ],
        ),
      ),
    );
  }
}

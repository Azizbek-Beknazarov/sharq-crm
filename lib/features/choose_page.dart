import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sharq_crm/features/splash_screen.dart';

import 'customers/presentation/page/customer_auth_pages/login_customer_page.dart';

class ChoosePage extends StatelessWidget {
  const ChoosePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => SplashScreen()));
                  },
                  child: Text('Log in as Manager!')),
              Divider(
                height: 10,
                thickness: 2,
                color: Colors.black,
              ),
              ElevatedButton(
                  onPressed: () { Navigator.push(context,
                      MaterialPageRoute(builder: (_) => LogInCustomerPage()));}, child: Text('Log in as Customer!')),
            ],
          ),
        ),
      ),
    );
  }
}
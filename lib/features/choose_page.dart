import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sharq_crm/features/customers/presentation/page/customer_part/customer_auth_pages/signup_customer_page.dart';
import 'package:sharq_crm/features/splash_screen.dart';
import 'package:sharq_crm/features/splash_screen_for_customer.dart';

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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(

                        shape: CircleBorder(),
                        padding: EdgeInsets.all(24),
                        backgroundColor:
                        Colors.green
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => SplashScreen()));
                    },
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "Manager sifatida tizimga kirish: ",
                    style: TextStyle(
                        decoration: TextDecoration.overline,
                        color: Colors.green,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Divider(
                height: 10,
                thickness: 2,
                color: Colors.black,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Mijoz sifatida tizimga kirish: ",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.green,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(24),
                        backgroundColor:
                    Colors.green
                    ),

                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (_) => SplashScreenForCustomer()));
                    },
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

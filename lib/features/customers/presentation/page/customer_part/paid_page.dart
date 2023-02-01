import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/features/customers/presentation/page/customer_part/arxiv_page.dart';

import '../../../../../core/util/snackbar_message.dart';
import '../../bloc/customer_cubit.dart';
import 'customer_auth_pages/sign_in_customer_page.dart';
import 'customer_home_page.dart';

class PaidCustomerPage extends StatefulWidget {
  PaidCustomerPage({Key? key, required this.customerId}) : super(key: key);
  final String customerId;

  @override
  State<PaidCustomerPage> createState() => _PaidCustomerPageState();
}

class _PaidCustomerPageState extends State<PaidCustomerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(child: Text('Hali to\'lov qilingan zakzlar mavjud emas'),),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Stack(
                children: [
                  Positioned(
                    bottom: 8.0,
                    left: 4.0,
                    child: Text(
                      widget.customerId,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.red,
                image: DecorationImage(
                  image: AssetImage('assets/images/salut.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Bosh sahifa"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (ctx) =>
                    CustomerHomePage(customerId: widget.customerId)));
              },
            ),
            ListTile(
              leading: Icon(Icons.monetization_on_outlined),
              title: Text("To\'lov qilinganlar"),
              onTap: () {
                // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>PaidCustomerPage()),
                //         (route) => false);
              },
            ),
            ListTile(
              leading: Icon(Icons.grid_3x3_outlined),
              title: Text("Arxivlar"),
              onTap: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                    builder: (_) =>
                        ArxivCustomerPage(customerId: widget.customerId)), (
                    route) => false);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Sozlamalar"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Chiqish"),
              onTap: () {
                //
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title:
                        Text("Accountdan chiqish"),
                        content: Text(
                            'Siz rostdan ham ketyapsizmi?'),
                        icon: Icon(
                          Icons.warning,
                          color: Colors.yellow,
                        ),
                        actions: [
                          OutlinedButton(
                              onPressed: () {
                                Navigator.pop(
                                    context);
                              },
                              child: Text('Yo\'q')),
                          OutlinedButton(
                              onPressed: () {

                                BlocProvider.of<CustomerCubit>(context).logOutCustomer();
                                print("cus ID: ${widget.customerId}");
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (context) => SignInCustomerPage()),
                                        (route) => false);


                                SnackBarMessage()
                                    .showSuccessSnackBar(
                                    message: 'Accountdan chiqildi',
                                    context:
                                    context);



                              },
                              child: Text("Ha")),
                        ],
                      );
                    });
                //
              },
            )
          ],
        ),
      ),
    );
  }
}

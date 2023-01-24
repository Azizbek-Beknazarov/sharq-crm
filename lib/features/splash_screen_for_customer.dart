import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/features/customers/presentation/bloc/customer_cubit.dart';
import 'package:sharq_crm/features/customers/presentation/bloc/customer_state.dart';
import 'package:sharq_crm/features/customers/presentation/page/customer_part/customer_home_page.dart';
import 'package:sharq_crm/features/customers/presentation/page/manager_part/customers_page.dart';

import '../core/util/constants.dart';
import '../core/util/loading_widget.dart';
import 'auth/presentation/bloc/m_auth_bloc.dart';
import 'customers/presentation/page/customer_part/customer_auth_pages/signup_customer_page.dart';
import 'package:sharq_crm/features/injection_container.dart' as di;

class SplashScreenForCustomer extends StatefulWidget {
  @override
  _SplashScreenForCustomerState createState() => _SplashScreenForCustomerState();
}

class _SplashScreenForCustomerState extends State<SplashScreenForCustomer> {
  @override
  Widget build(BuildContext context) {
    return    BlocProvider<CustomerCubit>(
         create: (_) => di.sl<CustomerCubit>()..getCurrentCustomerEvent(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocListener<CustomerCubit, CustomersState>(
          listener: (context, state) {
            Timer(Duration(seconds: 1), () {
              if (state is CustomerGetLoadedState) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (ctx) => CustomerHomePage(
                    )),
                        (_) => false);
              } else if (state is CustomerEmpty) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) => SignUpCustomerPage()),
                        (_) => false);
              }
            });
          },
          child: _buildSplashScreen(),
        ),
      ),
       );


  }

  Column _buildSplashScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Center(
            child: Image.asset(
              'assets/images/logo.png',
              width: 400,
              height: 400,
            )),
        LoadingWidget(
          color: primaryColor,
        )
      ],
    );
  }
}

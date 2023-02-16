import 'dart:async';
import 'package:sharq_crm/core/util/snackbar_message.dart';
import 'package:sharq_crm/features/injection_container.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/features/auth/presentation/page/sign_in_page.dart';
import 'package:sharq_crm/features/customers/presentation/page/manager_part/customers_page.dart';

import '../core/util/constants.dart';
import '../core/util/loading_widget.dart';
import 'auth/presentation/bloc/m_auth_bloc.dart';
import 'customers/presentation/page/customer_part/customer_auth_pages/signup_customer_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                Timer(Duration(seconds: 1), () {
                  if (state is LoadedManagerState) {
                    print("::::auth state is ${state.toString()}");
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => CustomersPage()),
                            (_) => false);
                  } else if (state is AuthInitial) {
                    print("::::auth state is ${state.toString()}");
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: ( context)=>SignUpCustomerPage()//SignInPage()
                        ),
                            (_) => false);
                  }
                });
              },

        child: _buildSplashScreen(),

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

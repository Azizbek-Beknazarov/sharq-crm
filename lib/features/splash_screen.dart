import 'dart:async';
import 'package:sharq_crm/features/injection_container.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/features/auth/presentation/page/sign_in_page.dart';
import 'package:sharq_crm/features/customers/presentation/page/manager_part/customers_page.dart';

import '../core/util/constants.dart';
import '../core/util/loading_widget.dart';
import 'auth/presentation/bloc/m_auth_bloc.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create:   (context)=>di.sl<AuthBloc>()..add(GetCurrentManagerEvent()),
      child: Scaffold(
            backgroundColor: Colors.white,
            body: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                Timer(Duration(seconds: 1), () {
                  if (state is LoadedManagerState) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (ctx) => CustomersPage()),
                            (_) => false);
                  } else if (state is AuthInitial) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: ( context) => SignInPage()),
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

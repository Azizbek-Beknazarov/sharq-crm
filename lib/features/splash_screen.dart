import 'dart:async';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/features/customers_page.dart';

import '../core/util/constants.dart';
import '../core/util/loading_widget.dart';
import 'auth/presentation/bloc/m_auth_bloc.dart';
import 'auth/presentation/page/sign_up_page.dart';





class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          Timer(Duration(seconds: 2), () {
            if (state is LoadedManagerState) {
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx)=>CustomersPage()),(_)=>false);
              // Navigator.of(context).pushReplacement(MaterialPageRoute(
              //     builder: (BuildContext context) => BlocProvider<GetCarBloc>(
              //       create: (context) =>
              //       sl<GetCarBloc>()..add(GetAllCarEvent()),
              //       child: CarListPage(),
              //     )));
            } else if (state is AuthInitial) {
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                  builder: (BuildContext context) => SignUpPage()),(_)=>false);
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
        Center(child: Image.asset('assets/images/logo.png', width: 400,height: 400,)),
        LoadingWidget(
          color: primaryColor,
        )
      ],
    );
  }
}

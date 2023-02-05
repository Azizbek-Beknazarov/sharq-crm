import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/features/auth/presentation/bloc/m_auth_bloc.dart';
import 'package:sharq_crm/features/auth/presentation/page/reset_pass.dart';
import 'package:sharq_crm/features/auth/presentation/widget/sign_in_page/sign_in_form.dart';

import '../../../../core/util/constants.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildHeader(),
                  SignInForm(),
                  _resetPassword(context)
                ],
              ),
            ),
          ),
        ),
      );

  }

  Row _resetPassword(BuildContext context) {
    return Row(
      children: [
        TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => EmailVerificationPage()));
            },
            child: Text(
              "Parolni qayta tiklash",
            )),
      ],
    );
  }

  Column _buildHeader() {
    return Column(
      children: [
        const SizedBox(height: 80),
        buildLogo(),
        const SizedBox(height: 10),
        RichText(
          text: TextSpan(
              text: "Sharq",
              style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
              children: [
                TextSpan(
                    text: "Club",
                    style: TextStyle(
                        color: secondaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20))
              ]),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget buildLogo() {
    return Container(
      height: 300,
      width: 300,
      child: Center(child: Image.asset("assets/images/logo.png")),
    );
  }
}

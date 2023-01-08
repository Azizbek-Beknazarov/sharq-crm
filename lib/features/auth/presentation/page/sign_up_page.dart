import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sharq_crm/features/auth/presentation/page/sign_in_page.dart';

import '../../../../core/util/constants.dart';
import '../widget/sign_up_page/sign up_form.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height - 20,
                child: Center(
                  child: Column(
                    children: <Widget>[
                      _buildHeader(),
                      _buildForm(),
                    ],
                  ),
                ),
              ),
              _buildSignInButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignInButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text('Already here  ?',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        GestureDetector(
          onTap: () {
            Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(builder: (ctx) => SignInPage()),(_)=>false);
          },
          child: Text(' Sign In !',
              style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold)),
        )
      ],
    );
  }

  Padding _buildForm() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: SignUpForm(),
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

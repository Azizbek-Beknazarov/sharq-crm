import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sharq_crm/features/auth/presentation/page/reset_pass.dart';
import 'package:sharq_crm/features/auth/presentation/page/sign_in_page.dart';

class EmailVerificationPage extends StatefulWidget {
  EmailVerificationPage({Key? key}) : super(key: key);

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  String? email;
  final _formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;

  bool isEmail(String textEmail) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(textEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email_outlined),
                      labelText: 'Email',
                    ),
                    validator: (value) {
                      //
                      if (value!.isEmpty) {
                        return 'Iltimos, emailingizni kiriting!';
                      } else if (!isEmail(value)) {
                        return 'Email noto\'g\'ri kiritilgan';
                      }

                      return null;
                    },
                    onChanged: (val) {
                      setState(() {
                        email = val;
                      });
                    },
                    keyboardType: TextInputType.emailAddress,
                  ),
                  ElevatedButton(onPressed: () async{
                    if (_formKey.currentState!.validate()) {
                      await auth.sendPasswordResetEmail(email: email!.trim());
                      Navigator.push(context, MaterialPageRoute(builder: (ctx)=>SignInPage()));

                    }



                  }, child: Text('Tasdiqlash')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

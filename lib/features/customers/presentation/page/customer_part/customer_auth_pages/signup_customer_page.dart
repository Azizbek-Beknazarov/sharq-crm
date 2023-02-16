import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/features/customers/presentation/page/customer_part/customer_auth_pages/confirm_customer_page_for_signup.dart';
import 'package:sharq_crm/features/customers/presentation/page/customer_part/customer_auth_pages/sign_in_customer_page.dart';

import '../../../../../../core/util/build_logo_widget.dart';

import '../../../../../auth/presentation/page/sign_in_page.dart';
import '../../../bloc/customer_cubit.dart';
import '../../../bloc/customer_state.dart';

class SignUpCustomerPage extends StatefulWidget {
  SignUpCustomerPage({Key? key}) : super(key: key);

  @override
  State<SignUpCustomerPage> createState() => _SignUpCustomerPageState();
}

class _SignUpCustomerPageState extends State<SignUpCustomerPage> {
  TextEditingController _nameController = TextEditingController();

  TextEditingController _phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance; //I need make this clean code :)
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerCubit, CustomersState>(
        builder: (context, state) {
      return Form(
        key: _formKey,
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  verticalDirection: VerticalDirection.down,
                  children: [
                    BuildLogoWidget(),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Iltimos, ismingizni kiriting!';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          hintText: 'Ism', border: OutlineInputBorder()),
                      controller: _nameController,
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Iltimos, telefon raqamingizni kiriting!';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          hintText: '+998945678090',
                          border: OutlineInputBorder()),
                      controller: _phoneController,
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(Colors.green)),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            String name = _nameController.text.trim();

                            await auth.verifyPhoneNumber(
                                //
                                phoneNumber: _phoneController.text.trim(),
                                //
                                timeout: const Duration(seconds: 10),
                                //
                                verificationCompleted: (_) async {
                                  setState(() {
                                    loading = false;
                                  });
                                },
                                verificationFailed: (e) {
                                  setState(() {
                                    loading = false;
                                  });
                                },
                                codeSent:
                                    (String verificationId, int? token) async {
                                  setState(() {
                                    loading = false;
                                  });

                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (ctx) =>
                                              ConfirmationPageCustomer(
                                                  verificationId:
                                                      verificationId,
                                                  name: name,
                                                  loading: loading)),
                                      (route) => false);
                                },
                                codeAutoRetrievalTimeout: (_) {});
                          }
                        },
                        child: Text('Ro\'yxatdan o\'tish')),
                    // Row(children: [
                    //   Text("Avval ro\'yxatdan o\'tgan bo\'lsangiz:", style: TextStyle(fontWeight: FontWeight.bold),),
                    //   TextButton(onPressed: (){
                    //     Navigator.push(context, MaterialPageRoute(builder: (ctx)=>SignInCustomerPage()));
                    //   }, child: Text('Kirish'))
                    // ],),
                    Row(children: [
                      Text("For managers:", style: TextStyle(fontWeight: FontWeight.bold),),
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (ctx)=>SignInPage()));
                      }, child: Text('LogIn'))
                    ],),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
    ;
  }
}

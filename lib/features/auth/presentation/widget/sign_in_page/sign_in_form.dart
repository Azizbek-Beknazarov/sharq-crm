


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/features/auth/presentation/widget/sign_in_page/sign_in_submit_buttons.dart';
import 'package:sharq_crm/features/customers/presentation/page/manager_part/customers_page.dart';

import '../../../../../core/util/loading_widget.dart';
import '../../../../../core/util/snackbar_message.dart';
import '../../bloc/m_auth_bloc.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();

  String? email;
  String? password;
  bool _obscureText = false;

  SizedBox space = const SizedBox(height: 15);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.email_outlined),
              labelText: 'Email',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter some Email';
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
          space,
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
              ),
            ),
            onChanged: (val) {
              setState(() {
                password = val;
              });
            },
            obscureText: !_obscureText,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter some Password';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 40,
          ),
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthErrorState) {
                SnackBarMessage().showErrorSnackBar(
                    message: state.message, context: context);
              } else if (state is AuthErrorState) {
                SnackBarMessage().showSuccessSnackBar(
                    message: state.message, context: context);
              } else if (state is LoadedManagerState) {
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx)=>CustomersPage()),(_)=>false);
                // Navigator.pushAndRemoveUntil(
                //     context,
                //     MaterialPageRoute(
                //         builder: (ctx) => BlocProvider<GetCarBloc>(
                //           create: (context) =>
                //           sl<GetCarBloc>()..add(GetAllCarEvent()),
                //           child: CarListPage(),
                //         )),
                //         (_) => false);
              }
            },
            builder: (context, state) {
              if (state is AuthLoadingState) {
                return LoadingWidget();
              }
              return SignInSubmitButtons(
                  formKey: _formKey, email: email, password: password);
            },
          )
        ],
      ),
    );
  }
}

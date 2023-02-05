import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/features/customers/presentation/page/manager_part/customers_page.dart';

import '../../bloc/m_auth_bloc.dart';


class SignInSubmitButtons extends StatelessWidget {
  const SignInSubmitButtons({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.email,
    required this.password,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final String? email;
  final String? password;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          width: double.infinity,
          child: ElevatedButton(

            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Map authData = {
                  "email": email,
                  "password": password,
                };
                BlocProvider.of<AuthBloc>(context)
                    .add(LoginManagerEvent(authData));
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>CustomersPage()), (route) => false);
                print(":::: login boldi manager sign in submit buttonda");
              }
            },
            style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)))),
            child: const Text('Kirish'),
          ),
        ),
      ],
    );
  }
}

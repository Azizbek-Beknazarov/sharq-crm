import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/core/util/snackbar_message.dart';
import 'package:sharq_crm/features/auth/presentation/page/sign_in_page.dart';

import 'auth/presentation/bloc/m_auth_bloc.dart';

class CustomersPage extends StatelessWidget {
  const CustomersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body: Center(child: Container(child: Column(
          children: [
            Text('CustomersPage list'),
            ElevatedButton(onPressed: (){
              BlocProvider.of<AuthBloc>(context)
                  .add(LogoutEvent());
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx){return SignInPage();}), (route) => false);
              SnackBarMessage().showSuccessSnackBar(message: 'Chiqildi', context: context);
            }, child: Text('Log out'))
          ],
        ),)),);
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sharq_crm/features/customers/data/model/customer_model.dart';
import 'package:uuid/uuid.dart';

import 'customers/presentation/bloc/new_customer_bloc.dart';
import 'injection_container.dart';

class CustomersPage extends StatelessWidget {
  CustomersPage({Key? key}) : super(key: key);
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerBloc, AddNewCustomerState>(builder: (_, state) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Customers list'),
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        body: Column(
          children: [],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog<void>(context: context, builder: (ctx){
              return Center(
                child: AlertDialog(
                  title: Text('New customer'),
                  content: Column(children: [
                    TextField(controller: nameController,),
                    TextField(controller: phoneController,),
                  ],),
                  actions: [
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: Theme.of(context).textTheme.labelLarge,
                      ),
                      child: const Text('Add'),
                      onPressed: () {
                        var customerModel = CustomerModel(
                            name: nameController.text,
                            phone: phoneController.text,
                            id: uuid.v4());
                        context
                            .read<CustomerBloc>()
                            .add(AddCustomerEvent(customerModel));
                        // SnackBarMessage().showSuccessSnackBar(message: 'New Customer added',context: context);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                )
              );
            });



          },
          child: Icon(Icons.add),
        ),
      );
    });

    BlocProvider<CustomerBloc>(
        create: (_) => sl<CustomerBloc>(),
        child: Center(
          child: BlocBuilder<CustomerBloc, AddNewCustomerState>(
              builder: (_, state) {
            return Scaffold(
                appBar: AppBar(),
                body: Column(
                  children: [
                    TextField(
                      controller: nameController,
                    ),
                    TextField(
                      controller: phoneController,
                    ),
                    IconButton(
                        onPressed: () {
                          var customerModel = CustomerModel(
                              name: nameController.text,
                              phone: phoneController.text,
                              id: uuid.v4());
                          context
                              .read<CustomerBloc>()
                              .add(AddCustomerEvent(customerModel));
                          // BlocProvider.of<AddNewCustomerCubit>(context).addNewCustomer(customerModel);
                        },
                        icon: Icon(Icons.add)),
                  ],
                ));
          }),
        ));
  }
}

// return BlocBuilder(builder: (BuildContext context, state){ return Text('dssdsfsdf');});

//   Scaffold(
//   appBar: AppBar(),
//   body: Column(children: [
//     TextField(controller: nameController,),
//     TextField(controller: phoneController,),
//     BlocBuilder(builder: (BuildContext  context, state){
//       return Center(child: CircularProgressIndicator(),);
//     })
//   ],),
// );
//   }
// }

// class App extends StatelessWidget {
//    App({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container() ;
//   }
// }

//     if (state is CubitCustomerAdded) {
//       return Container(
//           child: Column(
//             children: [
//             TextField(
//             controller: nameController,
//
//           ), TextField(
//         controller: phoneController,
//
//       ),
//           IconButton(
//               onPressed: () {
//                 var customerModel = CustomerModel(
//                     name: nameController.text,
//                     phone: phoneController.text,
//                     id: 'iddi');
//                 context.read<AddNewCustomerCubit>().addNewCustomer(
//                     customerModel);
//                 // BlocProvider.of<AddNewCustomerCubit>(context).addNewCustomer(customerModel);
//               },
//               icon: Icon(Icons.add)),
//
//           return Center(child: CircularProgressIndicator(),);
// }
//   ,
//   );
//

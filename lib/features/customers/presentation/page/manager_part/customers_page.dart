import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/features/customers/presentation/bloc/customer_state.dart';
import 'package:sharq_crm/features/orders/service_page.dart';
import 'package:uuid/uuid.dart';
import '../../../domain/entity/customer_entity.dart';
import '../../bloc/customer_cubit.dart';
import 'widget/customer_list.dart';

class CustomersPage extends StatefulWidget {
  CustomersPage({Key? key}) : super(key: key);

  @override
  State<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  TextEditingController nameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  final uuid = Uuid();
  List<CustomerEntity> customersList = [];

  //
  @override
  void setState(VoidCallback fn) {
    context.read<CustomerCubit>().loadCustomer();
    print('page ichida loadCustomer() chaqirildi.}');
    super.setState(fn);
  }

  //
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerCubit, CustomersState>(
        builder: (context, customerCubitstate) {
      if (customerCubitstate is CustomerLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (customerCubitstate is CustomerAddedState) {

      } else if (customerCubitstate is CustomerError) {
        return Center(
          child: Text(customerCubitstate.message),
        );
      } else if (customerCubitstate is CustomersLoaded) {
        customersList = customerCubitstate.customersLoaded;
      }
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              var customerId=customersList.map((e) {
                String? idd=e.customerId;
                return idd;
              }).toString();
              print("object::: customerId: ${customerId}");
              // Navigator.push(context, MaterialPageRoute(builder: (_)=>ServicePage(customerId: customerId,)));
            },
            icon: Icon(Icons.arrow_forward_ios_rounded),
          ),
          title: Text('Customers'),
          centerTitle: true,
        ),
        body: CustomerList(
          customersList: customersList,
        ),

        //
        floatingActionButton: _floatingCarAdd(context),
      );
    });
  }

  // method 1
  Widget _floatingCarAdd(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog<void>(
            context: context,
            builder: (ctx) {
              return Center(
                  child: AlertDialog(
                title: Text('New customer'),
                content: Column(
                  children: [
                    TextField(
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        labelText: 'Name',
                      ),
                      controller: nameController,
                    ),
                    TextField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.phone),
                        labelText: 'Phone',
                      ),
                      controller: phoneController,
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: const Text('Add'),
                    onPressed: () {
                      var customerEntity = CustomerEntity(

                          name: nameController.text,
                          phone: phoneController.text,
                          dateOfSignUp: DateTime.now().millisecondsSinceEpoch,
                          customerId: uuid.v4(), managerAdded: true);

                      setState(() {
                        context
                            .read<CustomerCubit>()
                            .addNewCustomer(customerEntity);
                        nameController.clear();
                        phoneController.clear();
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ));
            });
      },
      child: Icon(Icons.add),
    );
  }
}

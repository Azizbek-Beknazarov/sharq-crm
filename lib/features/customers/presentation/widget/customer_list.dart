import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/features/customers/domain/entity/customer_entity.dart';

import 'package:sharq_crm/features/customers/presentation/bloc/customer_cubit.dart';
import 'package:sharq_crm/features/customers/presentation/bloc/customer_state.dart';


import '../page/customer_detail_page.dart';


class CustomerList extends StatefulWidget {
  CustomerList({
    Key? key,
  }) : super(key: key);
  TextEditingController nameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  List<CustomerEntity> customers = [];
  @override
  void setState(VoidCallback fn) {
    context.read<CustomerCubit>().loadCustomer();
    print('customer list ichida loadCustomer() chaqirildi.}');
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerCubit, CustomersState>(
        builder: (context, customerCubitstate) {


      if (customerCubitstate is CustomerLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (customerCubitstate is CustomersLoaded) {
        customers = customerCubitstate.customersLoaded;

      } else if (customerCubitstate is CustomerError) {
        return Text(
          customerCubitstate.message,
          style: const TextStyle(color: Colors.white, fontSize: 25),
        );
      }
      return Scaffold(
        body: listViewSeparated(customers, context),

      );
    });
    //
  }

  //
  Widget listViewSeparated(
      List<CustomerEntity> customers, BuildContext context) {
    return ListView.separated(
      itemBuilder: (ctx, index) {
        widget.nameController.text = customers[index].name.toString();
        widget.phoneController.text = customers[index].phone.toString();
        return GestureDetector(
          onDoubleTap: () {
            showDialog(
                context: context,
                builder: (_) {
                  return Center(
                      child: AlertDialog(
                        title: Text('Customer delete !'),
                        content: Text('Are you sure delete this customer?'),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  context
                                      .read<CustomerCubit>()
                                      .deleteCustomer(customers[index].id);
                                });
                                Navigator.pop(context);
                                print('deleted');
                              },
                              child: Text('Yes')),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('No')),
                        ],
                      ));
                });
          },
          onLongPress: () {
            showDialog<void>(
                context: context,
                builder: (ctx) {
                  return Center(
                      child: AlertDialog(
                        title: Text('Update customer'),
                        content: Column(
                          children: [
                            TextField(
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.person),
                                labelText: 'Name',
                              ),
                              controller: widget.nameController,
                            ),
                            TextField(
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.phone),
                                labelText: 'Phone',
                              ),
                              controller: widget.phoneController,
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            style: TextButton.styleFrom(
                              textStyle: Theme.of(context).textTheme.labelLarge,
                            ),
                            child: const Text('Update'),
                            onPressed: () {
                              final customerId = customers[index].id;
                              CustomerEntity entity = CustomerEntity(
                                  name: widget.nameController.text,
                                  phone: widget.phoneController.text,
                                  dateOfSignUp: DateTime.now().toString(),
                                  id: customers[index].id);

                              context
                                  .read<CustomerCubit>()
                                  .updateCustomer(entity, customerId);
                              setState(() {
                                widget.nameController.clear();
                                widget.phoneController.clear();
                              });
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ));
                });
          },
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return CustomerDetailPage(
                customer: customers[index],
              );
            }));
          },
          child: ListTile(
            title: Text(customers[index].name),
            subtitle: Text(customers[index].phone),
          ),
        );
      },
      separatorBuilder: (ctx, index) {
        return Divider(
          color: Colors.grey[400],
        );
      },
      itemCount: customers.length,
    );
  }

//
}

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/features/customers/data/model/customer_model.dart';
import 'package:sharq_crm/features/customers/presentation/bloc/get_customers_cubit/get_cus_cubit.dart';
import 'package:sharq_crm/features/customers/presentation/bloc/get_customers_cubit/get_cus_state.dart';

import '../page/customer_detail_page.dart';

class CustomerList extends StatefulWidget {
  CustomerList({Key? key}) : super(key: key);

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  //
  Widget listViewSeparated(
      List<CustomerModel> customers, BuildContext context) {
    return ListView.separated(
      // controller: scrollController,
      itemBuilder: (ctx, index) {
        return GestureDetector(
          onLongPress: () {
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
  @override
  void setState(VoidCallback fn) {
    context.read<CustomerCubit>().loadCustomer();
    print('customer list ichida loadCustomer() chaqirildi.}');
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerCubit, CustomersState>(
        builder: (context, state) {
      List<CustomerModel> customers = [];

      if (state is CustomerLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is CustomersLoaded) {
        customers = state.customersLoaded;
      } else if (state is CustomerError) {
        return Text(
          state.message,
          style: const TextStyle(color: Colors.white, fontSize: 25),
        );
      }
      return listViewSeparated(customers, context);
    });
  }
}

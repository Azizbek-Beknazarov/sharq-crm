import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/features/customers/data/model/customer_model.dart';
import 'package:sharq_crm/features/customers/presentation/bloc/get_customers_cubit/get_cus_cubit.dart';
import 'package:sharq_crm/features/customers/presentation/bloc/get_customers_cubit/get_cus_state.dart';

class CustomerList extends StatelessWidget {
  CustomerList({Key? key}) : super(key: key);
  final scrollController = ScrollController();

  void setupScrollController(BuildContext context) {

    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {

          context.read<CustomerCubit>().loadCustomer();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    return BlocBuilder<CustomerCubit, CustomersState>(
        builder: (context, state) {
      List<CustomerModel> customers = [];
      bool isLoading = false;

      if (state is CustomerLoading) {
        isLoading = true;
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
      return ListView.separated(
        controller: scrollController,
        itemBuilder: (ctx, index) {

          if (index < customers.length) {
            return ListTile(
              title: Text(customers[index].name),
              subtitle: Text(customers[index].phone),
            );




          } else {
            Timer(const Duration(milliseconds: 30), () {
              scrollController
                  .jumpTo(scrollController.position.maxScrollExtent);
            });
            return Center(child: CircularProgressIndicator(),);
          }


        },
        separatorBuilder: (ctx, index) {
          return Divider(
            color: Colors.grey[400],
          );
        },
        itemCount: customers.length + (isLoading ? 1 : 0),
      );
    });
  }
}

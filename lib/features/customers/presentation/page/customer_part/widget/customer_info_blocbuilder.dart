import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/util/loading_widget.dart';
import '../../../../domain/entity/customer_entity.dart';
import '../../../bloc/customer_cubit.dart';
import '../../../bloc/customer_state.dart';

class CustomerInfoBlocBuilder extends StatelessWidget {
  const CustomerInfoBlocBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<CustomerCubit, CustomersState>(
        builder: (context, customerStatefrom) {
          print(customerStatefrom.toString());
          if (customerStatefrom is CustomerLoading) {
            return LoadingWidget();
          } else if (customerStatefrom is CustomerError) {
            return Text(customerStatefrom.message);
          } else if (customerStatefrom
          is CustomerLoadedFromCollectionState) {
            CustomerEntity currentCustomer = customerStatefrom.entity;

            return _currentCustomerInfo(currentCustomer);
          }
          return LoadingWidget();
        });
  }
  Padding _currentCustomerInfo(CustomerEntity currentCustomer) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
            color: Colors.black12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              currentCustomer.name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              currentCustomer.phone.toString(),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              currentCustomer.customerId.toString(),
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}

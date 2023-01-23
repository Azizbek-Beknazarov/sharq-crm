import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/core/util/loading_widget.dart';
import 'package:sharq_crm/features/customers/presentation/bloc/customer_state.dart';
import 'package:sharq_crm/features/customers/presentation/page/customer_part/payment_page.dart';
import 'package:sharq_crm/features/orders/service_page.dart';

import '../../../domain/entity/customer_entity.dart';
import '../../bloc/customer_cubit.dart';

class CustomerHomePage extends StatefulWidget {
  CustomerHomePage({Key? key}) : super(key: key);

  @override
  State<CustomerHomePage> createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {
  String customerId = '';
  late CustomerEntity currentCustomer;
  @override
  void setState(VoidCallback fn) {
    context.read<CustomerCubit>().getCurrentCustomerEvent();
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<CustomerCubit, CustomersState>(
        builder: (context, customerState) {
      if (customerState is CustomerLoading) {
        print(
            " CustomerHomePagedagi CustomerState: ${customerState.toString()}");
        return Scaffold(
          body: Center(
            child: LoadingWidget(),
          ),
        );
      } else if (customerState is CustomerError) {
        return Scaffold(
          body: Center(
            child: Text(customerState.message.toString()),
          ),
        );
      } else if (customerState is CustomerGetLoadedState) {
        currentCustomer = customerState.getLoadedCustomer;
        customerId = currentCustomer.customerId!;
        print(
            "current customer entity: ${currentCustomer.customerId.toString()}");
      }
      return Scaffold(
        appBar: AppBar(
          title: Text('Customer Home Page'),
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) => ServicePage(
                            customerId: customerId,
                          )));
            },
            icon: Icon(Icons.home_repair_service),
          ),
        ),
        body: ListView(
          children: [
            ListTile(title: Text(currentCustomer.name),subtitle: Text(currentCustomer.phone),),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (ctx) => PaymentPage()));
                },
                child: Text('tulov qilish'))
          ],
        ),
      );
    });
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/core/util/loading_widget.dart';
import 'package:sharq_crm/core/util/snackbar_message.dart';
import 'package:sharq_crm/features/customers/presentation/bloc/customer_state.dart';
import 'package:sharq_crm/features/customers/presentation/page/customer_part/payment_page.dart';
import 'package:sharq_crm/features/orders/service_page.dart';
import 'package:sharq_crm/features/services/photo_studio/domain/entity/photostudio_entity.dart';
import 'package:sharq_crm/features/services/photo_studio/presentation/bloc/photostudio_bloc.dart';
import 'package:sharq_crm/features/services/photo_studio/presentation/bloc/photostudio_event.dart';
import 'package:sharq_crm/features/services/photo_studio/presentation/bloc/photostudio_state.dart';
import 'package:sharq_crm/features/injection_container.dart' as di;

import '../../../domain/entity/customer_entity.dart';
import '../../bloc/customer_cubit.dart';

class CustomerHomePage extends StatefulWidget {
  CustomerHomePage({Key? key}) : super(key: key);

  @override
  State<CustomerHomePage> createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {
  List<PhotoStudioEntity> photoStudioForCustomer = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    String customerId;

    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Home Page'),
        leading: IconButton(
          onPressed: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (ctx) => ServicePage(
            //           customerId: customerId,
            //         )));
          },
          icon: Icon(Icons.home_repair_service),
        ),
      ),
      body: ListView(
        children: [
          BlocProvider<CustomerCubit>(
            create: (_) => di.sl<CustomerCubit>()..getCurrentCustomerEvent(),
            child: Column(
              children: [
                BlocBuilder<CustomerCubit, CustomersState>(
                    builder: (context, customerState) {
                  if (customerState is CustomerLoading) {
                    return LoadingWidget();
                  } else if (customerState is CustomerError) {
                    return Text(customerState.message);
                  } else if (customerState is CustomerGetLoadedState) {
                    CustomerEntity currentCustomer =
                        customerState.getLoadedCustomer;
                    // current customer id getted

                    customerId = currentCustomer.customerId!;
                    print(
                        'loadCustomerFromCollection customerID: ${customerId}');
                    context
                        .read<CustomerCubit>()
                        .loadCustomerFromCollection(customerId);
                  }
                  return BlocBuilder<CustomerCubit, CustomersState>(
                      builder: (context, customerStatefrom) {
                    print(customerStatefrom.toString());
                    if (customerStatefrom is CustomerLoading) {
                      return LoadingWidget();
                    } else if (customerStatefrom is CustomerError) {
                      return Text(customerStatefrom.message);
                    } else if (customerStatefrom
                        is CustomerLoadedFromCollectionState) {
                      CustomerEntity currentCustomer = customerStatefrom.entity;

                      return Container(
                        child: Column(
                          children: [
                            Text(currentCustomer.name),
                            Text(currentCustomer.phone.toString()),
                            Text(currentCustomer.customerId.toString()),
                          ],
                        ),
                      );
                    }
                    return Text('data2');
                  });
                }),
              ],
            ),
          ),

          // ListTile(
          //   title: Text(currentCustomer.name),
          //   subtitle: Text(currentCustomer.phone),
          // ),
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (ctx) => PaymentPage()));
              },
              child: Text('tulov qilish'))
        ],
      ),
    );

    // BlocBuilder<CustomerCubit, CustomersState>(
    //     builder: (context, customerState) {
    //   if (customerState is CustomerLoading) {
    //     print(
    //         " CustomerHomePagedagi CustomerState: ${customerState.toString()}");
    //     return Center(
    //         child: LoadingWidget(),
    //       );
    //
    //   } else if (customerState is CustomerError) {
    //     print(
    //         " CustomerHomePagedagi CustomerState: ${customerState.toString()}");
    //     return  Center(
    //         child: Text(customerState.message.toString()),
    //       );
    //
    //   } else if (customerState is CustomerGetLoadedState) {
    //     print(
    //         " CustomerHomePagedagi CustomerState: ${customerState.toString()}");
    //     currentCustomer = customerState.getLoadedCustomer;
    //     customerId = currentCustomer.customerId!;
    //     print(
    //         "current customer entity: ${currentCustomer.customerId.toString()}");
    //   }
    //
    // });

    //
  }
}

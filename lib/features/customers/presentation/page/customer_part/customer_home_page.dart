import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/features/customers/presentation/bloc/customer_state.dart';
import 'package:sharq_crm/features/customers/presentation/page/customer_part/payment_page.dart';
import 'package:sharq_crm/features/orders/service_page.dart';

import '../../../domain/entity/customer_entity.dart';

class CustomerHomePage extends StatefulWidget {
  const CustomerHomePage({Key? key}) : super(key: key);

  @override
  State<CustomerHomePage> createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {
   List<CustomerEntity> customersLoaded=[];
   late String customerId;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      builder: (context,customerState) {
        if(customerState is CustomerLoading){
          return Scaffold(body: Center(child:  CircularProgressIndicator(),),);
        }else if( customerState is CustomerError){
          return Scaffold(body: Center(child:  Text(customerState.message.toString()),),);
        }else if(customerState is CustomersLoaded){
          customersLoaded=customerState.customersLoaded;
        }
        return Scaffold(
          appBar: AppBar(
            title: Text('Customer Home Page'),
            leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (ctx) => ServicePage(customerId: customerId,)));
              },
              icon: Icon(Icons.home_repair_service),
            ),
          ),
          body: ListView.builder(
            itemCount: customersLoaded.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index){
              if(customersLoaded.isEmpty){
                return Center(child: Text('No data yet'),);

              }

                customerId=customersLoaded[index].id;
              return ListTile(title: Text(customersLoaded[index].name),);
            },




            //
            // children: [
            //   Text('mijoz qilgan zakazlar buladi'),
            //   TextButton(
            //       onPressed: () {
            //         Navigator.push(context,
            //             MaterialPageRoute(builder: (ctx) => PaymentPage()));
            //       },
            //       child: Text('tulov qilish'))
            // ],
          ),
        );
      }
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/features/customers/domain/entity/customer_entity.dart';

import 'package:sharq_crm/features/customers/presentation/bloc/customer_cubit.dart';
import 'package:sharq_crm/features/customers/presentation/page/manager_part/customers_page.dart';

import '../customer_detail_page.dart';
import '../customer_update_page.dart';

enum ActionItems { delete, update }

class CustomerList extends StatefulWidget {
  CustomerList({Key? key, required this.customersList})
      : super(
          key: key,
        );

  List<CustomerEntity> customersList;

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  ActionItems? selectedMenu;

  @override
  void setState(VoidCallback fn) {
    // context.read<CustomerCubit>().loadCustomer();
    // print('list ichida loadCustomer() chaqirildi.}');
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return _listViewSeparated(widget.customersList, context);
    //
  }

  //
  Widget _listViewSeparated(
      List<CustomerEntity> customersList, BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        CustomerEntity customerList = customersList[index];
        print("object::customerId: ${customerList.customerId.toString()}");
        return GestureDetector(
          onDoubleTap: () {},
          onLongPress: () {},
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return CustomerDetailPage(
                customer: customerList,
              );
            }));
          },
          child: ListTile(
            leading: Icon(Icons.person),
            trailing: PopupMenuButton<ActionItems>(
              initialValue: selectedMenu,
              onSelected: (ActionItems item) {
                if (item == ActionItems.update) {
                  _updateCustomer(context, customerList);
                } else if (item == ActionItems.delete) {
                  _deleteCustomer(context, customerList);
                }
              },
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<ActionItems>>[
                PopupMenuItem<ActionItems>(
                  value: ActionItems.update,
                  child: Row(
                    children: [Icon(Icons.update), Text(" yangilash")],
                  ),
                ),
                PopupMenuItem<ActionItems>(
                  value: ActionItems.delete,
                  child: Row(
                    children: [Icon(Icons.delete), Text(" o\'chirish")],
                  ),
                ),
              ],
            ),
            title: Text(customerList.name),
            subtitle: Text(customerList.phone),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Divider(
          color: Colors.grey[400],
        );
      },
      itemCount: customersList.length,
    );
  }

//
  void _deleteCustomer(BuildContext context, CustomerEntity customerList) {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
              child: AlertDialog(
            icon: Icon(Icons.delete_forever),
            title: Text('Mijozni o\'chirish'),
            content: Row(
              children: [
                Text(
                  '${customerList.name}',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
                Text(' o\'chirilsinmi?'),
              ],
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<CustomerCubit>(context, listen: false)
                        .deleteCustomer(customerList.customerId!);

                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CustomersPage()),
                        (route) => false);
                    print('deleted');
                  },
                  child: Text('Ha')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Yo\'q')),
            ],
          ));
        });
  }

//
  void _updateCustomer(BuildContext context, CustomerEntity customerList) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CustomerUpdatePage(
                  customerList: customerList,
                )));
  }
//
}

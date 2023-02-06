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
  List<CustomerEntity> _searchResult = [];

  TextEditingController controller = TextEditingController();

  @override
  void initState() {}

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  // search function
  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    widget.customersList.forEach((element) {
      if (element.name.toLowerCase().contains(
                text.toLowerCase(),
              ) ||
          element.phone
              .toLowerCase()
              .trim()
              .contains(text.trim().toLowerCase())) _searchResult.add(element);
      print("::::searchga qushildi");
    });

    setState(() {});
  }



  //
  @override
  Widget build(BuildContext context) {
    return _listViewSeparated(widget.customersList, context);
    //
  }

  //
  Widget _listViewSeparated(
      List<CustomerEntity> customersList, BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: ListTile(
            title: TextFormField(
              controller: controller,
              onChanged: onSearchTextChanged,
              decoration: InputDecoration(
                  hintText: "Izlash",
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  prefixIcon: Icon(Icons.search),
                  prefixIconColor: Colors.purple.shade900),
            ),
            trailing: new IconButton(
              icon: new Icon(Icons.cancel),
              onPressed: () {
                controller.clear();
                onSearchTextChanged('');
              },
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: _searchResult.length != 0 || controller.text.isNotEmpty
              ? ListView.separated(
                  itemBuilder: (context, index) {
                    CustomerEntity customerList = _searchResult[index];
                    print(
                        "object::customerId: ${customerList.customerId.toString()}");
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CustomerDetailPage(
                            customerId: customerList.customerId,
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
                                children: [
                                  Icon(Icons.update),
                                  Text(" yangilash")
                                ],
                              ),
                            ),
                            PopupMenuItem<ActionItems>(
                              value: ActionItems.delete,
                              child: Row(
                                children: [
                                  Icon(Icons.delete),
                                  Text(" o\'chirish")
                                ],
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
                  itemCount: _searchResult.length,
                )
              : ListView.separated(
                  itemBuilder: (context, index) {
                    CustomerEntity customerList = customersList[index];
                    print(
                        "object::customerId: ${customerList.customerId.toString()}");
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CustomerDetailPage(
                            customerId: customerList.customerId,
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
                                children: [
                                  Icon(Icons.update),
                                  Text(" yangilash")
                                ],
                              ),
                            ),
                            PopupMenuItem<ActionItems>(
                              value: ActionItems.delete,
                              child: Row(
                                children: [
                                  Icon(Icons.delete),
                                  Text(" o\'chirish")
                                ],
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
                ),
        ),
      ],
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


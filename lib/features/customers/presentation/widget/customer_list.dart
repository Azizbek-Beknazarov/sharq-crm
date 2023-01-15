import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/features/customers/domain/entity/customer_entity.dart';

import 'package:sharq_crm/features/customers/presentation/bloc/customer_cubit.dart';



import '../page/customer_detail_page.dart';


class CustomerList extends StatefulWidget {
  CustomerList({
    Key? key,required this.customersList
  }) : super(key: key,);
  TextEditingController nameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();
  List<CustomerEntity> customersList;
  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {

  @override
  void setState(VoidCallback fn) {
    context.read<CustomerCubit>().loadCustomer();
    print('list ichida loadCustomer() chaqirildi.}');
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
      itemBuilder: (ctx, index) {
        widget.nameController.text = customersList[index].name.toString();
        widget.phoneController.text = customersList[index].phone.toString();
        CustomerEntity customerList=customersList[index];
        return GestureDetector(
          onDoubleTap: () {
            _deleteCustomer(context, customerList);
          },
          onLongPress: () {
            _updateCustomer(context, customerList);
          },
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return CustomerDetailPage(
                customer: customerList,
              );
            }));
          },
          child: ListTile(
            title: Text(customerList.name),
            subtitle: Text(customerList.phone),
          ),
        );
      },
      separatorBuilder: (ctx, index) {
        return Divider(
          color: Colors.grey[400],
        );
      },
      itemCount: customersList.length,
    );
  }
//
  void _deleteCustomer(BuildContext context, CustomerEntity customerList){
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
                              .deleteCustomer(customerList.id);
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
  }
//
  void _updateCustomer(BuildContext context, CustomerEntity customerList){
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
                      final customerId = customerList.id;
                      CustomerEntity entity = CustomerEntity(
                        password: '',
                          name: widget.nameController.text,
                          phone: widget.phoneController.text,
                          dateOfSignUp: DateTime.now().millisecondsSinceEpoch,
                          id: customerList.id);

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
  }
  //

}

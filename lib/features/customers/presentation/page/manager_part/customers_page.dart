import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/core/util/loading_widget.dart';
import 'package:sharq_crm/core/util/snackbar_message.dart';
import 'package:sharq_crm/features/auth/presentation/bloc/m_auth_bloc.dart';
import 'package:sharq_crm/features/customers/presentation/bloc/customer_state.dart';
import 'package:sharq_crm/features/services/service_page.dart';
import 'package:uuid/uuid.dart';
import '../../../../auth/presentation/page/sign_in_page.dart';
import '../../../domain/entity/customer_entity.dart';
import '../../bloc/customer_cubit.dart';
import 'customer_add_page.dart';
import 'widget/customer_list.dart';
import 'package:sharq_crm/features/injection_container.dart' as di;

class CustomersPage extends StatefulWidget {
  CustomersPage({Key? key}) : super(key: key);

  @override
  State<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  List<CustomerEntity> customersList = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    BlocProvider.of<CustomerCubit>(context).loadCustomer();
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    context.read<CustomerCubit>().loadCustomer();
    print('page ichida loadCustomer() chaqirildi.}');
    super.setState(fn);
  }

  //
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerCubit, CustomersState>(
        builder: (context, customerCubitstate) {
      if (customerCubitstate is CustomerLoading) {
        return LoadingWidget();
      } else if (customerCubitstate is CustomerError) {
        SnackBarMessage().showErrorSnackBar(
            message: customerCubitstate.message, context: context);
      } else if (customerCubitstate is CustomersLoaded) {
        customersList = customerCubitstate.customersLoaded;
      }
      return Scaffold(
        key: _scaffoldKey,
        drawer: _drawerManager(),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              return _scaffoldKey.currentState?.openDrawer();
            },
            icon: Icon(Icons.menu),
          ),
          title: Text('Customers'),
          centerTitle: true,
        ),
        body: CustomerList(
          customersList: customersList,
        ),

        //
        floatingActionButton: _floatingAddCustomer(
          context,
        ),
      );
    });
  }

  Widget _drawerManager() {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Stack(
              children: [
                Positioned(
                  bottom: 8.0,
                  left: 4.0,
                  child: Text(
                    "  widget.customerId,",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.red,
              image: DecorationImage(
                image: AssetImage('assets/images/backgroundformanager.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Bosh sahifa"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => CustomersPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.monetization_on_outlined),
            title: Text("To\'lov qilinganlar"),
            onTap: () {
              // Navigator.pushAndRemoveUntil(
              //     context,
              //     MaterialPageRoute(
              //         builder: (_) => PaidCustomerPage(
              //           customerId: widget.customerId,
              //           videoForCustomerPaidlist: videoForCustomerPaidlist,
              //           photoStudioForCustomerPaidlist:
              //           photoStudioForCustomerPaidlist,
              //           albumForCustomerPaidlist: albumForCustomerPaidlist,
              //           clubForCustomerPaidlist: clubForCustomerPaidlist,
              //         )),
              //         (route) => false);
            },
          ),
          ListTile(
            leading: Icon(Icons.grid_3x3_outlined),
            title: Text("Arxivlar"),
            onTap: () {
              // Navigator.pushAndRemoveUntil(
              //     context,
              //     MaterialPageRoute(
              //         builder: (_) =>
              //             ArxivCustomerPage(customerId: widget.customerId)),
              //         (route) => false);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Sozlamalar"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Chiqish"),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Accountdan chiqish"),
                      content: Text('Siz rostdan ham ketyapsizmi?'),
                      icon: Icon(
                        Icons.warning,
                        color: Colors.yellow,
                      ),
                      actions: [
                        OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Yo\'q')),
                        OutlinedButton(
                            onPressed: () {
                              BlocProvider.of<AuthBloc>(context)
                                  .add(LogoutEvent());

                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignInPage()),
                                  (route) => false);
                              setState(() {});
                              SnackBarMessage().showSuccessSnackBar(
                                  message: 'Accountdan chiqildi',
                                  context: context);
                            },
                            child: Text("Ha")),
                      ],
                    );
                  });
              //

              //
            },
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 22, left: 44),
            child: SizedBox(child: Text("Sharq crm system version: 1.0.0")),
          ),
        ],
      ),
    );
  }

// method 1
  Widget _floatingAddCustomer(
    BuildContext context,
  ) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => NewCustomerAddPage()));
      },
      child: Icon(Icons.add),
    );
  }
}

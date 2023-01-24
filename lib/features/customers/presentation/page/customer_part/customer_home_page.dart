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
  List<PhotoStudioEntity> photoStudioForCustomerlist = [];

  @override
  Widget build(BuildContext context) {
    String customerId = '0';
    double totalPrice = 0.0;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
          di.sl<CustomerCubit>()
            ..getCurrentCustomerEvent(),
        ),
        BlocProvider(
          create: (context) => di.sl<PhotoStudioBloc>(),
        ),
      ],
      child: BlocBuilder<CustomerCubit, CustomersState>(
          builder: (context, customerState) {
            if (customerState is CustomerLoading) {
              return LoadingWidget();
            } else if (customerState is CustomerError) {
              return Text(customerState.message);
            } else if (customerState is CustomerGetLoadedState) {
              CustomerEntity currentCustomer = customerState.getLoadedCustomer;
              // current customer id getted

              customerId = currentCustomer.customerId!;
              print('loadCustomerFromCollection customerID: ${customerId}');
              context.read<CustomerCubit>().loadCustomerFromCollection(
                  customerId);
            }
            return Scaffold(
              appBar: _appBar(customerId),

              //
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    //current customer info
                    BlocBuilder<CustomerCubit, CustomersState>(
                        builder: (context, customerStatefrom) {
                          print(customerStatefrom.toString());
                          if (customerStatefrom is CustomerLoading) {
                            return LoadingWidget();
                          } else if (customerStatefrom is CustomerError) {
                            return Text(customerStatefrom.message);
                          } else if (customerStatefrom
                          is CustomerLoadedFromCollectionState) {
                            CustomerEntity currentCustomer = customerStatefrom
                                .entity;

                            return _currentCustomerInfo(currentCustomer);
                          }
                          return Text('data2');
                        }),
                    BlocBuilder<PhotoStudioBloc, PhotoStudioStates>(
                      builder: (contextPhotostudio, photoState) {
                        print("PhotoStudioStates: $photoState");
                        if (photoState is PhotoStudioInitialState) {
                          // return Text('Initial state...');
                        } else if (photoState is PhotoStudioLoadingState) {
                          return LoadingWidget();
                        } else if (photoState is PhotoStudioErrorState) {
                          return Center(
                            child: Text(
                                'photoState da error bor: ${photoState
                                    .message}'),
                          );
                        } else
                        if (photoState is PhotoStudioLoadedForCustomerState) {
                          print("PhotoStudioStates: $photoState");
                          photoStudioForCustomerlist = photoState.loaded;
                          print(
                              "photoStudioForCustomerlist: ${photoStudioForCustomerlist
                                  .toString()}");
                        }

                        return Column(
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  BlocProvider.of<PhotoStudioBloc>(
                                      contextPhotostudio, //context
                                      listen: false)
                                      .add(
                                      PhotoStudioGetForCustomerEvent(
                                          customerId));
                                },
                                child: Text('PhotoStudio info')),
                            _currentPhotoStudioInfo(
                                photoStudioForCustomerlist, contextPhotostudio,customerId),
                          ],
                        );
                      },
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (ctx) =>
                                  PaymentPage()));
                        },
                        child: Text('tulov qilish')),
                  ],
                ),
              ),
            );
          }),
    );
  }

  AppBar _appBar(String customerId) {
    return AppBar(
      title: Text('Customer Home Page'),
      leading: IconButton(
        onPressed: () {
          print("cus ID: $customerId");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (ctx) =>
                      ServicePage(
                        customerId: customerId,
                      )));
        },
        icon: Icon(Icons.home_repair_service),
      ),
    );
  }

//
  Padding _currentCustomerInfo(CustomerEntity currentCustomer) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            currentCustomer.name,
            style: TextStyle(fontSize: 20),
          ),
          Text(
            currentCustomer.phone.toString(),
            style: TextStyle(fontSize: 20),
          ),
          Text(
            currentCustomer.customerId.toString(),
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }

  //
  Padding _currentPhotoStudioInfo(
      List<PhotoStudioEntity> photoStudioForCustomerlist,
      BuildContext contextPhotostudio, String customerId) {
    double price = 0;
    photoStudioForCustomerlist.forEach((element) {
      price += element.price * element.ordersNumber;
    });
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text('Umumiy narx: ${price.toString()}'),
            Container(
              width: double.infinity,
              height: 400,
              child: ListView.builder(
                itemBuilder: (ctx, index) {
                  if (photoStudioForCustomerlist.isEmpty) {
                    return Center(
                      child: Text('Buyurtma mavjud emas'),
                    );
                  }
                  PhotoStudioEntity photoStudio = photoStudioForCustomerlist[index];
                  return Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                          color: Colors.black12),
                      child: Column(
                        children: [
                          ListTile(
                              title:
                              Text("Zakz sanasi: ${photoStudio
                                  .dateTimeOfWedding}"),
                              subtitle:
                              Text(
                                  "Zakzlar soni: ${photoStudio.ordersNumber}")),
                          ListTile(
                              title: Text(
                                  "30x40 rasm soni: ${photoStudio
                                      .largePhotosNumber} ta."),
                              subtitle: Text(
                                  "15x20 rasm soni: : ${photoStudio
                                      .smallPhotoNumber} ta.")),
                          ListTile(
                              title: Text("Narxi: ${photoStudio.price}"),
                              subtitle: Text(
                                  "ID: ${photoStudio.photo_studio_id}")),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(

                                onPressed: () {
                                  contextPhotostudio.read<PhotoStudioBloc>()
                                      .add(PhotoStudioDeleteEvent(
                                      customerId:customerId, photoStudioId:photoStudio.photo_studio_id

                                  ));
                                  SnackBarMessage().showSuccessSnackBar(message: 'O\'chirildi',context: contextPhotostudio);

                                }, child: Text('O\'chirish')),
                          )

                        ],
                      ),
                    ),
                  );
                },
                itemCount: photoStudioForCustomerlist.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:date_field/date_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/features/customers/presentation/page/customer_part/customer_home_page.dart';
import 'package:sharq_crm/features/services/club/domain/entity/club_entity.dart';
import 'package:sharq_crm/features/services/club/presentation/bloc/club_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../domain/entity/album_entity.dart';
import '../../bloc/album_bloc.dart';

class CustomerAlbumOrderPage extends StatefulWidget {
  String customerId;

  CustomerAlbumOrderPage({Key? key, required this.customerId}) : super(key: key);

  @override
  State<CustomerAlbumOrderPage> createState() => _CustomerAlbumOrderPageState();
}

class _CustomerAlbumOrderPageState extends State<CustomerAlbumOrderPage> {
  final uuid = Uuid();

  TextEditingController _ordersNumberController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  // TextEditingController _dateTimeOfWeddingController = TextEditingController();
  DateTime? selectedDate;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _ordersNumberController.clear();
    // _dateTimeOfWeddingController.clear();


    super.dispose();
  }

  //
  @override
  Widget build(BuildContext context) {
    print("Albumga buyurtma berish page dagi customer ID: ${widget.customerId}");
    return BlocBuilder<AlbumBloc, AlbumStates>(builder: (context, albumState) {
      if (albumState is AlbumLoadingState) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: CircularProgressIndicator(),
              ),
              Text('Loading data...'),
            ],
          ),
        );
      } else if (albumState is AlbumErrorState) {
        return Column(
          children: [
            Center(
              child: CircularProgressIndicator(),
            ),
            Text(albumState.message),
          ],
        );
      }

      return Form(
        key: _formKey,
        child: SafeArea(
          child: Scaffold(

            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Image.asset('assets/images/albumm.png'),
                          SizedBox(
                            height: 15,
                          ),
                          DateTimeFormField(
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(color: Colors.black45),
                              errorStyle: TextStyle(color: Colors.redAccent),
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.date_range),
                              labelText: 'Albumga olish sanasi',
                            ),
                            mode: DateTimeFieldPickerMode.dateAndTime,
                            autovalidateMode: AutovalidateMode.always,
                            validator: (value) {
                              if (value == null || value == '') {
                                return 'Iltimos, sanani kiriting!';
                              }
                              return null;
                            },
                            onDateSelected: (DateTime value) {
                              selectedDate = value;
                              print(value);
                            },
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Iltimos, sonni kiriting!';
                              }
                              return null;
                            },
                            controller: _ordersNumberController,
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(color: Colors.black45),
                              errorStyle: TextStyle(color: Colors.redAccent),
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.add),
                              labelText: 'Zakzlar soni',
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Iltimos, manzilni kiriting!';
                              }
                              return null;
                            },
                            controller: _addressController,
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(color: Colors.black45),
                              errorStyle: TextStyle(color: Colors.redAccent),
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.add_circle),
                              labelText: 'Manzil',
                            ),
                            keyboardType: TextInputType.text,
                          ),
                        ],
                      ),),
                    SizedBox(
                      height: 15,
                    ),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                        onPressed: () {

                          if (_formKey.currentState!.validate()){
                            int _ordersNumber =
                                int.tryParse(_ordersNumberController.text) ?? 1;

                            final docId = uuid.v4();
                            String date = selectedDate.toString();

                            AlbumEntity addAlbum = AlbumEntity(
                                album_id: docId ?? 'docid',
                                dateTimeOfWedding: date,
                                ordersNumber: _ordersNumber,
                                price: 1000000,
                                description: '',
                                address: _addressController.text

                            );

                            setState(() {
                              context.read<AlbumBloc>().add(AlbumAddEvent(
                                  addEvent: addAlbum, customerId: widget.customerId));
                              print('added Album');
                            });
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx)=>CustomerHomePage(customerId: widget.customerId,)), (route) => false);

                          }


                            },
                        child: Text('Tasdiqlash'))
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

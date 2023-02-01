import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../../customers/presentation/page/customer_part/customer_home_page.dart';
import '../../../domain/entity/photostudio_entity.dart';
import '../../bloc/photostudio_bloc.dart';
import '../../bloc/photostudio_event.dart';
import '../../bloc/photostudio_state.dart';
import 'package:date_field/date_field.dart';
import 'package:quantity_input/quantity_input.dart';

class CustomerPhotoStudioOrderPage extends StatefulWidget {
  String customerId;

  CustomerPhotoStudioOrderPage({Key? key, required this.customerId})
      : super(key: key);

  @override
  State<CustomerPhotoStudioOrderPage> createState() =>
      _CustomerPhotoStudioOrderPageState();
}

class _CustomerPhotoStudioOrderPageState
    extends State<CustomerPhotoStudioOrderPage> {
  final uuid = Uuid();
  final _formKey = GlobalKey<FormState>();
  DateTime? selectedDate;

  TextEditingController _ordersNumberController = TextEditingController();
  // TextEditingController _dateTimeOfWeddingController = TextEditingController();

  // int simpleIntInput = 0;

  @override
  void dispose() {
_ordersNumberController.clear();
// _dateTimeOfWeddingController.clear();

    super.dispose();
  }

  //
  @override
  Widget build(BuildContext context) {
    print(
        "Rasmxonaga buyurtma berish page dagi customer ID: ${widget.customerId}");
    return BlocBuilder<PhotoStudioBloc, PhotoStudioStates>(
        builder: (context, photeState) {
      if (photeState is PhotoStudioLoadingState) {
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
      } else if (photeState is PhotoStudioErrorState) {
        return Column(
          children: [
            Center(
              child: CircularProgressIndicator(),
            ),
            Text(photeState.message),
          ],
        );
      }

      return Form(
        key: _formKey,
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/photo.png'),
                  DateTimeFormField(
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.black45),
                      errorStyle: TextStyle(color: Colors.redAccent),
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.event_note),
                      labelText: 'Rasmxonaga tashrif buyurish sanasi',
                    ),
                    mode: DateTimeFieldPickerMode.date,
                    autovalidateMode: AutovalidateMode.always,
                    validator: (value) {
                      if (value == null || value=='') {
                        return 'Iltimos, sanani kiriting!';
                      }
                   return null;
                    },
                    onDateSelected: (DateTime value) {
                      selectedDate=value;
                      print(value);
                    },
                  ),

                  // TextFormField(
                  //   controller: _dateTimeOfWeddingController,
                  //   keyboardType: TextInputType.datetime,
                  //   decoration:  InputDecoration(
                  //
                  //     fillColor: Colors.red,
                  //
                  //     focusedBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  //         borderSide: BorderSide(color: Colors.blue)),
                  //
                  //     contentPadding:
                  //     EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
                  //     labelText: "Suratxona",
                  //       hintText: 'Rasmxonaga tashrif buyurish sanasi'
                  //   ),
                  //   // decoration: InputDecoration(
                  //   //     hintText: 'Rasmxonaga tashrif buyurish sanasi'),
                  //
                  // ),
                  // QuantityInput(
                  //     value: simpleIntInput,
                  //     onChanged: (value) => setState(() => simpleIntInput =
                  //         int.parse(value.replaceAll(',', '')))),

                  TextFormField(
                    validator: (value){
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
                  ElevatedButton(

                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                      onPressed: () {

                        if (_formKey.currentState!.validate()) {
                          int _ordersNumber =
                              int.tryParse(_ordersNumberController.text) ?? 1;
                          final docId = uuid.v4();
                          String date = selectedDate.toString();

                          PhotoStudioEntity addStudio = PhotoStudioEntity(
                            photo_studio_id: docId ?? 'docid',
                            dateTimeOfWedding: date,
                            ordersNumber: _ordersNumber,
                            price: 700000,
                            largeImage: "30x40",
                            smallImage: "15x20",
                            description: "",
                            largePhotosNumber: 1,
                            smallPhotoNumber: 40,
                          );

                          setState(() {
                            context.read<PhotoStudioBloc>().add(
                                PhotoStudioAddEvent(
                                    addEvent: addStudio,
                                    customerId: widget.customerId));
                            print('added photo');
                          });
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => CustomerHomePage(
                                    customerId: widget.customerId,
                                  )),
                                  (route) => false);

                        }


                      },
                      child: Text('Tasdiqlash'))
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

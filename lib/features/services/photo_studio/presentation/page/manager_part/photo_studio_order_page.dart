import 'package:date_field/date_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/core/util/loading_widget.dart';
import 'package:sharq_crm/features/customers/presentation/page/manager_part/customer_detail_page.dart';
import 'package:uuid/uuid.dart';

import '../../../domain/entity/photostudio_entity.dart';
import '../../bloc/photostudio_bloc.dart';
import '../../bloc/photostudio_event.dart';
import '../../bloc/photostudio_state.dart';
import 'package:sharq_crm/core/util/constants.dart';

class PhotoStudioOrderPage extends StatefulWidget {
  String customerId;

  PhotoStudioOrderPage({Key? key, required this.customerId}) : super(key: key);

  @override
  State<PhotoStudioOrderPage> createState() => _PhotoStudioOrderPageState();
}

class _PhotoStudioOrderPageState extends State<PhotoStudioOrderPage> {
  final uuid = Uuid();
  final _formKey = GlobalKey<FormState>();
  DateTime? selectedDate;

  TextEditingController _ordersNumberController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _largePhotosNumberController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _smallPhotoNumberController = TextEditingController();
  TextEditingController _prepaymentController = TextEditingController();

  @override
  void dispose() {
    _ordersNumberController.clear();
    _descriptionController.clear();
    _largePhotosNumberController.clear();
    _priceController.clear();
    _smallPhotoNumberController.clear();
    _prepaymentController.clear();

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
        return LoadingWidget();

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
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Image.asset('assets/images/photo.png'),
                    sizedBox,
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
                    sizedBox,
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Iltimos, sonni kiriting!';
                        }
                        return null;
                      },
                      controller: _largePhotosNumberController,
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Colors.black45),
                        errorStyle: TextStyle(color: Colors.redAccent),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.image_outlined),
                        labelText: '30x40 rasmlar soni',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    sizedBox,
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Iltimos, sonni kiriting!';
                        }
                        return null;
                      },
                      controller: _smallPhotoNumberController,
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Colors.black45),
                        errorStyle: TextStyle(color: Colors.redAccent),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.image),
                        labelText: '15x20 rasmlar soni',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    sizedBox,
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
                        prefixIcon: Icon(Icons.numbers),
                        labelText: 'Zakzlar soni',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    sizedBox,
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Iltimos, so\'mmani kiriting!';
                        }
                        return null;
                      },
                      controller: _priceController,
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Colors.black45),
                        errorStyle: TextStyle(color: Colors.redAccent),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.price_change_outlined),
                        hintText: "700000",
                        labelText: 'Narxi',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    sizedBox,
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Iltimos, so\'mmani kiriting!';
                        }
                        return null;
                      },
                      controller: _prepaymentController,
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Colors.black45),
                        errorStyle: TextStyle(color: Colors.redAccent),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.price_check),
                        labelText: 'Oldindan to\'lov',
                        hintText: "100000"
                      ),
                      keyboardType: TextInputType.number,
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
                    sizedBox,
                    TextFormField(
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Iltimos, sonni kiriting!';
                      //   }
                      //   return null;
                      // },
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Colors.black45),
                        errorStyle: TextStyle(color: Colors.redAccent),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.text_increase),
                        labelText: 'Qo\'shimcha ma\'lumotlar uchun',
                      ),
                      keyboardType: TextInputType.text,
                    ),
                    sizedBox,
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            int _large=int.tryParse(_largePhotosNumberController.text)??1;
                            int _small=int.tryParse(_smallPhotoNumberController.text)??40;
                            int _price=int.tryParse(_priceController.text)??700000;
                            int _ordersNumber =
                                int.tryParse(_ordersNumberController.text) ?? 1;
                            int _prepayment =
                                int.tryParse(_prepaymentController.text) ?? 0;
                            final docId = uuid.v4();
                            String date = selectedDate.toString();

                            PhotoStudioEntity addStudio = PhotoStudioEntity(
                                photo_studio_id: docId,
                                dateTimeOfWedding: date,
                                ordersNumber: _ordersNumber,
                                price: _price,
                                largeImage: "30x40",
                                smallImage: "15x20",
                                description: _descriptionController.text,
                                largePhotosNumber: _large,
                                smallPhotoNumber: _small,
                                isPaid: false,
                                prepayment:_prepayment,
                              customerId:widget.customerId,
                            );

                            setState(() {
                              context.read<PhotoStudioBloc>().add(
                                  PhotoStudioAddEvent(
                                      addEvent: addStudio,
                                      customerId: widget.customerId));
                              print('::::added photo');
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CustomerDetailPage(
                                          customerId: widget.customerId)),
                                  (route) => false);
                            });
                          }
                        },
                        child: Text('Tasdiqlash')),
                    sizedBox,
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

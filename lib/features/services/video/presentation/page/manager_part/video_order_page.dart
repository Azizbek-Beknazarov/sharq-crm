import 'package:date_field/date_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/features/customers/presentation/page/manager_part/customer_detail_page.dart';
import 'package:uuid/uuid.dart';

import '../../../../../../core/util/constants.dart';
import '../../../domain/entity/video_entity.dart';
import '../../bloc/video_bloc.dart';

class VideoOrderPage extends StatefulWidget {
  String customerId;

  VideoOrderPage({Key? key, required this.customerId}) : super(key: key);

  @override
  State<VideoOrderPage> createState() => _VideoOrderPageState();
}

class _VideoOrderPageState extends State<VideoOrderPage> {
  final uuid = Uuid();

  TextEditingController _ordersNumberController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _prepaymentController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  DateTime? selectedDate;
  final _formKey = GlobalKey<FormState>();

  // TextEditingController _dateTimeOfWeddingController = TextEditingController();

  @override
  void dispose() {
    _ordersNumberController.clear();

    _prepaymentController.clear();
    _descriptionController.clear();
    _priceController.clear();
    super.dispose();
  }

  //
  @override
  Widget build(BuildContext context) {
    print(
        "Videoga buyurtma berish page dagi customer ID: ${widget.customerId}");
    return BlocBuilder<VideoBloc, VideoStates>(builder: (context, videoState) {
      if (videoState is VideoLoadingState) {
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
      } else if (videoState is VideoErrorState) {
        return Column(
          children: [
            Center(
              child: CircularProgressIndicator(),
            ),
            Text(videoState.message),
          ],
        );
      }

      return Form(
        key: _formKey,
        child: SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
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
                          // Image.asset('assets/images/video.gif'),
                          sizedBox,
                          DateTimeFormField(
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(color: Colors.black45),
                              errorStyle: TextStyle(color: Colors.redAccent),
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.date_range),
                              labelText: 'Videoga olish sanasi va vaqti',
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
                                return 'Iltimos, manzilni kiriting!';
                              }
                              return null;
                            },
                            controller: _addressController,
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(color: Colors.black45),
                              errorStyle: TextStyle(color: Colors.redAccent),
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.home),
                              labelText: 'Manzil',
                            ),
                            keyboardType: TextInputType.text,
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
                              hintText: "2000000",
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
                                hintText: "100000"),
                            keyboardType: TextInputType.number,
                          ),
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
                        ],
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            int _ordersNumber =
                                int.tryParse(_ordersNumberController.text) ?? 1;
                            int _price =
                                int.tryParse(_priceController.text) ?? 2000000;
                            int _prepayment =
                                int.tryParse(_prepaymentController.text) ?? 0;
                            final docId = uuid.v4();
                            String date = selectedDate.toString();

                            VideoEntity addAlbum = VideoEntity(
                                video_id: docId,
                                dateTimeOfWedding: date,
                                ordersNumber: _ordersNumber,
                                price: _price,
                                description: _descriptionController.text,
                                prepayment: _prepayment,
                                customerId: widget.customerId,
                                address: _addressController.text,
                                isPaid: false);

                            context.read<VideoBloc>().add(VideoAddEvent(
                                addEvent: addAlbum,
                                customerId: widget.customerId));
                            print('added Video');

                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => CustomerDetailPage(
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
        ),
      );
    });
  }
}

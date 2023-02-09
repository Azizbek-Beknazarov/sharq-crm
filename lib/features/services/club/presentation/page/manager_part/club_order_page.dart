import 'package:date_field/date_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/features/customers/presentation/page/manager_part/customer_detail_page.dart';
import 'package:uuid/uuid.dart';

import '../../../domain/entity/club_entity.dart';
import '../../bloc/club_bloc.dart';
import 'package:sharq_crm/core/util/constants.dart';

class ClubOrderPage extends StatefulWidget {
  String customerId;

  ClubOrderPage({Key? key, required this.customerId}) : super(key: key);

  @override
  State<ClubOrderPage> createState() => _ClubOrderPageState();
}

class _ClubOrderPageState extends State<ClubOrderPage> {
  final uuid = Uuid();

  TextEditingController _ordersNumberController = TextEditingController();
  TextEditingController _prepaymentController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _fromHourController = TextEditingController();
  TextEditingController _toHourOfWeddingController = TextEditingController();
  DateTime? selectedDate;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _ordersNumberController.clear();
    _prepaymentController.clear();
    _descriptionController.clear();
    _priceController.clear();
    _fromHourController.clear();
    _toHourOfWeddingController.clear();

    super.dispose();
  }

  //
  @override
  Widget build(BuildContext context) {
    print("Clubga buyurtma berish page dagi customer ID: ${widget.customerId}");
    return BlocBuilder<ClubBloc, ClubStates>(builder: (context, clubState) {
      if (clubState is ClubLoadingState) {
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
      } else if (clubState is ClubErrorState) {
        return Column(
          children: [
            Center(
              child: CircularProgressIndicator(),
            ),
            Text(clubState.message),
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
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          // Image.asset('assets/images/club.png'),
                          sizedBox,
                          DateTimeFormField(
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(color: Colors.black45),
                              errorStyle: TextStyle(color: Colors.redAccent),
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.date_range),
                              labelText: 'Clubga tashrif buyurish sanasi',
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
                        ],
                      ),
                    ),
                    sizedBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _fromHourController,
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(color: Colors.black45),
                              errorStyle: TextStyle(color: Colors.redAccent),
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.hourglass_bottom_outlined),
                              labelText: 'Soat __ dan,',
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        sizedBox,
                        Expanded(
                          child: TextFormField(
                            controller: _toHourOfWeddingController,
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(color: Colors.black45),
                              errorStyle: TextStyle(color: Colors.redAccent),
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.hourglass_bottom),
                              labelText: ' __ gacha,',
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        )
                      ],
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
                        hintText: "800000",
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
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            int _ordersNumber =
                                int.tryParse(_ordersNumberController.text) ?? 1;
                            int _prepayment =
                                int.tryParse(_prepaymentController.text) ?? 0;
                            int _from =
                                int.tryParse(_fromHourController.text) ?? 12;
                            int _price =
                                int.tryParse(_priceController.text) ?? 800000;
                            int _to =
                                int.tryParse(_toHourOfWeddingController.text) ??
                                    13;
                            final docId = uuid.v4();
                            String date = selectedDate.toString();

                            ClubEntity addClub = ClubEntity(
                              club_id: docId,
                              dateTimeOfWedding: date,
                              ordersNumber: _ordersNumber,
                              price: _price,
                              description: _descriptionController.text,
                              fromHour: _from,
                              toHour: _to,
                              isPaid: false,
                              prepayment: _prepayment,
                              customerId: widget.customerId,
                            );

                            setState(() {
                              context.read<ClubBloc>().add(ClubAddEvent(
                                  addEvent: addClub,
                                  customerId: widget.customerId));
                              print('added club');
                            });
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

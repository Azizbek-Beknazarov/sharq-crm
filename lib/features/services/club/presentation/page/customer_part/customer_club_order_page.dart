import 'package:date_field/date_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/features/customers/presentation/page/customer_part/customer_home_page.dart';
import 'package:sharq_crm/features/services/club/domain/entity/club_entity.dart';
import 'package:sharq_crm/features/services/club/presentation/bloc/club_bloc.dart';
import 'package:uuid/uuid.dart';

class CustomerClubOrderPage extends StatefulWidget {
  String customerId;

  CustomerClubOrderPage({Key? key, required this.customerId}) : super(key: key);

  @override
  State<CustomerClubOrderPage> createState() => _CustomerClubOrderPageState();
}

class _CustomerClubOrderPageState extends State<CustomerClubOrderPage> {
  final uuid = Uuid();

  TextEditingController _ordersNumberController = TextEditingController();

  // TextEditingController _dateTimeOfWeddingController = TextEditingController();
  TextEditingController _fromHourController = TextEditingController();
  TextEditingController _toHourOfWeddingController = TextEditingController();
  DateTime? selectedDate;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _ordersNumberController.clear();
    // _dateTimeOfWeddingController.clear();
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
                          Image.asset('assets/images/club.png'),
                          SizedBox(
                            height: 15,
                          ),
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
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
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
                        SizedBox(
                          width: 20,
                        ),
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
                    SizedBox(
                      height: 13,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        onPressed: () {

                          if(_formKey.currentState!.validate()){
                            int _ordersNumber =
                                int.tryParse(_ordersNumberController.text) ?? 1;
                            int _from =
                                int.tryParse(_fromHourController.text) ?? 12;
                            int _to =
                                int.tryParse(_toHourOfWeddingController.text) ?? 13;
                            final docId = uuid.v4();
                            String date = selectedDate.toString();

                            ClubEntity addClub = ClubEntity(
                              club_id: docId ?? 'docid',
                              dateTimeOfWedding: date,
                              ordersNumber: _ordersNumber,
                              price: 800000,
                              description: '',
                              fromHour: _from,
                              toHour: _to,
                                isPaid:false,
                              customerId:widget.customerId,
                              prepayment:0,

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
        ),
      );
    });
  }
}

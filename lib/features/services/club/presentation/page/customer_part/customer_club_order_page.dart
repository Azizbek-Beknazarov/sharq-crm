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
  TextEditingController _dateTimeOfWeddingController = TextEditingController();
  TextEditingController _fromHourController = TextEditingController();
  TextEditingController _toHourOfWeddingController = TextEditingController();

  @override
  void dispose() {
    _ordersNumberController.clear();
    _dateTimeOfWeddingController.clear();
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

      return Scaffold(
        appBar: AppBar(
          title: Text('Clubga buyurtma berish'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                child: Column(
                  children: [
                    TextFormField(
                      controller: _dateTimeOfWeddingController,
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                          hintText: 'Clubga tashrif buyurish sanasi'),
                    ),
                    TextFormField(
                      controller: _ordersNumberController,
                      decoration: InputDecoration(hintText: 'Zakzlar soni'),
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _fromHourController,
                      decoration: InputDecoration(hintText: 'Soat __ dan,'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(width: 20,),
                  Expanded(
                    child: TextFormField(
                      controller: _toHourOfWeddingController,
                      decoration: InputDecoration(hintText: ' __ gacha,'),
                      keyboardType: TextInputType.number,
                    ),
                  )
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    int _ordersNumber =
                        int.tryParse(_ordersNumberController.text) ?? 1;
                    int _from = int.tryParse(_fromHourController.text) ?? 12;
                    int _to =
                        int.tryParse(_toHourOfWeddingController.text) ?? 13;
                    final docId = uuid.v4();
                    String date = _dateTimeOfWeddingController.text;

                    ClubEntity addClub = ClubEntity(
                      club_id: docId ?? 'docid',
                      dateTimeOfWedding: date,
                      ordersNumber: _ordersNumber,
                      price: 800000,
                      description: '',
                      fromHour: _from,
                      toHour: _to,
                    );

                    setState(() {
                      context.read<ClubBloc>().add(ClubAddEvent(
                          addEvent: addClub, customerId: widget.customerId));
                      print('added club');
                    });
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx)=>CustomerHomePage(customerId: widget.customerId,)), (route) => false);
                  },
                  child: Text('Tasdiqlash'))
            ],
          ),
        ),
      );
    });
  }
}

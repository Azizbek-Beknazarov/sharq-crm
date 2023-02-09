import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/features/services/club/domain/entity/club_entity.dart';

import 'package:uuid/uuid.dart';

import '../../bloc/club_bloc.dart';

class ClubUpdatePageForManager extends StatefulWidget {
  const ClubUpdatePageForManager({Key? key}) : super(key: key);

  @override
  State<ClubUpdatePageForManager> createState() =>
      _ClubUpdatePageForManagerState();
}

class _ClubUpdatePageForManagerState extends State<ClubUpdatePageForManager> {
  final uuid = Uuid();
  TextEditingController _priceController = TextEditingController();

  TextEditingController _ordersNumberController = TextEditingController();
  TextEditingController _toHourController = TextEditingController();
  TextEditingController _fromHourController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  List<ClubEntity> club = [];

  @override
  Widget build(BuildContext context) {
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
      } else if (clubState is ClubLoadedState) {
        club = clubState.loaded;
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
          title: Text('Club Update Page For Manager'),
        ),
        body: Column(
          children: [
            TextFormField(
              controller: _priceController,
              decoration: InputDecoration(hintText: 'Price'),
              keyboardType: TextInputType.number,
            ),

            TextFormField(
              controller: _ordersNumberController,
              decoration: InputDecoration(hintText: 'Orders Number'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _fromHourController,
              decoration: InputDecoration(hintText: 'From Hour'),
              keyboardType: TextInputType.number,
            ), TextFormField(
              controller: _toHourController,
              decoration: InputDecoration(hintText: 'To Hour'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(hintText: 'description'),
            ),
            ElevatedButton(
                onPressed: () {
                  int _priceInt = int.tryParse(_priceController.text) ?? 100000;
                  int _fromHour =
                      int.tryParse(_fromHourController.text) ?? 12;
                  int _toHour =
                      int.tryParse(_toHourController.text) ?? 13;
                  int _ordersNumber =
                      int.tryParse(_ordersNumberController.text) ?? 8;

                  final docId = uuid.v4();
                  String date = DateTime.now().toString();

                  ClubEntity addClub = ClubEntity(
                      club_id: docId ?? '',
                      price: _priceInt,
                      dateTimeOfWedding: date,
                      isPaid:false,
                      ordersNumber: _ordersNumber,
prepayment: 0,
                      description: _descriptionController.text ?? '',
                      fromHour: _fromHour,
                      customerId: "",
                      toHour: _toHour);
                  print('object:::${docId}');
                  print('object:::${date.toString()}');
                  print('object:::${_descriptionController.text}');

                  // hozircha ishlamaydi.
                  // setState(() {
                  //   context
                  //       .read<ClubBloc>()
                  //       .add(ClubAddEvent(addEvent: addClub, customerId: ));
                  //   print('added photo');
                  // });
                },
                child: Text('Add'))
          ],
        ),
      );
    });
  }
}

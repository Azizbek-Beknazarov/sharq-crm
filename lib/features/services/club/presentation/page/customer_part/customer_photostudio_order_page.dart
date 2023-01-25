import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../domain/entity/club_entity.dart';
import '../../bloc/club_bloc.dart';
import '../../bloc/club_event.dart';
import '../../bloc/club_state.dart';

class CustomerPhotoStudioOrderPage extends StatefulWidget {
   String customerId;
   CustomerPhotoStudioOrderPage({Key? key,required this.customerId}) : super(key: key);

  @override
  State<CustomerPhotoStudioOrderPage> createState() =>
      _CustomerPhotoStudioOrderPageState();
}

class _CustomerPhotoStudioOrderPageState
    extends State<CustomerPhotoStudioOrderPage> {
  final uuid = Uuid();

  TextEditingController _ordersNumberController = TextEditingController();
  TextEditingController _dateTimeOfWeddingController = TextEditingController();

  @override
  void dispose() {
_ordersNumberController.clear();
_dateTimeOfWeddingController.clear();

    super.dispose();
  }
  //
  @override
  Widget build(BuildContext context) {
    print("Rasmxonaga buyurtma berish page dagi customer ID: ${widget.customerId}");
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

      return Scaffold(
        appBar: AppBar(
          title: Text('Rasmxonaga buyurtma berish'),
        ),
        body: Column(
          children: [
            TextFormField(
              controller: _dateTimeOfWeddingController,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                  hintText: 'Rasmxonaga tashrif buyurish sanasi'),
            ),
            TextFormField(
              controller: _ordersNumberController,
              decoration: InputDecoration(hintText: 'Zakzlar soni'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
                onPressed: () {
                  int _ordersNumber =
                      int.tryParse(_ordersNumberController.text) ?? 1;
                  final docId = uuid.v4();
                  String date = _dateTimeOfWeddingController.text;

                  PhotoStudioEntity addStudio = PhotoStudioEntity(
                    photo_studio_id: docId ?? 'docid',
                    dateTimeOfWedding: date,
                    ordersNumber: _ordersNumber,
                    price: 700000,
                    largeImage: "30x40",
                    smallImage: "15x20",
                    description: '',
                    largePhotosNumber: 1,
                    smallPhotoNumber: 40,
                  );

                  setState(() {
                    context
                        .read<PhotoStudioBloc>()
                        .add(ClubAddEvent( addEvent:addStudio, customerId: widget.customerId ));
                    print('added photo');
                  });
                  Navigator.pop(context);
                },
                child: Text('Tasdiqlash'))
          ],
        ),
      );
    });
  }
}

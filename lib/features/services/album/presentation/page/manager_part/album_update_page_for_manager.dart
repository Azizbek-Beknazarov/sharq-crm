import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/features/services/album/domain/entity/album_entity.dart';
import 'package:sharq_crm/features/services/club/domain/entity/club_entity.dart';

import 'package:uuid/uuid.dart';

import '../../bloc/album_bloc.dart';

class AlbumUpdatePageForManager extends StatefulWidget {
  const AlbumUpdatePageForManager({Key? key}) : super(key: key);

  @override
  State<AlbumUpdatePageForManager> createState() =>
      _AlbumUpdatePageForManagerState();
}

class _AlbumUpdatePageForManagerState extends State<AlbumUpdatePageForManager> {
  final uuid = Uuid();
  TextEditingController _priceController = TextEditingController();

  TextEditingController _ordersNumberController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  List<AlbumEntity> album = [];

  @override
  Widget build(BuildContext context) {
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
      } else if (albumState is AlbumLoadedState) {
        album = albumState.loaded;
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

      return Scaffold(
        appBar: AppBar(
          title: Text('Album Update Page For Manager'),
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
              controller: _descriptionController,
              decoration: InputDecoration(hintText: 'description'),
            ),
            ElevatedButton(
                onPressed: () {
                  int _priceInt = int.tryParse(_priceController.text) ?? 100000;

                  int _ordersNumber =
                      int.tryParse(_ordersNumberController.text) ?? 8;

                  final docId = uuid.v4();
                  String date = DateTime.now().toString();

                  AlbumEntity addAlbum = AlbumEntity(
                    album_id: docId ?? '',
                    price: _priceInt,
                    dateTimeOfWedding: date,
                    ordersNumber: _ordersNumber,
                    description: _descriptionController.text ?? '',
                    address: "",
                    isPaid: false,
                    prepayment: 0,
                    timeOfWedding: "0000",
                    customerId: "yyyy",
                  );
                  print('object:::${docId}');
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

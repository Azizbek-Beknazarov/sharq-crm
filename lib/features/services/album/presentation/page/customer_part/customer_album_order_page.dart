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

      return Scaffold(
        appBar: AppBar(
          title: Text('Albumga buyurtma berish'),
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
                          hintText: 'Albumga olish sanasi'),
                    ),
                    TextFormField(
                      controller: _ordersNumberController,
                      decoration: InputDecoration(hintText: 'Zakzlar soni'),
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),

              ElevatedButton(
                  onPressed: () {
                    int _ordersNumber =
                        int.tryParse(_ordersNumberController.text) ?? 1;

                    final docId = uuid.v4();
                    String date = _dateTimeOfWeddingController.text;

                    AlbumEntity addAlbum = AlbumEntity(
                      album_id: docId ?? 'docid',
                      dateTimeOfWedding: date,
                      ordersNumber: _ordersNumber,
                      price: 1000000,
                      description: '',

                    );

                    setState(() {
                      context.read<AlbumBloc>().add(AlbumAddEvent(
                          addEvent: addAlbum, customerId: widget.customerId));
                      print('added Album');
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

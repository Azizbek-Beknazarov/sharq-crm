import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/features/services/photo_studio/domain/entity/photostudio_entity.dart';
import 'package:sharq_crm/features/services/photo_studio/presentation/bloc/photostudio_bloc.dart';
import 'package:sharq_crm/features/services/photo_studio/presentation/bloc/photostudio_event.dart';
import 'package:sharq_crm/features/services/photo_studio/presentation/bloc/photostudio_state.dart';
import 'package:uuid/uuid.dart';

class PhotoStudioUpdatePageForManager extends StatefulWidget {
  const PhotoStudioUpdatePageForManager({Key? key}) : super(key: key);

  @override
  State<PhotoStudioUpdatePageForManager> createState() =>
      _PhotoStudioUpdatePageForManagerState();
}

class _PhotoStudioUpdatePageForManagerState
    extends State<PhotoStudioUpdatePageForManager> {
  final uuid = Uuid();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _largeImageController = TextEditingController();
  TextEditingController _ordersNumberController = TextEditingController();
  TextEditingController _smallImageController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  List<PhotoStudioEntity> photoStudio = [];
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<PhotoStudioBloc,PhotoStudioStates>(
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
        } else if (photeState is PhotoStudioLoadedState) {
          photoStudio = photeState.loaded;
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
            title: Text('Photo Studio Update Page For Manager'),
          ),
          body: Column(
            children: [
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(hintText: 'Price'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _largeImageController,
                decoration: InputDecoration(hintText: 'Large Image'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _ordersNumberController,
                decoration: InputDecoration(hintText: 'Orders Number'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _smallImageController,
                decoration: InputDecoration(hintText: 'Small Image'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(hintText: 'description'),
              ),
              ElevatedButton(
                  onPressed: () {
                    int _priceInt = int.tryParse(_priceController.text) ?? 100000;
                    int _largeInt = int.tryParse(_largeImageController.text) ?? 30;
                    int _ordersNumber =
                        int.tryParse(_ordersNumberController.text) ?? 8;

                    final docId = uuid.v4();
                    String date=DateTime.now().toString();

                    PhotoStudioEntity addStudio = PhotoStudioEntity(
                        photo_studio_id: docId ?? '',
                        price: _priceInt,
                        dateTimeOfWedding: date,
                        largeImage: "30x40",
                        ordersNumber: _ordersNumber,
                        smallImage: "15x20",
                        description: _descriptionController.text ?? '', largePhotosNumber: 1, smallPhotoNumber: 40


                    );
                    print('object:::${docId}');
                    print('object:::${date.toString()}');
                    print('object:::${_descriptionController.text}');

                    // setState(() {
                    //   context
                    //       .read<PhotoStudioBloc>()
                    //       .add(PhotoStudioAddEvent(addStudio));
                    //   print('added photo');
                    // });
                  },
                  child: Text('Add'))
            ],
          ),
        );
      }
    );
  }
}

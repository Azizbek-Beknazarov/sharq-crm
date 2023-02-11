import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../../domain/entity/video_entity.dart';
import '../../bloc/video_bloc.dart';

class VideoUpdatePageForManager extends StatefulWidget {
  const VideoUpdatePageForManager({Key? key}) : super(key: key);

  @override
  State<VideoUpdatePageForManager> createState() =>
      _VideoUpdatePageForManagerState();
}

class _VideoUpdatePageForManagerState extends State<VideoUpdatePageForManager> {
  final uuid = Uuid();
  TextEditingController _priceController = TextEditingController();

  TextEditingController _ordersNumberController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  List<VideoEntity> video = [];

  @override
  Widget build(BuildContext context) {
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
      } else if (videoState is VideoLoadedState) {
        video = videoState.loaded;
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

      return Scaffold(
        appBar: AppBar(
          title: Text('Video Update Page For Manager'),
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

                  VideoEntity addVideo = VideoEntity(
                    video_id: docId ?? '',
                    price: _priceInt,
                    prepayment: 0,
                    dateTimeOfWedding: date,
                    timeOfWedding: "14:45",
                    ordersNumber: _ordersNumber,
                    description: _descriptionController.text ?? '',
                    address: _addressController.text??"",
                      isPaid: false,
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

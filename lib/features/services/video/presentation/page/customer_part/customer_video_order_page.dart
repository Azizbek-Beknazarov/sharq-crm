import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/features/customers/presentation/page/customer_part/customer_home_page.dart';
import 'package:uuid/uuid.dart';
import '../../../domain/entity/video_entity.dart';
import '../../bloc/video_bloc.dart';

class CustomerVideoOrderPage extends StatefulWidget {
  String customerId;

  CustomerVideoOrderPage({Key? key, required this.customerId}) : super(key: key);

  @override
  State<CustomerVideoOrderPage> createState() => _CustomerVideoOrderPageState();
}

class _CustomerVideoOrderPageState extends State<CustomerVideoOrderPage> {
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
    print("Videoga buyurtma berish page dagi customer ID: ${widget.customerId}");
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

      return Scaffold(
        appBar: AppBar(
          title: Text('Videoga buyurtma berish'),
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
                          hintText: 'Videoga  olish sanasi'),
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

                    VideoEntity addAlbum = VideoEntity(
                      video_id: docId ?? 'docid',
                      dateTimeOfWedding: date,
                      ordersNumber: _ordersNumber,
                      price: 2000000,
                      description: '',

                    );

                    setState(() {
                      context.read<VideoBloc>().add(VideoAddEvent(
                          addEvent: addAlbum, customerId: widget.customerId));
                      print('added Video');
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

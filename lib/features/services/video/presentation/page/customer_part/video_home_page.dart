import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sharq_crm/features/services/album/presentation/bloc/album_bloc.dart';
import '../../../domain/entity/video_entity.dart';
import '../../bloc/video_bloc.dart';
import 'customer_video_order_page.dart';

class VideoHomePage extends StatefulWidget {
  VideoHomePage({Key? key, required this.customerId}) : super(key: key);
  String customerId;

  @override
  State<VideoHomePage> createState() => _VideoHomePageState();
}

class _VideoHomePageState extends State<VideoHomePage> {
  List<VideoEntity> video = [];

  @override
  Widget build(BuildContext context) {
    print("Video home page dagi customer ID: ${widget.customerId}");
    context.read<VideoBloc>().add(VideoGetEvent(video));
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

      //
      //
      return Form(
        child: SafeArea(
          child: Scaffold(

            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.all(12),
                children: [
                  Image.asset(
                    "assets/images/video.gif",
                    // height: 325.0,
                    // width: 125.0,
                  ),
                  Text(
                    'Video .gif korinishida boladi',
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(
                    height: 15,
                  ),

                  Column(
                    children: video.map((e) {
                      return Card(
                        child: Column(
                          children: [

                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,

                                  border: Border.all(color: Colors.red),


                                  borderRadius: BorderRadius.all(Radius.circular(14))
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ListTile(
                                      title: Text(
                                        'Tavsif: ',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListTile(
                                      title: Text(
                                        ' ${e.description.toString()}',
                                        style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.red),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5,),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.black12,

                                  border: Border.all(color: Colors.red),


                                  borderRadius: BorderRadius.all(Radius.circular(14))
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ListTile(
                                      title: Text(
                                        'Video Studio narxi: ',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListTile(
                                      title: Column(
                                        children: [

                                          Text(
                                            ' ${e.price.toString()}',
                                            style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.red),
                                          ),
                                          Text(" so\'m"),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5,),
                          ],
                        ),
                      );
                    }).toList(),
                  ),










                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) => CustomerVideoOrderPage(
                                      customerId: widget.customerId,
                                    )));
                      },
                      child: Text(
                        'Zakaz qilish',
                        style: TextStyle(fontSize: 22),
                      ))
                ],
              ),
            ),
          ),
        ),
      );
    });

    //
  }
}

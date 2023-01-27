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
      return Scaffold(
        appBar: AppBar(
          title: Text('Video Home Page'),
        ),
        body: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(12),
          children: [
            Text(
              'Video suratlari galeriya korinishida boladi',
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(
              height: 5,
            ),
            Column(
              children: video.map((e) {
                return Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          'Video id: ${e.video_id.toString()}',
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Tavsif: ${e.description.toString()}',
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Video narxi: ${e.price.toString()}',
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            TextButton(
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
      );
    });

    //
  }
}

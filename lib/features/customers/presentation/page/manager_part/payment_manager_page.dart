import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../services/album/presentation/bloc/album_bloc.dart';
import '../../../../services/club/presentation/bloc/club_bloc.dart';
import '../../../../services/photo_studio/presentation/bloc/photostudio_bloc.dart';
import '../../../../services/photo_studio/presentation/bloc/photostudio_event.dart';
import '../../../../services/video/presentation/bloc/video_bloc.dart';
import 'customer_detail_page.dart';

class PaymentManagerPage extends StatelessWidget {
  PaymentManagerPage(
      {Key? key,
      required this.totalPrice,
      required this.customerId,
      required this.photoIds,
      required this.videoIds,
      required this.clubIds,
      required this.albumIds
      })
      : super(key: key);
  final double totalPrice;
  final String customerId;
  final List<String> photoIds;
  final List<String> videoIds;

  final List<String> clubIds;
  final List<String> albumIds;

  TextEditingController _cardController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Payment Page'),
        ),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(9),
              width: double.infinity,
              child: Image.asset(
                'assets/images/plastk.png',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _cardController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Iltimos, karta raqamini kiriting!';
                  }
                  if (value.length < 2) {
                    return 'Noto\'g\'ri kiritildi';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: "0000 0000 0000 0000",
                    labelText: 'Karta raqami',
                    icon: Icon(Icons.add_card)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlinedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.green.shade100)),
                  onPressed: () async {
                    //
                    if (_formKey.currentState!.validate()) {
                      print(
                          "photoIds.length========${photoIds.length.toString()}");
                      print(
                          "videoIds.length========${videoIds.length.toString()}");

                      print(
                          "clubIds.length========${clubIds.length.toString()}");
                      print(
                          "albumIds.length========${albumIds.length.toString()}");
                      //
                      for (int i = 0; i <= photoIds.length - 1; i++) {
                        String photoId = photoIds[i];
                        BlocProvider.of<PhotoStudioBloc>(context).add(
                            PhotoStudioUpdateEvent(
                                photostudioId: photoId,
                                customerId: customerId));
                        print("YANGILANDI: PHOTOSTUDIOID: ${photoId}");
                      }
                      //
                      for (int i = 0; i <= clubIds.length - 1; i++) {
                        String clubId = clubIds[i];
                        BlocProvider.of<ClubBloc>(context).add(ClubUpdateEvent(
                            clubId: clubId, customerId: customerId));
                        print("YANGILANDI: CLUB: ${clubId}");
                      }
                      //
                      for (int i = 0; i <= albumIds.length - 1; i++) {
                        String albumId = albumIds[i];
                        BlocProvider.of<AlbumBloc>(context).add(
                            AlbumUpdateEvent(
                                albumId: albumId, customerId: customerId));
                        print("YANGILANDI: ALBUM: ${albumId}");
                      }

                      //
                      for (int i = 0; i <= videoIds.length - 1; i++) {
                        String videoId = videoIds[i];
                        BlocProvider.of<VideoBloc>(context).add(
                            VideoUpdateEvent(
                                videoId: videoId, customerId: customerId));
                        print("YANGILANDI: VIDEOID: ${videoId}");
                      }

                      //
                      showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              actions: [
                                OutlinedButton(
                                    onPressed: () {
                                      Navigator.pushAndRemoveUntil(context,
                                          MaterialPageRoute(builder: (context) {
                                        return CustomerDetailPage(
                                            customerId: customerId);
                                      }), (route) => false);
                                    },
                                    child: Text('Bosh sahifaga...'))
                              ],
                              title: Text("To\'lov omadli yakunlandi"),
                            );
                          });
                    }

                    print(totalPrice.toString());
                  },
                  child: Text('${totalPrice.toString()} so\'m || Tasdiqlash')),
            )
          ],
        ),
      ),
    );
  }
}

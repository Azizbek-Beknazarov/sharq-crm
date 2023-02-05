import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/features/customers/presentation/page/manager_part/customer_detail_page.dart';

import '../../../../../../core/util/snackbar_message.dart';
import '../../../../../services/video/domain/entity/video_entity.dart';
import '../../../../../services/video/presentation/bloc/video_bloc.dart';

class VideoInfoShowWidget extends StatefulWidget {
  VideoInfoShowWidget(
      {Key? key,
        required this.videoForCustomerUnPaidlist,
        required this.customerId})
      : super(key: key);
  List<VideoEntity> videoForCustomerUnPaidlist;
  String customerId;

  @override
  State<VideoInfoShowWidget> createState() => _VideoInfoShowWidgetState();
}

class _VideoInfoShowWidgetState extends State<VideoInfoShowWidget> {
  @override
  Widget build(BuildContext context) {
    return _currentVideoInfoUnPaid(
        widget.videoForCustomerUnPaidlist, context, widget.customerId);
  }

  Padding _currentVideoInfoUnPaid(List<VideoEntity> videoForCustomerUnPaidList,
      BuildContext contextVideo, String customerId) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "Video Studio",
              style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            Container(
              width: double.infinity,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (ctx, index) {
                  if (videoForCustomerUnPaidList.isEmpty) {
                    return Center(
                      child: Text('Buyurtma mavjud emas'),
                    );
                  }
                  VideoEntity video = videoForCustomerUnPaidList[index];
                  return Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(22),
                          ),
                          color: Colors.white10),
                      child: Column(
                        children: [
                          ListTile(
                            title: Row(
                              children: [
                                Text("Manzil: "),
                                Text(
                                  "${video.address}",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          ListTile(
                              title: Row(
                                children: [
                                  Text("Zakz sanasi: "),
                                  Text(
                                    "${video.dateTimeOfWedding}",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              subtitle: Row(
                                children: [
                                  Text(
                                    "Zakzlar soni: ",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                  Text(
                                    "${video.ordersNumber}",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                          ListTile(
                              title: Row(
                                children: [
                                  Text(
                                    "Narxi: ",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                  Text(
                                    "${video.price * video.ordersNumber}",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    " so\'m",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                ],
                              ),
                              subtitle: Text("ID: ${video.video_id}")),
                          Text("isPaid: ${video.isPaid.toString()}"),
                          //Videoni o'chirish button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(18.0),
                                            side:
                                            BorderSide(color: Colors.red))),
                                    backgroundColor:
                                    MaterialStateProperty.all(Colors.red)),
                                onPressed: () {
                                  showDialog(
                                      context: contextVideo,
                                      builder: (contextVideo) {
                                        return AlertDialog(
                                          title: Text("Videoni o\'chirish"),
                                          content: Text(
                                              'Siz rostdan ham Videoni olib tashlamoqchimisiz?'),
                                          icon: Icon(Icons.warning),
                                          actions: [
                                            OutlinedButton(
                                                onPressed: () {
                                                  Navigator.pop(contextVideo);
                                                },
                                                child: Text("Yo\'q")),
                                            OutlinedButton(
                                                onPressed: () {
                                                  BlocProvider.of<VideoBloc>(
                                                      contextVideo)
                                                      .add(VideoDeleteEvent(
                                                      customerId:
                                                      customerId,
                                                      videoId:
                                                      video.video_id));

                                                  setState(() {});
                                                  print(":::: video ochirildi");
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (ctx) =>
                                                              CustomerDetailPage(
                                                                  customerId:
                                                                  customerId)));

                                                  SnackBarMessage()
                                                      .showSuccessSnackBar(
                                                      message:
                                                      'O\'chirildi',
                                                      context:
                                                      contextVideo);
                                                },
                                                child: Text("Ha")),
                                          ],
                                        );
                                      });
                                },
                                child: Text('Olib tashlash')),
                          )
                        ],
                      ),
                    ),
                  );
                },
                itemCount: videoForCustomerUnPaidList.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
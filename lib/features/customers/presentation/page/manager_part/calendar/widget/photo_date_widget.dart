import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart';
import '../../../../../../services/photo_studio/domain/entity/photostudio_entity.dart';
import '../../../../../../services/photo_studio/presentation/bloc/photostudio_bloc.dart';
import '../../../../../../services/photo_studio/presentation/bloc/photostudio_event.dart';
import '../../../../../../services/photo_studio/presentation/bloc/photostudio_state.dart';

class PhotoDateWidget extends StatelessWidget {
  PhotoDateWidget({Key? key, required this.dateTime}) : super(key: key);
  DateTime dateTime;
  List<PhotoStudioEntity> photoDateTimelist = [];

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PhotoStudioBloc>(context)
        .add(PhotoStudioGetDateTimeOrdersEvent(dateTime: dateTime));
    return BlocBuilder<PhotoStudioBloc, PhotoStudioStates>(
        builder: (context, state) {
      if (state is PhotoStudioLoadedDateTimeState) {
        photoDateTimelist = state.photoDateTimelist;
      }
      return Scaffold(
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  // padding: EdgeInsets.all(22),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(22),
                      ),
                      color: Colors.black12),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          children: [
                            Text(
                              "${DateFormat("dd-MM-yyyy").format(dateTime)}",
                              style: TextStyle(
                                  fontSize: 26,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              " sanadagi buyurtmalar soni:",
                              style: TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text(
                            photoDateTimelist.length.toString(),
                            style:
                                TextStyle(fontSize: 50, color: Colors.purple,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: photoDateTimelist.length,
                      itemBuilder: (context, index) {
                        PhotoStudioEntity photoDateTime =
                            photoDateTimelist[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(22),
                                ),
                                color: Colors.yellow),
                            child: Column(
                              children: [
                                ListTile(
                                    title: Row(
                                      children: [
                                        Text("Zakz sanasi: "),
                                        Text(
                                          "${DateFormat("dd-MM-yyyy").format(DateTime.parse(photoDateTime.dateTimeOfWedding))}",
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
                                              fontSize: 15,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          "${photoDateTime.ordersNumber}",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )),
                                ListTile(
                                    title: Row(
                                      children: [
                                        Text("30x40 rasmlar soni: "),
                                        Text(
                                          "${photoDateTime.largePhotosNumber}",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    subtitle: Row(
                                      children: [
                                        Text(
                                          "15x20 rasmlar soni: ",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          "${photoDateTime.smallPhotoNumber}",
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
                                        "${photoDateTime.price * photoDateTime.ordersNumber}",
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
                                  subtitle: Row(
                                    children: [
                                      Text(
                                        "Oldindan to\'lov qilingan: ",
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black),
                                      ),
                                      Text(
                                        "${photoDateTime.prepayment}",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        " so\'m ",
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                ListTile(
                                  title: Row(
                                    children: [
                                      Text(
                                        "Qolgan so\'mma: ",
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black),
                                      ),
                                      Text(
                                        "${photoDateTime.price * photoDateTime.ordersNumber - photoDateTime.prepayment}",
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
                                  subtitle: Row(
                                    children: [
                                      Text(
                                        "ID: ",
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black),
                                      ),
                                      Text(
                                        "${photoDateTime.photo_studio_id}",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                ListTile(
                                  title: Row(
                                    children: [
                                      Text(
                                        "To\'lov qilinganmi: ",
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black),
                                      ),
                                      photoDateTime.isPaid
                                          ? Icon(
                                              Icons.done_all,
                                              color: Colors.green,
                                            )
                                          : Icon(
                                              Icons.highlight_remove_rounded,
                                              color: Colors.red,
                                            )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                ListTile(
                                  title: Row(
                                    children: [
                                      Text(
                                        "Qo\'shimcha: ",
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black),
                                      ),
                                      Flexible(
                                          child:
                                              Text(photoDateTime.description))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }))
            ],
          ),
        ),
      );
    });
  }
}

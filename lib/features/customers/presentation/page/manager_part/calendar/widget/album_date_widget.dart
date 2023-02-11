import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/features/services/album/domain/entity/album_entity.dart';
import 'package:sharq_crm/features/services/album/presentation/bloc/album_bloc.dart';
import 'package:intl/intl.dart';
class AlbumDateWidget extends StatelessWidget {
  AlbumDateWidget({Key? key, required this.dateTime}) : super(key: key);
  DateTime dateTime;
  List<AlbumEntity> albumDateTimelist = [];

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AlbumBloc>(context)
        .add(AlbumStudioGetDateTimeOrdersEvent(dateTime: dateTime));
    return BlocBuilder<AlbumBloc, AlbumStates>(
        builder: (context, state) {
          if (state is AlbumLoadedDateState) {
            albumDateTimelist = state.albumDateTimelist;
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
                                albumDateTimelist.length.toString(),
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
                          itemCount: albumDateTimelist.length,
                          itemBuilder: (context, index) {
                            AlbumEntity album =
                            albumDateTimelist[index];
                            return Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(22),
                                    ),
                                    color: Colors.green.shade100),
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Row(
                                        children: [
                                          Text("Manzil: "),
                                          Text(
                                            "${album.address}",
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
                                              "${album.dateTimeOfWedding}",
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
                                              "${album.ordersNumber}",
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
                                            "${album.price * album.ordersNumber}",
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
                                            "${album.prepayment}",
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
                                    ListTile(
                                      title: Row(
                                        children: [
                                          Text(
                                            "Qolgan so\'mma: ",
                                            style: TextStyle(
                                                fontSize: 15, color: Colors.black),
                                          ),
                                          Text(
                                            "${album.price * album.ordersNumber - album.prepayment}",
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
                                            "${album.album_id}",
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
                                          Text(
                                            "To\'lov qilinganmi: ",
                                            style: TextStyle(
                                                fontSize: 15, color: Colors.black),
                                          ),
                                          album.isPaid
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
                                    ListTile(
                                      title: Row(
                                        children: [
                                          Text(
                                            "Qo\'shimcha: ",
                                            style: TextStyle(
                                                fontSize: 15, color: Colors.black),
                                          ),
                                          Flexible(child: Text(album.description))
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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/util/loading_widget.dart';
import '../../../../../../core/util/snackbar_message.dart';
import '../../../../../services/album/domain/entity/album_entity.dart';
import '../../../../../services/album/presentation/bloc/album_bloc.dart';

class AlbumInfoBlocBuilder extends StatefulWidget {
  AlbumInfoBlocBuilder({Key? key, required
  this.albumForCustomerlist,
    required this.loading,
    required this.customerId}) : super(key: key);
  List<AlbumEntity> albumForCustomerlist;

  bool loading = false;
  String customerId;

  @override
  State<AlbumInfoBlocBuilder> createState() => _AlbumInfoBlocBuilderState();
}

class _AlbumInfoBlocBuilderState extends State<AlbumInfoBlocBuilder> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlbumBloc, AlbumStates>(
      builder: (contextAlbum, albumState) {
        // print("Album States: $albumState");
        if (albumState is AlbumInitialState) {
          // return Text('Initial state...');
        } else if (albumState is AlbumLoadingState) {
          return LoadingWidget();
        } else if (albumState is AlbumErrorState) {
          return Center(
            child: Text(
                'AlbumState da error bor: ${albumState.message}'),
          );
        } else if (albumState is AlbumLoadedForCustomerState) {
          // print("Album States: $albumState");
          widget.albumForCustomerlist = albumState.loaded;

          // print(
          //     "AlbumForCustomerlist: ${albumForCustomerlist.toString()}");
        }

        return Column(
          children: [
            widget.albumForCustomerlist.length == 0
                ? Text(
              'Album hali buyurtma qilinmadi.',
              style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold),
            )
                : _currentAlbumInfo(widget.albumForCustomerlist,
                contextAlbum, widget.customerId),
          ],
        );
      },
    )
    ;
  }
  //
  Padding _currentAlbumInfo(List<AlbumEntity> albumForCustomerlist,
      BuildContext contextAlbum, String customerId) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "Album",
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
                  if (albumForCustomerlist.isEmpty) {
                    return Center(
                      child: Text('Buyurtma mavjud emas'),
                    );
                  }
                  AlbumEntity album = albumForCustomerlist[index];
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
                              subtitle: Text("ID: ${album.album_id}")),
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
                                      context: contextAlbum,
                                      builder: (contextAlbum) {
                                        return AlertDialog(
                                          title: Text("Albumni o\'chirish"),
                                          content: Text(
                                              'Siz rostdan ham albumni olib tashlamoqchimisiz?'),
                                          icon: Icon(Icons.warning),
                                          actions: [
                                            OutlinedButton(
                                                onPressed: () {
                                                  Navigator.pop(contextAlbum);
                                                },
                                                child: Text("Yo\'q")),
                                            OutlinedButton(
                                                onPressed: () {
                                                  contextAlbum
                                                      .read<AlbumBloc>()
                                                      .add(AlbumDeleteEvent(
                                                      customerId:
                                                      customerId,
                                                      albumId:
                                                      album.album_id));

                                                  context.read<AlbumBloc>().add(
                                                      AlbumGetForCustomerEvent(
                                                          customerId));
                                                  setState(() {
                                                    widget.loading = true;
                                                  });
                                                  Navigator.pop(contextAlbum);
                                                  SnackBarMessage()
                                                      .showSuccessSnackBar(
                                                      message:
                                                      'O\'chirildi',
                                                      context:
                                                      contextAlbum);
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
                itemCount: albumForCustomerlist.length,
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

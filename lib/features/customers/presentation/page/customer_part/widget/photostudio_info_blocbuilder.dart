import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/util/loading_widget.dart';
import '../../../../../../core/util/snackbar_message.dart';
import '../../../../../services/photo_studio/domain/entity/photostudio_entity.dart';
import '../../../../../services/photo_studio/presentation/bloc/photostudio_bloc.dart';
import '../../../../../services/photo_studio/presentation/bloc/photostudio_event.dart';
import '../../../../../services/photo_studio/presentation/bloc/photostudio_state.dart';

class PhotoStudioInfoBlocBuilder extends StatefulWidget {
  PhotoStudioInfoBlocBuilder(
      {Key? key,
      required this.photoStudioForCustomerlist,
      required this.customerId,
      required this.loading})
      : super(key: key);
  List<PhotoStudioEntity> photoStudioForCustomerlist;

  String customerId;
  bool loading;

  @override
  State<PhotoStudioInfoBlocBuilder> createState() =>
      _PhotoStudioInfoBlocBuilderState();
}

class _PhotoStudioInfoBlocBuilderState
    extends State<PhotoStudioInfoBlocBuilder> {
  @override
  Widget build(BuildContext context) {
    return _currentPhotoStudioInfo( widget.photoStudioForCustomerlist, context, widget.customerId);
  }

  //
  Padding _currentPhotoStudioInfo(
      List<PhotoStudioEntity> photoStudioForCustomerlist,
      BuildContext contextPhotostudio,
      String customerId) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Column(
        children: [
          Text(
            "Photo Studio",
            style: TextStyle(
                color: Colors.green, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Container(
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (ctx, index) {
                if (photoStudioForCustomerlist.isEmpty) {
                  return Center(
                    child: Text('Buyurtma mavjud emas'),
                  );
                }
                PhotoStudioEntity photoStudio =
                    photoStudioForCustomerlist[index];
                // DateTime? date=DateTime.tryParse(photoStudio.dateTimeOfWedding);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
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
                                Text("Zakz sanasi: "),
                                Text(
                                  "${photoStudio.dateTimeOfWedding}",
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
                                  "${photoStudio.ordersNumber}",
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
                                  "${photoStudio.largePhotosNumber}",
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
                                      fontSize: 15, color: Colors.black),
                                ),
                                Text(
                                  "${photoStudio.smallPhotoNumber}",
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
                                  "${photoStudio.price * photoStudio.ordersNumber}",
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
                            subtitle:
                                Text("ID: ${photoStudio.photo_studio_id}")),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side: BorderSide(color: Colors.red))),
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.red)),
                              onPressed: () {
                                showDialog(
                                    context: contextPhotostudio,
                                    builder: (contextPhotostudio) {
                                      return AlertDialog(
                                        title:
                                            Text("Photo studioni o\'chirish"),
                                        content: Text(
                                            'Siz rostdan ham Photo studioni olib tashlamoqchimisiz?'),
                                        icon: Icon(
                                          Icons.warning,
                                          color: Colors.yellow,
                                        ),
                                        actions: [
                                          OutlinedButton(
                                              onPressed: () {
                                                Navigator.pop(
                                                    contextPhotostudio);
                                              },
                                              child: Text('Yo\'q')),
                                          OutlinedButton(
                                              onPressed: () {
                                                contextPhotostudio
                                                    .read<PhotoStudioBloc>()
                                                    .add(PhotoStudioDeleteEvent(
                                                        customerId: customerId,
                                                        photoStudioId: photoStudio
                                                            .photo_studio_id));
                                                context.read<PhotoStudioBloc>().add(
                                                    PhotoStudioGetForCustomerEvent(
                                                        customerId));
                                                setState(() {
                                                  widget.loading = true;
                                                });
                                                Navigator.pop(
                                                    contextPhotostudio);
                                                SnackBarMessage()
                                                    .showSuccessSnackBar(
                                                        message: 'O\'chirildi',
                                                        context:
                                                            contextPhotostudio);
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
              itemCount: photoStudioForCustomerlist.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}

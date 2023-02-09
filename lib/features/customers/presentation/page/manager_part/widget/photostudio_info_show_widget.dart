import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/util/snackbar_message.dart';
import '../../../../../services/photo_studio/domain/entity/photostudio_entity.dart';
import '../../../../../services/photo_studio/presentation/bloc/photostudio_bloc.dart';
import '../../../../../services/photo_studio/presentation/bloc/photostudio_event.dart';
import '../customer_detail_page.dart';

class PhotoStudioInfoShow extends StatefulWidget {
  PhotoStudioInfoShow({
    Key? key,
    required this.photoStudioForCustomerlist,
    required this.customerId,
  }) : super(key: key);
  List<PhotoStudioEntity> photoStudioForCustomerlist;

  String customerId;

  @override
  State<PhotoStudioInfoShow> createState() => _PhotoStudioInfoShowState();
}

class _PhotoStudioInfoShowState extends State<PhotoStudioInfoShow> {
  @override
  Widget build(BuildContext context) {
    return _currentPhotoStudioInfo(
        widget.photoStudioForCustomerlist, context, widget.customerId);
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
                        color: Colors.white70),
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
                          subtitle: Row(
                            children: [
                              Text(
                                "Oldindan to\'lov qilingan: ",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                              Text(
                                "${photoStudio.prepayment}",
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
                                "${photoStudio.price * photoStudio.ordersNumber - photoStudio.prepayment}",
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
                                "${photoStudio.photo_studio_id}",
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
                                photoStudio.isPaid
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
                        SizedBox(height: 5,),
                        ListTile(
                          title: Row(
                            children: [
                              Text(
                                "Qo\'shimcha: ",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                             Flexible(child: Text(photoStudio.description))

                            ],
                          ),


                        ),

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

                                                setState(() {});
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            CustomerDetailPage(
                                                                customerId:
                                                                    customerId)));
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

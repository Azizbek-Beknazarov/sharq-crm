import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/core/util/loading_widget.dart';
import 'package:sharq_crm/features/customers/presentation/page/customer_part/arxiv_page.dart';
import 'package:sharq_crm/features/services/photo_studio/domain/entity/photostudio_entity.dart';

import '../../../../../core/util/snackbar_message.dart';
import '../../../../services/video/domain/entity/video_entity.dart';
import '../../../../services/video/presentation/bloc/video_bloc.dart';
import '../../bloc/customer_cubit.dart';
import 'customer_auth_pages/sign_in_customer_page.dart';
import 'customer_home_page.dart';

class PaidCustomerPage extends StatefulWidget {
  PaidCustomerPage(
      {Key? key,
      required this.customerId,
      required this.videoForCustomerPaidlist,
      required this.photoStudioForCustomerPaidlist})
      : super(key: key);
  final String customerId;
  List<VideoEntity> videoForCustomerPaidlist;
  List<PhotoStudioEntity> photoStudioForCustomerPaidlist;

  @override
  State<PaidCustomerPage> createState() => _PaidCustomerPageState();
}

class _PaidCustomerPageState extends State<PaidCustomerPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //
              widget.photoStudioForCustomerPaidlist.length == 0
                  ? Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Center(
                        child: Text(
                          'Tasdiqlangan Photo Studio buyurtma mavjud emas.',
                          style: TextStyle(
                              color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  : _currentPhotoStudioInfo(
                      widget.photoStudioForCustomerPaidlist,
                      context,
                      widget.customerId),
              SizedBox(
                height: 10,
              ),
              //
              widget.videoForCustomerPaidlist.length == 0
                  ? Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Center(
                        child: Text(
                          'Tasdiqlangan Video buyurtma mavjud emas.',
                          style: TextStyle(
                              color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  : _currentVideoInfoPaid(widget.videoForCustomerPaidlist,
                      context, widget.customerId),
            ],
          ),
        ),
        drawer: _drawer(widget.customerId),
      ),
    );
    // });
  }

//
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
                        Text("isPaid: ${photoStudio.isPaid.toString()}"),
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

  //

  //
  Padding _currentVideoInfoPaid(List<VideoEntity> videoForCustomerPaidList,
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
                  if (videoForCustomerPaidList.isEmpty) {
                    return Center(
                      child: Text('Buyurtma mavjud emas'),
                    );
                  }
                  VideoEntity video = videoForCustomerPaidList[index];
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
                          // SizedBox(
                          //   width: double.infinity,
                          //   child: ElevatedButton(
                          //       style: ButtonStyle(
                          //           shape: MaterialStateProperty.all<
                          //               RoundedRectangleBorder>(
                          //               RoundedRectangleBorder(
                          //                   borderRadius:
                          //                   BorderRadius.circular(18.0),
                          //                   side:
                          //                   BorderSide(color: Colors.red))),
                          //           backgroundColor:
                          //           MaterialStateProperty.all(Colors.red)),
                          //       onPressed: () {
                          //         showDialog(
                          //             context: contextVideo,
                          //             builder: (contextVideo) {
                          //               return AlertDialog(
                          //                 title: Text("Videoni o\'chirish"),
                          //                 content: Text(
                          //                     'Siz rostdan ham Videoni olib tashlamoqchimisiz?'),
                          //                 icon: Icon(Icons.warning),
                          //                 actions: [
                          //                   OutlinedButton(
                          //                       onPressed: () {
                          //                         Navigator.pop(contextVideo);
                          //                       },
                          //                       child: Text("Yo\'q")),
                          //                   OutlinedButton(
                          //                       onPressed: () {
                          //                         contextVideo
                          //                             .read<VideoBloc>()
                          //                             .add(VideoDeleteEvent(
                          //                             customerId:
                          //                             customerId,
                          //                             videoId:
                          //                             video.video_id));
                          //
                          //                         context.read<VideoBloc>().add(
                          //                             VideoGetForCustomerEvent(
                          //                                 customerId));
                          //                         setState(() {
                          //                           loading = true;
                          //                         });
                          //                         Navigator.pop(contextVideo);
                          //
                          //                         SnackBarMessage()
                          //                             .showSuccessSnackBar(
                          //                             message:
                          //                             'O\'chirildi',
                          //                             context:
                          //                             contextVideo);
                          //                       },
                          //                       child: Text("Ha")),
                          //                 ],
                          //               );
                          //             });
                          //       },
                          //       child: Text('Olib tashlash')),
                          // )
                        ],
                      ),
                    ),
                  );
                },
                itemCount: widget.videoForCustomerPaidlist.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawer(String customerId) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Stack(
              children: [
                Positioned(
                  bottom: 8.0,
                  left: 4.0,
                  child: Text(
                    widget.customerId,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.red,
              image: DecorationImage(
                image: AssetImage('assets/images/salut.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Bosh sahifa"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) =>
                          CustomerHomePage(customerId: widget.customerId)));
            },
          ),
          ListTile(
            leading: Icon(Icons.monetization_on_outlined),
            title: Text("To\'lov qilinganlar"),
            onTap: () {
              // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>PaidCustomerPage()),
              //         (route) => false);
            },
          ),
          ListTile(
            leading: Icon(Icons.grid_3x3_outlined),
            title: Text("Arxivlar"),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (_) =>
                          ArxivCustomerPage(customerId: widget.customerId)),
                  (route) => false);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Sozlamalar"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Chiqish"),
            onTap: () {
              //
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Accountdan chiqish"),
                      content: Text('Siz rostdan ham ketyapsizmi?'),
                      icon: Icon(
                        Icons.warning,
                        color: Colors.yellow,
                      ),
                      actions: [
                        OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Yo\'q')),
                        OutlinedButton(
                            onPressed: () {
                              BlocProvider.of<CustomerCubit>(context)
                                  .logOutCustomer();
                              print("cus ID: ${widget.customerId}");
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SignInCustomerPage()),
                                  (route) => false);

                              SnackBarMessage().showSuccessSnackBar(
                                  message: 'Accountdan chiqildi',
                                  context: context);
                            },
                            child: Text("Ha")),
                      ],
                    );
                  });
              //
            },
          )
        ],
      ),
    );
  }
}

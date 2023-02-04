import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/core/util/loading_widget.dart';
import 'package:sharq_crm/core/util/snackbar_message.dart';
import 'package:sharq_crm/features/customers/presentation/bloc/customer_state.dart';
import 'package:sharq_crm/features/customers/presentation/page/customer_part/customer_auth_pages/sign_in_customer_page.dart';
import 'package:sharq_crm/features/customers/presentation/page/customer_part/customer_auth_pages/signup_customer_page.dart';
import 'package:sharq_crm/features/customers/presentation/page/customer_part/payment_page.dart';
import 'package:sharq_crm/features/customers/presentation/page/customer_part/widget/club_info_blocbuilder.dart';
import 'package:sharq_crm/features/customers/presentation/page/customer_part/widget/customer_info_blocbuilder.dart';
import 'package:sharq_crm/features/customers/presentation/page/customer_part/widget/photostudio_info_blocbuilder.dart';
import 'package:sharq_crm/features/services/service_page.dart';
import 'package:sharq_crm/features/services/album/domain/entity/album_entity.dart';
import 'package:sharq_crm/features/services/album/presentation/bloc/album_bloc.dart';
import 'package:sharq_crm/features/services/club/domain/entity/club_entity.dart';
import 'package:sharq_crm/features/services/club/presentation/bloc/club_bloc.dart';
import 'package:sharq_crm/features/services/photo_studio/domain/entity/photostudio_entity.dart';
import 'package:sharq_crm/features/services/photo_studio/presentation/bloc/photostudio_bloc.dart';
import 'package:sharq_crm/features/services/photo_studio/presentation/bloc/photostudio_event.dart';
import 'package:sharq_crm/features/services/photo_studio/presentation/bloc/photostudio_state.dart';
import 'package:sharq_crm/features/injection_container.dart' as di;
import 'package:sharq_crm/features/services/video/presentation/bloc/video_bloc.dart';

import '../../../../services/video/domain/entity/video_entity.dart';
import '../../../domain/entity/customer_entity.dart';
import '../../bloc/customer_cubit.dart';
import 'arxiv_page.dart';
import 'paid_page.dart';

class CustomerHomePage extends StatefulWidget {
  CustomerHomePage({Key? key, required this.customerId}) : super(key: key);
  String customerId;

  @override
  State<CustomerHomePage> createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {
  //
  List<PhotoStudioEntity> photoStudioForCustomerlist = [];
  List<PhotoStudioEntity> photoStudioForCustomerUnPaidlist = [];
  List<PhotoStudioEntity> photoStudioForCustomerPaidlist = [];
  List<String> photoStudioIds = [];

  //
  List<ClubEntity> clubForCustomerlist = [];

  //
  List<AlbumEntity> albumForCustomerlist = [];
  List<AlbumEntity> albumForCustomerUnPaidlist = [];
  List<AlbumEntity> albumForCustomerPaidlist = [];

  //
  List<VideoEntity> videoForCustomerlist = [];
  List<VideoEntity> videoForCustomerUnPaidlist = [];
  List<VideoEntity> videoForCustomerPaidlist = [];
  List<String> videoIds = [];

  //
  bool loading = false;
  String info = 'To\'lov\n qilish';

  //
  @override
  Widget build(BuildContext context) {
    //
    //
    BlocProvider.of<CustomerCubit>(context, listen: false)
        .loadCustomerFromCollection(widget.customerId);
    BlocProvider.of<PhotoStudioBloc>(context, listen: false)
        .add(PhotoStudioGetForCustomerEvent(widget.customerId));
    BlocProvider.of<ClubBloc>(context, listen: false)
        .add(ClubGetForCustomerEvent(widget.customerId));
    BlocProvider.of<AlbumBloc>(context, listen: false)
        .add(AlbumGetForCustomerEvent(widget.customerId));
    BlocProvider.of<VideoBloc>(context, listen: false)
        .add(VideoGetForCustomerEvent(widget.customerId));
    print("::::build ichida BlocProviderlar chaqirildi");

    //
    //

    return Scaffold(
      //
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //
              //current customer info
              CustomerInfoBlocBuilder(),

              //
              //PhotoStudio infos
              BlocBuilder<PhotoStudioBloc, PhotoStudioStates>(
                builder: (contextPhotostudio, photoState) {
                  if (photoState is PhotoStudioInitialState) {
                  } else if (photoState is PhotoStudioLoadingState) {
                    return LoadingWidget();
                  } else if (photoState is PhotoStudioErrorState) {
                    return Center(
                      child: Text(
                          'photoState da error bor: ${photoState.message}'),
                    );
                  } else if (photoState is PhotoStudioLoadedForCustomerState) {
                    photoStudioForCustomerlist = photoState.loaded;

                    photoStudioForCustomerlist.forEach((element) {
                      //1
                      var containUnPaid = photoStudioForCustomerUnPaidlist
                          .where(//error bulishi mumkin
                              (element2) =>
                                  element2.photo_studio_id ==
                                  element.photo_studio_id);
                      if (containUnPaid.isEmpty) {
                        if (!element.isPaid) {
                          photoStudioForCustomerUnPaidlist.add(element);
                          print(
                              "::::photoStudioForCustomerUnPaidlist  docslar: ${photoStudioForCustomerUnPaidlist}");
                        }
                      }
                      //2
                      var containPaid = photoStudioForCustomerPaidlist.where(
                          (element2) =>
                              element2.photo_studio_id ==
                              element.photo_studio_id);
                      if (containPaid.isEmpty) {
                        if (element.isPaid) {
                          photoStudioForCustomerPaidlist.add(element);
                          print(
                              "::::photoStudioForCustomerPaidlist  docslar: ${photoStudioForCustomerPaidlist}");
                        }
                      }
                    });
                  }

                  return Column(
                    children: [
                      photoStudioForCustomerUnPaidlist.length == 0
                          ? Container(
                              child: Text(
                                'Photo Studio hali buyurtma qilinmadi.',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          : PhotoStudioInfoBlocBuilder(
                              photoStudioForCustomerlist:
                                  photoStudioForCustomerUnPaidlist,
                              customerId: widget.customerId,
                              loading: loading,
                            ),
                    ],
                  );
                },
              ),

              // Club infos
              ClubInfoBlocBuilder(
                clubForCustomerlist: clubForCustomerlist,
                loading: loading,
                customerId: widget.customerId,
              ),

              // Album infos

              //
              // Video infos
              BlocBuilder<VideoBloc, VideoStates>(
                builder: (contextVideo, videoState) {
                  // print("Video States: $videoState");
                  if (videoState is VideoInitialState) {
                    // return Text('Initial state...');
                  } else if (videoState is VideoLoadingState) {
                    return LoadingWidget();
                  } else if (videoState is VideoErrorState) {
                    return Center(
                      child: Text(
                          'VideoState da error bor: ${videoState.message}'),
                    );
                  } else if (videoState is VideoLoadedForCustomerState) {
                    videoForCustomerlist = videoState.loaded;
                    if (videoForCustomerlist.length == 0) {
                      return Text(
                        'Video hali buyurtma qilinmadi.',
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      );
                    }
                    videoForCustomerlist.forEach((element) {
                      //1
                      var containUnPaid = videoForCustomerUnPaidlist.where(
                          (element2) => element2.video_id == element.video_id);
                      if (containUnPaid.isEmpty) {
                        if (!element.isPaid) {
                          videoForCustomerUnPaidlist.add(element);
                          print(
                              "::::videoForCustomerUnPaidlist  docslar: ${videoForCustomerUnPaidlist}\n");
                        } else {
                          //2
                          var containPaid = videoForCustomerPaidlist.where(
                              (element2) =>
                                  element2.video_id == element.video_id);
                          if (containPaid.isEmpty) {
                            if (element.isPaid) {
                              videoForCustomerPaidlist.add(element);
                              print(
                                  "::::videoForCustomerPaidlist  docslar: ${videoForCustomerPaidlist}\n");
                            }
                          }
                        }
                      }
                    });
                    //

                    //
                    print(
                        "::::videoForCustomerlist ga state orqali doc olindi: ${videoForCustomerlist.toString()}");
                  }

                  return Column(
                    children: [
                      videoForCustomerUnPaidlist.length == 0
                          ? Text(
                              'Video hali buyurtma qilinmadi.',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            )
                          : _currentVideoInfoUnPaid(videoForCustomerUnPaidlist,
                              contextVideo, widget.customerId),
                    ],
                  );
                },
              ),

              // to'lov qilinadigan button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(40),
                        foregroundColor: Colors.white,
                        shape: CircleBorder(),
                        backgroundColor: Colors.green),
                    onPressed: () {
                      //
                      double price1 = 0;
                      double price2 = 0;
                      double price3 = 0;
                      double price4 = 0;
                      //

                      photoStudioForCustomerlist.forEach((element) {
                        price1 += element.price * element.ordersNumber;
                      });
                      clubForCustomerlist.forEach((element) {
                        price2 += element.price *
                            element.ordersNumber *
                            (element.toHour - element.fromHour);
                      });
                      albumForCustomerlist.forEach((element) {
                        price3 += element.price * element.ordersNumber;
                      });
                      videoForCustomerUnPaidlist.forEach((element) {
                        price4 += element.price * element.ordersNumber;
                      });

                      //
                      double totalPrice = price2 + price1 + price4 + price3;

                      //
                      //
                      videoForCustomerUnPaidlist.forEach((element) {
                        String videoId = element.video_id;
                        videoIds.add(videoId);
                        print(
                            "videoIds.length customer home pagedagi========${videoIds.length.toString()}");
                        print("Video ID: $videoId");
                      });
                      print("total price: ${totalPrice.toString()}");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PaymentPage(
                                    totalPrice: totalPrice,
                                    customerId: widget.customerId,
                                    videoIds: videoIds,
                                  )));
                      setState(() {});
                    },
                    child: Text(info)),
              ),
            ],
          ),
        ),
      ),

      //
      drawer: _drawerCHP(),

      //
      floatingActionButton: _floatingButton(widget.customerId),
    );
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
                                                    loading = true;
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

//
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
                                                              CustomerHomePage(
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
                itemCount: videoForCustomerUnPaidlist.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  //
  Widget _drawerCHP() {
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
                      builder: (ctx) => CustomerHomePage(
                            customerId: widget.customerId,
                          )));
            },
          ),
          ListTile(
            leading: Icon(Icons.monetization_on_outlined),
            title: Text("To\'lov qilinganlar"),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (_) => PaidCustomerPage(
                            customerId: widget.customerId,
                            videoForCustomerPaidlist: videoForCustomerPaidlist,
                          )),
                  (route) => false);
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

              //
            },
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 22, left: 44),
            child: SizedBox(child: Text("Sharq crm system version: 1.0.0")),
          ),
        ],
      ),
    );
  }

  //
  FloatingActionButton _floatingButton(String customerId) {
    return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          print("cus ID: $customerId");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (ctx) => ServicePage(
                        customerId: customerId,
                      )));
        });
  }

//
// Padding _currentVideoInfo(List<VideoEntity> videoForCustomerlist,
//     BuildContext contextVideo, String customerId) {
//   return Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: SingleChildScrollView(
//       child: Column(
//         children: [
//           Text(
//             "Video Studio",
//             style: TextStyle(
//                 color: Colors.green,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 20),
//           ),
//           Container(
//             width: double.infinity,
//             child: ListView.builder(
//               physics: NeverScrollableScrollPhysics(),
//               itemBuilder: (ctx, index) {
//                 if (videoForCustomerlist.isEmpty) {
//                   return Center(
//                     child: Text('Buyurtma mavjud emas'),
//                   );
//                 }
//                 VideoEntity video = videoForCustomerlist[index];
//                 return Padding(
//                   padding: const EdgeInsets.all(7.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(22),
//                         ),
//                         color: Colors.green.shade100),
//                     child: Column(
//                       children: [
//                         ListTile(
//                           title: Row(
//                             children: [
//                               Text("Manzil: "),
//                               Text(
//                                 "${video.address}",
//                                 style: TextStyle(
//                                     color: Colors.red,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ),
//                         ),
//                         ListTile(
//                             title: Row(
//                               children: [
//                                 Text("Zakz sanasi: "),
//                                 Text(
//                                   "${video.dateTimeOfWedding}",
//                                   style: TextStyle(
//                                       color: Colors.red,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ],
//                             ),
//                             subtitle: Row(
//                               children: [
//                                 Text(
//                                   "Zakzlar soni: ",
//                                   style: TextStyle(
//                                       fontSize: 15, color: Colors.black),
//                                 ),
//                                 Text(
//                                   "${video.ordersNumber}",
//                                   style: TextStyle(
//                                       color: Colors.red,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ],
//                             )),
//                         ListTile(
//                             title: Row(
//                               children: [
//                                 Text(
//                                   "Narxi: ",
//                                   style: TextStyle(
//                                       fontSize: 15, color: Colors.black),
//                                 ),
//                                 Text(
//                                   "${video.price * video.ordersNumber}",
//                                   style: TextStyle(
//                                       color: Colors.red,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 Text(
//                                   " so\'m",
//                                   style: TextStyle(
//                                       fontSize: 15, color: Colors.black),
//                                 ),
//                               ],
//                             ),
//                             subtitle: Text("ID: ${video.video_id}")),
//                         Text("isPaid: ${video.isPaid.toString()}"),
//                         SizedBox(
//                           width: double.infinity,
//                           child: ElevatedButton(
//                               style: ButtonStyle(
//                                   shape: MaterialStateProperty.all<
//                                       RoundedRectangleBorder>(
//                                       RoundedRectangleBorder(
//                                           borderRadius:
//                                           BorderRadius.circular(18.0),
//                                           side:
//                                           BorderSide(color: Colors.red))),
//                                   backgroundColor:
//                                   MaterialStateProperty.all(Colors.red)),
//                               onPressed: () {
//                                 showDialog(
//                                     context: contextVideo,
//                                     builder: (contextVideo) {
//                                       return AlertDialog(
//                                         title: Text("Videoni o\'chirish"),
//                                         content: Text(
//                                             'Siz rostdan ham Videoni olib tashlamoqchimisiz?'),
//                                         icon: Icon(Icons.warning),
//                                         actions: [
//                                           OutlinedButton(
//                                               onPressed: () {
//                                                 Navigator.pop(contextVideo);
//                                               },
//                                               child: Text("Yo\'q")),
//                                           OutlinedButton(
//                                               onPressed: () {
//                                                 contextVideo
//                                                     .read<VideoBloc>()
//                                                     .add(VideoDeleteEvent(
//                                                     customerId:
//                                                     customerId,
//                                                     videoId:
//                                                     video.video_id));
//
//                                                 context.read<VideoBloc>().add(
//                                                     VideoGetForCustomerEvent(
//                                                         customerId));
//                                                 setState(() {
//                                                   loading = true;
//                                                 });
//                                                 Navigator.pop(contextVideo);
//
//                                                 SnackBarMessage()
//                                                     .showSuccessSnackBar(
//                                                     message:
//                                                     'O\'chirildi',
//                                                     context:
//                                                     contextVideo);
//                                               },
//                                               child: Text("Ha")),
//                                         ],
//                                       );
//                                     });
//                               },
//                               child: Text('Olib tashlash')),
//                         )
//                       ],
//                     ),
//                   ),
//                 );
//               },
//               itemCount: videoForCustomerlist.length,
//               scrollDirection: Axis.vertical,
//               shrinkWrap: true,
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
}

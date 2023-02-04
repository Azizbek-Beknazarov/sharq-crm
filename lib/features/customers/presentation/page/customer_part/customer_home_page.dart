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
import 'package:sharq_crm/features/customers/presentation/page/customer_part/widget/album_info_blocbuilder.dart';
import 'package:sharq_crm/features/customers/presentation/page/customer_part/widget/club_info_blocbuilder.dart';
import 'package:sharq_crm/features/customers/presentation/page/customer_part/widget/customer_info_blocbuilder.dart';
import 'package:sharq_crm/features/customers/presentation/page/customer_part/widget/photostudio_info_blocbuilder.dart';
import 'package:sharq_crm/features/customers/presentation/page/customer_part/widget/video_info_blocbuilder.dart';
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
  List<ClubEntity> clubForCustomerUnPaidlist = [];
  List<ClubEntity> clubForCustomerPaidlist = [];
  List<String> clubIds = [];

  //
  List<AlbumEntity> albumForCustomerlist = [];
  List<AlbumEntity> albumForCustomerUnPaidlist = [];
  List<AlbumEntity> albumForCustomerPaidlist = [];
  List<String> albumIds = [];

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

                    if (photoStudioForCustomerlist.length == 0) {
                      return Text(
                        'Photo Studio hali buyurtma qilinmadi.',
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      );
                    }
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
                        } else {
                          //2
                          var containPaid =
                              photoStudioForCustomerPaidlist.where((element2) =>
                                  element2.photo_studio_id ==
                                  element.photo_studio_id);
                          if (containPaid.isEmpty) {
                            if (element.isPaid) {
                              photoStudioForCustomerPaidlist.add(element);
                              print(
                                  "::::photoStudioForCustomerPaidlist  docslar: ${photoStudioForCustomerPaidlist}");
                            }
                          }
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
              BlocBuilder<ClubBloc, ClubStates>(
                builder: (contextClub, clubState) {
                  if (clubState is ClubInitialState) {
                  } else if (clubState is ClubLoadingState) {
                    return LoadingWidget();
                  } else if (clubState is ClubErrorState) {
                    return Center(
                      child:
                          Text('clubState da error bor: ${clubState.message}'),
                    );
                  } else if (clubState is ClubLoadedForCustomerState) {
                    clubForCustomerlist = clubState.loaded;
                    if (clubForCustomerlist.length == 0) {
                      return Text(
                        'Club hali buyurtma qilinmadi.',
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      );
                    }
                    clubForCustomerlist.forEach((element) {
                      //1
                      var containUnPaid = clubForCustomerUnPaidlist.where(
                          (element2) => element2.club_id == element.club_id);
                      if (containUnPaid.isEmpty) {
                        if (!element.isPaid) {
                          clubForCustomerUnPaidlist.add(element);
                          print(
                              "::::clubForCustomerUnPaidlist  docslar: ${clubForCustomerUnPaidlist}");
                        } else {
                          //2
                          var containPaid = clubForCustomerPaidlist.where(
                              (element2) =>
                                  element2.club_id == element.club_id);
                          if (containPaid.isEmpty) {
                            if (element.isPaid) {
                              clubForCustomerPaidlist.add(element);
                              print(
                                  "::::clubForCustomerPaidlist  docslar: ${clubForCustomerPaidlist}");
                            }
                          }
                        }
                      }
                    });
                  }

                  return Column(
                    children: [
                      clubForCustomerUnPaidlist.length == 0
                          ? Text(
                              "Club hali buyurtma qilinmadi.",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            )
                          : ClubInfoBlocBuilder(
                              clubForCustomerlist: clubForCustomerUnPaidlist,
                              customerId: widget.customerId),
                    ],
                  );
                },
              ),

              // Album infos
              BlocBuilder<AlbumBloc, AlbumStates>(
                builder: (contextAlbum, albumState) {
                  if (albumState is AlbumInitialState) {
                  } else if (albumState is AlbumLoadingState) {
                    return LoadingWidget();
                  } else if (albumState is AlbumErrorState) {
                    return Center(
                      child: Text(
                          'AlbumState da error bor: ${albumState.message}'),
                    );
                  } else if (albumState is AlbumLoadedForCustomerState) {
                    albumForCustomerlist = albumState.loaded;
                    if (albumForCustomerlist.length == 0) {
                      return Text(
                        'Album hali buyurtma qilinmadi.',
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      );
                    }
                    albumForCustomerlist.forEach((element) {
                      //1
                      var containUnPaid = albumForCustomerUnPaidlist.where(
                          (element2) => element2.album_id == element.album_id);
                      if (containUnPaid.isEmpty) {
                        if (!element.isPaid) {
                          albumForCustomerUnPaidlist.add(element);
                          print(
                              "::::albumForCustomerUnPaidlist  docslar: ${albumForCustomerUnPaidlist}");
                        } else {
                          //2
                          var containPaid = albumForCustomerPaidlist.where(
                              (element2) =>
                                  element2.album_id == element.album_id);
                          if (containPaid.isEmpty) {
                            if (element.isPaid) {
                              albumForCustomerPaidlist.add(element);
                              print(
                                  "::::albumForCustomerPaidlist  docslar: ${albumForCustomerPaidlist}");
                            }
                          }
                        }
                      }
                    });
                  }

                  return Column(
                    children: [
                      albumForCustomerUnPaidlist.length == 0
                          ? Text(
                              'Album hali buyurtma qilinmadi.',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            )
                          : AlbumInfoBlocBuilder(
                              albumForCustomerlist: albumForCustomerUnPaidlist,
                              customerId: widget.customerId),
                    ],
                  );
                },
              ),
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
                          : VideoInfoBlocBuilder(
                              videoForCustomerUnPaidlist:
                                  videoForCustomerUnPaidlist,
                              customerId: widget.customerId,
                            ),
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

                      photoStudioForCustomerUnPaidlist.forEach((element) {
                        price1 += element.price * element.ordersNumber;
                        String photoId = element.photo_studio_id;
                        print("::::PhotoStudio ID: $photoId");
                        photoStudioIds.add(photoId);
                      });
                      clubForCustomerUnPaidlist.forEach((element) {
                        price2 += element.price *
                            element.ordersNumber *
                            (element.toHour - element.fromHour);
                        String clubId = element.club_id;
                        print("::::Club ID: $clubId");
                        clubIds.add(clubId);
                      });
                      albumForCustomerUnPaidlist.forEach((element) {
                        price3 += element.price * element.ordersNumber;
                        String albumId = element.album_id;
                        print("::::Album ID: $albumId");
                        albumIds.add(albumId);
                      });
                      videoForCustomerUnPaidlist.forEach((element) {
                        price4 += element.price * element.ordersNumber;
                        String videoId = element.video_id;
                        print("::::Video ID: $videoId");
                        videoIds.add(videoId);
                      });

                      //
                      double totalPrice = price2 + price1 + price4 + price3;

                      //
                      print(
                          "::::photoStudioIds.length customer home pagedagi========${photoStudioIds.length.toString()}");
                      print(
                          "::::clubIds.length customer home pagedagi========${clubIds.length.toString()}");
                      print(
                          "::::albumIds.length customer home pagedagi========${albumIds.length.toString()}");
                      print(
                          "::::videoIds.length customer home pagedagi========${videoIds.length.toString()}");
                      print("::::total price: ${totalPrice.toString()}");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PaymentPage(
                                    totalPrice: totalPrice,
                                    customerId: widget.customerId,
                                    videoIds: videoIds,
                                    photoIds: photoStudioIds,
                                    clubIds: clubIds,
                                    albumIds: albumIds,
                                  )));
                      // setState(() {});
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
                            photoStudioForCustomerPaidlist:
                                photoStudioForCustomerPaidlist,
                            albumForCustomerPaidlist: albumForCustomerPaidlist,
                            clubForCustomerPaidlist: clubForCustomerPaidlist,
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
}

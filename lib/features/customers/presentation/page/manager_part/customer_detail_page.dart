import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sharq_crm/features/customers/domain/entity/customer_entity.dart';
import 'package:sharq_crm/features/customers/presentation/page/manager_part/paid_page_for_manager.dart';
import 'package:sharq_crm/features/customers/presentation/page/manager_part/payment_manager_page.dart';
import 'package:sharq_crm/features/customers/presentation/page/manager_part/widget/album_info_show_widget.dart';
import 'package:sharq_crm/features/customers/presentation/page/manager_part/widget/club_info_show_widget.dart';
import 'package:sharq_crm/features/customers/presentation/page/manager_part/widget/photostudio_info_show_widget.dart';
import 'package:sharq_crm/features/customers/presentation/page/manager_part/widget/video_info_show_widget.dart';
import 'package:sharq_crm/features/orders/presentation/bloc/car_bloc/car_bloc.dart';
import 'package:sharq_crm/features/orders/presentation/bloc/car_bloc/car_event.dart';
import 'package:sharq_crm/features/orders/presentation/bloc/car_bloc/car_state.dart';

import 'package:uuid/uuid.dart';

import '../../../../../core/util/loading_widget.dart';
import '../../../../orders/domain/entity/car_entity.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../../../../services/album/domain/entity/album_entity.dart';
import '../../../../services/album/presentation/bloc/album_bloc.dart';
import '../../../../services/album/presentation/page/manager_part/album_order_page.dart';
import '../../../../services/club/domain/entity/club_entity.dart';
import '../../../../services/club/presentation/bloc/club_bloc.dart';
import '../../../../services/club/presentation/page/manager_part/club_order_page.dart';
import '../../../../services/photo_studio/domain/entity/photostudio_entity.dart';
import '../../../../services/photo_studio/presentation/bloc/photostudio_bloc.dart';
import '../../../../services/photo_studio/presentation/bloc/photostudio_event.dart';
import '../../../../services/photo_studio/presentation/bloc/photostudio_state.dart';
import '../../../../services/photo_studio/presentation/page/customer_part/photostudio_home_page.dart';
import '../../../../services/photo_studio/presentation/page/manager_part/photo_studio_order_page.dart';
import '../../../../services/video/domain/entity/video_entity.dart';
import '../../../../services/video/presentation/bloc/video_bloc.dart';
import '../../../../services/video/presentation/page/manager_part/video_order_page.dart';
import '../customer_part/paid_page.dart';
import 'customers_page.dart';
import 'widget/customer_phone_call_widget.dart';

class CustomerDetailPage extends StatefulWidget {
  const CustomerDetailPage({Key? key, required this.customerId})
      : super(key: key);

  final String customerId;

  @override
  State<CustomerDetailPage> createState() => _CustomerDetailPageState();
}

class _CustomerDetailPageState extends State<CustomerDetailPage> {
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
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String info = 'To\'lov\n qilish';

  //
  //
  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    //
    BlocProvider.of<PhotoStudioBloc>(context, listen: false)
        .add(PhotoStudioGetForCustomerEvent(widget.customerId));
    BlocProvider.of<ClubBloc>(context, listen: false)
        .add(ClubGetForCustomerEvent(widget.customerId));
    BlocProvider.of<AlbumBloc>(context, listen: false)
        .add(AlbumGetForCustomerEvent(widget.customerId));
    BlocProvider.of<VideoBloc>(context, listen: false)
        .add(VideoGetForCustomerEvent(widget.customerId));

    //
    print("::::Customer detail page dagi build chaqirildi.");
    //

    return Scaffold(

      key: _scaffoldKey,
      drawer: _drawerManager(),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            return _scaffoldKey.currentState?.openDrawer();
          },
          icon: Icon(Icons.menu),
        ),
        title: Text(widget.customerId),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                    } else if (photoState
                        is PhotoStudioLoadedForCustomerState) {
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
                            var containPaid = photoStudioForCustomerPaidlist
                                .where((element2) =>
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
                            : PhotoStudioInfoShow(
                                photoStudioForCustomerlist:
                                    photoStudioForCustomerUnPaidlist,
                                customerId: widget.customerId,
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
                            : ClubInfoShowWidget(
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
                            : AlbumInfoShowWidget(
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
                            : VideoInfoShowWidget(
                          videoForCustomerUnPaidlist:
                          videoForCustomerUnPaidlist,
                          customerId: widget.customerId,
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
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
                              builder: (context) => PaymentManagerPage(
                                    totalPrice: totalPrice,
                                    customerId: widget.customerId,
                                    photoIds: photoStudioIds,
                                    videoIds: videoIds,
                                    clubIds: clubIds,
                                    albumIds: albumIds,
                                  )));
                      // setState(() {});
                    },
                    child: Text(info)),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _speedDial(),

    );
  }
  //
  _speedDial(){
    return SpeedDial(
      elevation: 12,
      backgroundColor: Colors.green,
      animatedIcon: AnimatedIcons.menu_close,
      children: [
        SpeedDialChild(
          onTap: () {
            final route = MaterialPageRoute(
                builder: (context) => PhotoStudioOrderPage(
                  customerId: widget.customerId,
                ));
            Navigator.push(context, route);
          },
          child: Text('photo'),
        ),

        SpeedDialChild(
          onTap: () {
            final route = MaterialPageRoute(
                builder: (context) => ClubOrderPage(
                  customerId: widget.customerId,
                ));
            Navigator.push(context, route);
          },
          child: Text('club'),
        ),
        SpeedDialChild(
          onTap: () {
            final route = MaterialPageRoute(
                builder: (context) => AlbumOrderPage(
                  customerId: widget.customerId,
                ));
            Navigator.push(context, route);
          },
          child: Text('album'),
        ),
        SpeedDialChild(
          onTap: () {
            final route = MaterialPageRoute(
                builder: (context) => VideoOrderPage(
                  customerId: widget.customerId,
                ));
            Navigator.push(context, route);
          },
          child: Text('video'),
        ),


        //
      ],
    );
  }

  //
  Widget _drawerManager() {
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
                    "  widget.customerId,",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.red,
              image: DecorationImage(
                image: AssetImage('assets/images/backgroundformanager.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Bosh sahifa"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => CustomersPage()));
            },
          ),

          ListTile(
            leading: Icon(Icons.monetization_on_outlined),
            title: Text("To\'lov qilinganlar"),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (_) => PaidPageForManager(
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
              // Navigator.pushAndRemoveUntil(
              //     context,
              //     MaterialPageRoute(
              //         builder: (_) =>
              //             ArxivCustomerPage(customerId: widget.customerId)),
              //         (route) => false);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Sozlamalar"),
            onTap: () {},
          ),
          // ListTile(
          //   leading: Icon(Icons.logout),
          //   title: Text("Chiqish"),
          //   onTap: () {
          //     showDialog(
          //         context: context,
          //         builder: (context) {
          //           return AlertDialog(
          //             title: Text("Accountdan chiqish"),
          //             content: Text('Siz rostdan ham ketyapsizmi?'),
          //             icon: Icon(
          //               Icons.warning,
          //               color: Colors.yellow,
          //             ),
          //             actions: [
          //               OutlinedButton(
          //                   onPressed: () {
          //                     Navigator.pop(context);
          //                   },
          //                   child: Text('Yo\'q')),
          //               OutlinedButton(
          //                   onPressed: () {
          //                     BlocProvider.of<AuthBloc>(context)
          //                         .add(LogoutEvent());
          //
          //                     Navigator.pushAndRemoveUntil(
          //                         context,
          //                         MaterialPageRoute(
          //                             builder: (context) => SignInPage()),
          //                             (route) => false);
          //                     setState(() {});
          //                     SnackBarMessage().showSuccessSnackBar(
          //                         message: 'Accountdan chiqildi',
          //                         context: context);
          //                   },
          //                   child: Text("Ha")),
          //             ],
          //           );
          //         });
          //     //
          //
          //     //
          //   },
          // ),
          Padding(
            padding: const EdgeInsets.only(bottom: 22, left: 44),
            child: SizedBox(child: Text("Sharq crm system version: 1.0.0")),
          ),
        ],
      ),
    );
  }
}

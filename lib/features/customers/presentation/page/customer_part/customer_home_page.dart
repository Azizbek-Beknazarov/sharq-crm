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

class CustomerHomePage extends StatefulWidget {
  CustomerHomePage({Key? key, required this.customerId}) : super(key: key);
  String customerId;

  @override
  State<CustomerHomePage> createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {
  List<PhotoStudioEntity> photoStudioForCustomerlist = [];
  List<ClubEntity> clubForCustomerlist = [];
  List<AlbumEntity> albumForCustomerlist = [];
  List<VideoEntity> videoForCustomerlist = [];
  bool loading = false;

  String info = 'To\'lov qilish';

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

    //
    //

    return Scaffold(
      //
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //current customer info
              BlocBuilder<CustomerCubit, CustomersState>(
                  builder: (context, customerStatefrom) {
                print(customerStatefrom.toString());
                if (customerStatefrom is CustomerLoading) {
                  return LoadingWidget();
                } else if (customerStatefrom is CustomerError) {
                  return Text(customerStatefrom.message);
                } else if (customerStatefrom
                    is CustomerLoadedFromCollectionState) {
                  CustomerEntity currentCustomer = customerStatefrom.entity;

                  return _currentCustomerInfo(currentCustomer);
                }
                return LoadingWidget();
              }),
              //PhotoStudio infos
              BlocBuilder<PhotoStudioBloc, PhotoStudioStates>(
                builder: (contextPhotostudio, photoState) {
                  print("PhotoStudioStates: $photoState");
                  if (photoState is PhotoStudioInitialState) {
                    // return Text('Initial state...');
                  } else if (photoState is PhotoStudioLoadingState) {
                    return LoadingWidget();
                  } else if (photoState is PhotoStudioErrorState) {
                    return Center(
                      child: Text(
                          'photoState da error bor: ${photoState.message}'),
                    );
                  } else if (photoState is PhotoStudioLoadedForCustomerState) {
                    print("PhotoStudioStates: $photoState");
                    photoStudioForCustomerlist = photoState.loaded;
                    print(
                        "photoStudioForCustomerlist: ${photoStudioForCustomerlist.toString()}");
                  }

                  return Column(
                    children: [
                      photoStudioForCustomerlist.length == 0
                          ? Container(
                              child: Text(
                                'Photo Studio hali buyurtma qilinmadi.',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          : _currentPhotoStudioInfo(photoStudioForCustomerlist,
                              contextPhotostudio, widget.customerId),
                    ],
                  );
                },
              ),
              // Club infos
              BlocBuilder<ClubBloc, ClubStates>(
                builder: (contextClub, clubState) {
                  print("Club States: $clubState");
                  if (clubState is ClubInitialState) {
                    // return Text('Initial state...');
                  } else if (clubState is ClubLoadingState) {
                    return LoadingWidget();
                  } else if (clubState is ClubErrorState) {
                    return Center(
                      child:
                          Text('clubState da error bor: ${clubState.message}'),
                    );
                  } else if (clubState is ClubLoadedForCustomerState) {
                    print("Club States: $clubState");
                    clubForCustomerlist = clubState.loaded;
                    print(
                        "clubForCustomerlist: ${clubForCustomerlist.toString()}");
                  }

                  return Column(
                    children: [
                      clubForCustomerlist.length == 0
                          ? Text(
                              "Club hali buyurtma qilinmadi.",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            )
                          : _currentClubInfo(clubForCustomerlist, contextClub,
                              widget.customerId),
                    ],
                  );
                },
              ),
              // Album infos
              BlocBuilder<AlbumBloc, AlbumStates>(
                builder: (contextAlbum, albumState) {
                  print("Album States: $albumState");
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
                    print("Album States: $albumState");
                    albumForCustomerlist = albumState.loaded;

                    print(
                        "AlbumForCustomerlist: ${albumForCustomerlist.toString()}");
                  }

                  return Column(
                    children: [
                      albumForCustomerlist.length == 0
                          ? Text(
                              'Album hali buyurtma qilinmadi.',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            )
                          : _currentAlbumInfo(albumForCustomerlist,
                              contextAlbum, widget.customerId),
                    ],
                  );
                },
              ),
              //
              // Video infos
              BlocBuilder<VideoBloc, VideoStates>(
                builder: (contextVideo, videoState) {
                  print("Video States: $videoState");
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
                    print("Video States: $videoState");
                    videoForCustomerlist = videoState.loaded;
                    //

                    //
                    print(
                        "VideoForCustomerlist: ${videoForCustomerlist.toString()}");
                  }

                  return Column(
                    children: [
                      videoForCustomerlist.length == 0
                          ? Text(
                              'Video hali buyurtma qilinmadi.',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            )
                          : _currentVideoInfo(videoForCustomerlist,
                              contextVideo, widget.customerId),
                    ],
                  );
                },
              ),

              //

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black)),
                    onPressed: () {
                      double price1 = 0;
                      double price2 = 0;
                      double price3 = 0;
                      double price4 = 0;
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
                      videoForCustomerlist.forEach((element) {
                        price4 += element.price * element.ordersNumber;
                      });

                      double totalPrice = price2 + price1 + price4 + price3;
                      info = "${(totalPrice).toString()}";
                      setState(() {});
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PaymentPage(
                                    totalPrice: totalPrice,
                                    customerId: widget.customerId,
                                  )));
                    },
                    child: Text(info)),
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: _floatingButton(widget.customerId),
    );
  }

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

  // AppBar _appBar(String customerId) {
  //   return AppBar(
  //     title: Text('Customer Home Page'),
  //     leading: IconButton(
  //       onPressed: () {
  //
  //       },
  //       icon: Icon(Icons.home_repair_service),
  //     ),
  //     actions: [
  //       // IconButton(
  //       //   onPressed: () {
  //       //     BlocProvider.of<CustomerCubit>(context).logOutCustomer();
  //       //     print("cus ID: $customerId");
  //       //     Navigator.pushAndRemoveUntil(
  //       //         context,
  //       //         MaterialPageRoute(builder: (context) => SignInCustomerPage()),
  //       //         (route) => false);
  //       //   },
  //       //   icon: Icon(Icons.logout),
  //       // ),
  //     ],
  //   );
  // }

//
  Padding _currentCustomerInfo(CustomerEntity currentCustomer) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
            color: Colors.black12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              currentCustomer.name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              currentCustomer.phone.toString(),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              currentCustomer.customerId.toString(),
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
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

                                contextPhotostudio.read<PhotoStudioBloc>().add(
                                    PhotoStudioDeleteEvent(
                                        customerId: customerId,
                                        photoStudioId:
                                            photoStudio.photo_studio_id));
                                context.read<PhotoStudioBloc>().add(
                                    PhotoStudioGetForCustomerEvent(customerId));
                                setState(() {
                                  loading = true;
                                });
                                SnackBarMessage().showSuccessSnackBar(
                                    message: 'O\'chirildi',
                                    context: contextPhotostudio);

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

  //
  Padding _currentClubInfo(List<ClubEntity> clubForCustomerlist,
      BuildContext contextClub, String customerId) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "Club",
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
                  if (clubForCustomerlist.isEmpty) {
                    return Center(
                      child: Text('Buyurtma mavjud emas'),
                    );
                  }
                  ClubEntity club = clubForCustomerlist[index];
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
                                  Text("Zakz sanasi: "),
                                  Text(
                                    "${club.dateTimeOfWedding}",
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
                                    "${club.ordersNumber}",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                          ListTile(
                            title: Row(
                              children: [
                                Text("Soati: "),
                                Text(
                                  "${club.fromHour.toString()}",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(" dan "),
                                Text(
                                  "${club.toHour.toString()}",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(" gacha."),
                              ],
                            ),
                          ),
                          ListTile(
                              title: Row(
                                children: [
                                  Text(
                                    "Narxi: ",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                  Text(
                                    "${club.price * club.ordersNumber * (club.toHour - club.fromHour)}",
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
                              subtitle: Text("ID: ${club.club_id}")),
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


                                  contextClub.read<ClubBloc>().add(
                                      ClubDeleteEvent(
                                          customerId: customerId,
                                          clubId: club.club_id));
                                  context.read<ClubBloc>().add(ClubGetForCustomerEvent(customerId));
                                  setState(() {
                                    loading = true;
                                  });
                                  SnackBarMessage().showSuccessSnackBar(
                                      message: 'O\'chirildi',
                                      context: contextClub);
                                },
                                child: Text('Olib tashlash')),
                          )
                        ],
                      ),
                    ),
                  );
                },
                itemCount: clubForCustomerlist.length,
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
                                  contextAlbum.read<AlbumBloc>().add(
                                      AlbumDeleteEvent(
                                          customerId: customerId,
                                          albumId: album.album_id));
                                  SnackBarMessage().showSuccessSnackBar(
                                      message: 'O\'chirildi',
                                      context: contextAlbum);
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
  Padding _currentVideoInfo(List<VideoEntity> videoForCustomerlist,
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
                  if (videoForCustomerlist.isEmpty) {
                    return Center(
                      child: Text('Buyurtma mavjud emas'),
                    );
                  }
                  VideoEntity video = videoForCustomerlist[index];
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
                                  contextVideo.read<VideoBloc>().add(
                                      VideoDeleteEvent(
                                          customerId: customerId,
                                          videoId: video.video_id));
                                  SnackBarMessage().showSuccessSnackBar(
                                      message: 'O\'chirildi',
                                      context: contextVideo);
                                },
                                child: Text('Olib tashlash')),
                          )
                        ],
                      ),
                    ),
                  );
                },
                itemCount: videoForCustomerlist.length,
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

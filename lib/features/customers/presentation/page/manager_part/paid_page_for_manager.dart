import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sharq_crm/features/customers/presentation/page/manager_part/customers_page.dart';

import '../../../../services/album/domain/entity/album_entity.dart';
import '../../../../services/club/domain/entity/club_entity.dart';
import '../../../../services/photo_studio/domain/entity/photostudio_entity.dart';
import '../../../../services/video/domain/entity/video_entity.dart';
import 'customer_detail_page.dart';

class PaidPageForManager extends StatefulWidget {
  PaidPageForManager(
      {Key? key,
        required this.customerId,
        required this.photoStudioForCustomerPaidlist,
        required this.videoForCustomerPaidlist,
        required this.albumForCustomerPaidlist,
        required this.clubForCustomerPaidlist
      })
      : super(key: key);
  final String customerId;
  List<PhotoStudioEntity> photoStudioForCustomerPaidlist;
  List<VideoEntity> videoForCustomerPaidlist;
  List<ClubEntity> clubForCustomerPaidlist;
  List<AlbumEntity> albumForCustomerPaidlist;

  @override
  State<PaidPageForManager> createState() => _PaidCustomerPageState();
}

class _PaidCustomerPageState extends State<PaidPageForManager> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
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
              widget.clubForCustomerPaidlist.length == 0
                  ? Padding(
                padding: const EdgeInsets.all(28.0),
                child: Center(
                  child: Text(
                    'Tasdiqlangan Club buyurtma mavjud emas.',
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                ),
              )
                  : _currentClubInfo(widget.clubForCustomerPaidlist, context,
                  widget.customerId),
              SizedBox(
                height: 10,
              ),
              widget.albumForCustomerPaidlist.length == 0
                  ? Padding(
                padding: const EdgeInsets.all(28.0),
                child: Center(
                  child: Text(
                    'Tasdiqlangan Album buyurtma mavjud emas.',
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                ),
              )
                  : _currentAlbumInfo(widget.albumForCustomerPaidlist, context,
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
                          Text("isPaid: ${club.isPaid.toString()}"),
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
                          Text("isPaid: ${album.isPaid.toString()}"),
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
            leading: Icon(Icons.person),
            title: Text("Mijoz sahifasi"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) =>
                          CustomerDetailPage(customerId: widget.customerId)));
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
          // ListTile(
          //   leading: Icon(Icons.grid_3x3_outlined),
          //   title: Text("Arxivlar"),
          //   onTap: () {
          //     Navigator.pushAndRemoveUntil(
          //         context,
          //         MaterialPageRoute(
          //             builder: (_) =>
          //                 ArxivCustomerPage(customerId: widget.customerId)),
          //             (route) => false);
          //   },
          // ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Sozlamalar"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Bosh sahifa"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) =>
                          CustomersPage()));
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.logout),
          //   title: Text("Chiqish"),
          //   onTap: () {
          //     //
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
          //                     BlocProvider.of<CustomerCubit>(context)
          //                         .logOutCustomer();
          //                     print("cus ID: ${widget.customerId}");
          //                     Navigator.pushAndRemoveUntil(
          //                         context,
          //                         MaterialPageRoute(
          //                             builder: (context) =>
          //                                 SignInCustomerPage()),
          //                             (route) => false);
          //
          //                     SnackBarMessage().showSuccessSnackBar(
          //                         message: 'Accountdan chiqildi',
          //                         context: context);
          //                   },
          //                   child: Text("Ha")),
          //             ],
          //           );
          //         });
          //     //
          //   },
          // )
        ],
      ),
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/util/loading_widget.dart';
import '../../../../../../core/util/snackbar_message.dart';
import '../../../../../services/club/domain/entity/club_entity.dart';
import '../../../../../services/club/presentation/bloc/club_bloc.dart';

class ClubInfoBlocBuilder extends StatefulWidget {
  ClubInfoBlocBuilder(
      {Key? key,
      required this.clubForCustomerlist,
      required this.loading,
      required this.customerId})
      : super(key: key);
  List<ClubEntity> clubForCustomerlist;

  bool loading = false;
  String customerId;

  @override
  State<ClubInfoBlocBuilder> createState() => _ClubInfoBlocBuilderState();
}

class _ClubInfoBlocBuilderState extends State<ClubInfoBlocBuilder> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClubBloc, ClubStates>(
      builder: (contextClub, clubState) {
        // print("Club States: $clubState");
        if (clubState is ClubInitialState) {
          // return Text('Initial state...');
        } else if (clubState is ClubLoadingState) {
          return LoadingWidget();
        } else if (clubState is ClubErrorState) {
          return Center(
            child: Text('clubState da error bor: ${clubState.message}'),
          );
        } else if (clubState is ClubLoadedForCustomerState) {
          // print("Club States: $clubState");
          widget.clubForCustomerlist = clubState.loaded;
          // print(
          //     "clubForCustomerlist: ${clubForCustomerlist.toString()}");
        }

        return Column(
          children: [
            widget.clubForCustomerlist.length == 0
                ? Text(
                    "Club hali buyurtma qilinmadi.",
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  )
                : _currentClubInfo(
                    widget.clubForCustomerlist, contextClub, widget.customerId),
          ],
        );
      },
    );
  }

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
                                  showDialog(
                                      context: contextClub,
                                      builder: (contextClub) {
                                        return AlertDialog(
                                          title: Text("Clubni o\'chirish"),
                                          content: Text(
                                              'Siz rostdan ham Clubni olib tashlamoqchimisiz?'),
                                          icon: Icon(Icons.warning),
                                          actions: [
                                            OutlinedButton(
                                                onPressed: () {
                                                  Navigator.pop(contextClub);
                                                },
                                                child: Text("Yo\'q")),
                                            OutlinedButton(
                                                onPressed: () {
                                                  contextClub
                                                      .read<ClubBloc>()
                                                      .add(ClubDeleteEvent(
                                                          customerId:
                                                              customerId,
                                                          clubId:
                                                              club.club_id));
                                                  context.read<ClubBloc>().add(
                                                      ClubGetForCustomerEvent(
                                                          customerId));
                                                  setState(() {
                                                    widget.loading = true;
                                                  });
                                                  Navigator.pop(contextClub);
                                                  SnackBarMessage()
                                                      .showSuccessSnackBar(
                                                          message:
                                                              'O\'chirildi',
                                                          context: contextClub);
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
}

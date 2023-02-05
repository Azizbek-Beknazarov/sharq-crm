
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/features/customers/presentation/page/manager_part/customer_detail_page.dart';

import '../../../../../../core/util/snackbar_message.dart';
import '../../../../../services/club/domain/entity/club_entity.dart';
import '../../../../../services/club/presentation/bloc/club_bloc.dart';

class ClubInfoShowWidget extends StatefulWidget {
  ClubInfoShowWidget(
      {Key? key, required this.clubForCustomerlist, required this.customerId})
      : super(key: key);
  List<ClubEntity> clubForCustomerlist;

  //
  // bool loading = false;
  String customerId;

  @override
  State<ClubInfoShowWidget> createState() => _ClubInfoShowWidgetState();
}

class _ClubInfoShowWidgetState extends State<ClubInfoShowWidget> {
  @override
  Widget build(BuildContext context) {
    return _currentClubInfo(
        widget.clubForCustomerlist, context, widget.customerId);
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
                          color: Colors.white10),
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

                                                  setState(() {
                                                    // widget.loading = true;
                                                  });
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (_) =>
                                                              CustomerDetailPage(
                                                                  customerId: widget
                                                                      .customerId)));
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
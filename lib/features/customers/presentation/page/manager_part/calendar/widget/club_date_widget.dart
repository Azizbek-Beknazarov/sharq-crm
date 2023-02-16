import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/features/services/club/domain/entity/club_entity.dart';
import 'package:sharq_crm/features/services/club/presentation/bloc/club_bloc.dart';
import 'package:intl/intl.dart';

class ClubDateWidget extends StatelessWidget {
  ClubDateWidget({Key? key, required this.dateTime}) : super(key: key);
  DateTime dateTime;
  List<ClubEntity> clubDateTimeList = [];

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ClubBloc>(context)
        .add(ClubStudioGetDateTimeOrdersEvent(dateTime: dateTime));
    return BlocBuilder<ClubBloc, ClubStates>(builder: (context, state) {
      if (state is ClubLoadedDateState) {
        clubDateTimeList = state.clubDateTimelist;
        print("::::clubDateTimeList ${clubDateTimeList.toString()}");
      }
      return Scaffold(
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  // padding: EdgeInsets.all(22),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(22),
                      ),
                      color: Colors.black12),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          children: [
                            Text(
                              "${DateFormat("dd-MM-yyyy").format(dateTime)}",
                              style: TextStyle(
                                  fontSize: 26,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              " sanadagi buyurtmalar soni:",
                              style: TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text(
                            clubDateTimeList.length.toString(),
                            style: TextStyle(
                                        fontSize: 50,
                                color: Colors.purple,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              ///
              Expanded(
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx, index) {
                    if (clubDateTimeList.isEmpty) {
                      return Center(
                        child: Text('Buyurtma mavjud emas'),
                      );
                    }
                    ClubEntity club = clubDateTimeList[index];
                    // DateTime? date=DateTime.tryParse(photoStudio.dateTimeOfWedding);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(22),
                            ),
                            color: Colors.tealAccent),
                        child: Column(
                          children: [
                            ListTile(
                                title: Row(
                                  children: [
                                    Text("Zakz sanasi: "),
                                    Text(
                                      "${DateFormat("dd-MM-yyyy").format(DateTime.parse(club.dateTimeOfWedding))}",
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
                              subtitle: Row(
                                children: [
                                  Text(
                                    "Oldindan to\'lov qilingan: ",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                  Text(
                                    "${club.prepayment}",
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
                                    "${club.price * club.ordersNumber * (club.toHour - club.fromHour) - club.prepayment}",
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
                                    "${club.club_id}",
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
                                  club.isPaid
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
                            SizedBox(
                              height: 5,
                            ),
                            ListTile(
                              title: Row(
                                children: [
                                  Text(
                                    "Qo\'shimcha: ",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                  Flexible(child: Text(club.description))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: clubDateTimeList.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

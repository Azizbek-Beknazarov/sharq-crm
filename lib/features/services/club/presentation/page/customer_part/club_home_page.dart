import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/features/services/club/domain/entity/club_entity.dart';
import 'package:sharq_crm/features/services/club/presentation/bloc/club_bloc.dart';
import 'package:sharq_crm/features/services/club/presentation/page/customer_part/customer_club_order_page.dart';

class ClubHomePage extends StatefulWidget {
  ClubHomePage({Key? key, required this.customerId}) : super(key: key);
  String customerId;

  @override
  State<ClubHomePage> createState() => _ClubHomePageState();
}

class _ClubHomePageState extends State<ClubHomePage> {
  List<ClubEntity> club = [];

  @override
  Widget build(BuildContext context) {
    print("Club home page dagi customer ID: ${widget.customerId}");
    context.read<ClubBloc>().add(ClubGetEvent(club));
    return BlocBuilder<ClubBloc , ClubStates>(
        builder: (context, clubState) {
      if (clubState is ClubLoadingState) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: CircularProgressIndicator(),
              ),
              Text('Loading data...'),
            ],
          ),
        );
      } else if (clubState is ClubLoadedState) {
        club = clubState.loaded;
      } else if (clubState is ClubErrorState) {
        return Column(
          children: [
            Center(
              child: CircularProgressIndicator(),
            ),
            Text(clubState.message),
          ],
        );
      }

      //
      //
      return Scaffold(
        appBar: AppBar(
          title: Text('Club Home Page'),
        ),
        body: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(12),
          children: [
            Text(
              'Club suratlari galeriya korinishida boladi',
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(
              height: 5,
            ),
            Column(
              children: club.map((e) {
                return Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          'Club id: ${e.club_id.toString()}',
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Tavsif: ${e.description.toString()}',
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Club narxi: ${e.price.toString()}',
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => CustomerClubOrderPage(
                                customerId: widget.customerId,
                              )));
                },
                child: Text(
                  'Zakaz qilish',
                  style: TextStyle(fontSize: 22),
                ))
          ],
        ),
      );
    });

    //
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/features/services/album/domain/entity/album_entity.dart';
import 'package:sharq_crm/features/services/album/presentation/bloc/album_bloc.dart';
import 'customer_album_order_page.dart';

class AlbumHomePage extends StatefulWidget {
  AlbumHomePage({Key? key, required this.customerId}) : super(key: key);
  String customerId;

  @override
  State<AlbumHomePage> createState() => _AlbumHomePageState();
}

class _AlbumHomePageState extends State<AlbumHomePage> {
  List<AlbumEntity> album = [];

  @override
  Widget build(BuildContext context) {
    print("Album home page dagi customer ID: ${widget.customerId}");
    context.read<AlbumBloc>().add(AlbumGetEvent(album));
    return BlocBuilder<AlbumBloc, AlbumStates>(builder: (context, albumState) {
      if (albumState is AlbumLoadingState) {
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
      } else if (albumState is AlbumLoadedState) {
        album = albumState.loaded;
      } else if (albumState is AlbumErrorState) {
        return Column(
          children: [
            Center(
              child: CircularProgressIndicator(),
            ),
            Text(albumState.message),
          ],
        );
      }

      //
      //
      return Scaffold(
        appBar: AppBar(
          title: Text('Album Home Page'),
        ),
        body: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(12),
          children: [
            Text(
              'Album suratlari galeriya korinishida boladi',
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(
              height: 5,
            ),
            Column(
              children: album.map((e) {
                return Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          'Album id: ${e.album_id.toString()}',
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
                          'Album narxi: ${e.price.toString()}',
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
                          builder: (ctx) => CustomerAlbumOrderPage(
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

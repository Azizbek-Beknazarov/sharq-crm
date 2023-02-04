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
      return SafeArea(
        child: Scaffold(

          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,

            child: ListView (
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(12),
              children: [
                Image.asset('assets/images/albumm.png'),
                Text(
                  'Album suratlari galeriya korinishida boladi',
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(
                  height: 15,
                ),

                Column(
                  children: album.map((e) {
                    return Card(
                      child: Column(
                        children: [

                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,

                                border: Border.all(color: Colors.red),


                                borderRadius: BorderRadius.all(Radius.circular(14))
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ListTile(
                                    title: Text(
                                      'Tavsif: ',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    title: Text(
                                      ' ${e.description.toString()}',
                                      style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.red),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5,),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.black12,

                                border: Border.all(color: Colors.red),


                                borderRadius: BorderRadius.all(Radius.circular(14))
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ListTile(
                                    title: Text(
                                      'Album narxi: ',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    title: Column(
                                      children: [

                                        Text(
                                          ' ${e.price.toString()}',
                                          style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.red),
                                        ),
                                        Text(" so\'m"),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5,),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
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
          ),
        ),
      );
    });

    //
  }
}

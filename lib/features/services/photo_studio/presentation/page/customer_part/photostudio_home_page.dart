import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/features/services/photo_studio/domain/entity/photostudio_entity.dart';
import 'package:sharq_crm/features/services/photo_studio/presentation/bloc/photostudio_bloc.dart';
import 'package:sharq_crm/features/services/photo_studio/presentation/bloc/photostudio_event.dart';
import 'package:sharq_crm/features/services/photo_studio/presentation/bloc/photostudio_state.dart';
import 'package:sharq_crm/features/services/photo_studio/presentation/page/customer_part/customer_photostudio_order_page.dart';

class PhotoStudioHomePage extends StatefulWidget {
  PhotoStudioHomePage({Key? key,required this.customerId}) : super(key: key);
String customerId;
  @override
  State<PhotoStudioHomePage> createState() => _PhotoStudioHomePageState();
}

class _PhotoStudioHomePageState extends State<PhotoStudioHomePage> {
  List<PhotoStudioEntity> photoStudio = [];



  @override
  Widget build(BuildContext context) {
    context.read<PhotoStudioBloc>().add(PhotoStudioGetEvent(photoStudio));
    return BlocBuilder<PhotoStudioBloc, PhotoStudioStates>(
        builder: (context, photeState) {
      if (photeState is PhotoStudioLoadingState) {
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
      } else if (photeState is PhotoStudioLoadedState) {
        photoStudio = photeState.loaded;
      } else if (photeState is PhotoStudioErrorState) {
        return Column(
          children: [
            Center(
              child: CircularProgressIndicator(),
            ),
            Text(photeState.message),
          ],
        );
      }

      //
      //
      return Scaffold(
        appBar: AppBar(
          title: Text('Photo Studio Home Page'),
        ),
        body: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(12),
          children: [
            Text(
              'Rasmxona suratlari galeriya korinishida boladi',
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(
              height: 5,
            ),
            Column(
              children: photoStudio.map((e) {
                return Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          'Katta rasm o\'lchami: ${e.largeImage.toString()}',
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Kichik rasm o\'lchami: ${e.smallImage.toString()}',
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Rasmxona narxi: ${e.price.toString()}',
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
                          builder: (ctx) => CustomerPhotoStudioOrderPage(customerId: widget.customerId,)));
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

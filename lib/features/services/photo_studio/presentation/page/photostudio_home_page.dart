import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/features/services/photo_studio/domain/entity/photostudio_entity.dart';
import 'package:sharq_crm/features/services/photo_studio/presentation/bloc/photostudio_bloc.dart';
import 'package:sharq_crm/features/services/photo_studio/presentation/bloc/photostudio_event.dart';
import 'package:sharq_crm/features/services/photo_studio/presentation/bloc/photostudio_state.dart';
import 'package:sharq_crm/features/services/photo_studio/presentation/page/photo_studio_update_page_for_manager.dart';

class PhotoStudioHomePage extends StatefulWidget {
  PhotoStudioHomePage({Key? key}) : super(key: key);

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
        appBar: AppBar(title: Text('Photo Studio Home Page'), actions: [IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (ctx)=>PhotoStudioUpdatePageForManager()));
        }, icon: Icon(Icons.settings))]),
        body: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(12),
          children: [
            Text('Rasmxona suratlari galeriya korinishida boladi'),

            SizedBox(
              height: 5,
            ),
            Column(
              children: photoStudio.map((e) {
                return Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(e.description),
                        subtitle: Text(e.largeImage.toString()),
                      ),
                      ListTile(
                        title: Text(e.photo_studio_id),
                        subtitle: Text(e.price.toString()),
                      ),
                      ListTile(
                        title: Text(e.photo_studio_id),
                        subtitle: Text(e.price.toString()),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            // Text('Rasmxona narxi 700 000'),
            TextButton(onPressed: () {

            }, child: Text('zakaz qilish'))
          ],
        ),
      );
    });

    //
  }
}

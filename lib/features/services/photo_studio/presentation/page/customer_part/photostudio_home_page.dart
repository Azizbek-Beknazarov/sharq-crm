import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/features/services/photo_studio/domain/entity/photostudio_entity.dart';
import 'package:sharq_crm/features/services/photo_studio/presentation/bloc/photostudio_bloc.dart';
import 'package:sharq_crm/features/services/photo_studio/presentation/bloc/photostudio_event.dart';
import 'package:sharq_crm/features/services/photo_studio/presentation/bloc/photostudio_state.dart';
import 'package:sharq_crm/features/services/photo_studio/presentation/page/customer_part/customer_photostudio_order_page.dart';

class PhotoStudioHomePage extends StatefulWidget {
  PhotoStudioHomePage({Key? key, required this.customerId}) : super(key: key);
  String customerId;

  @override
  State<PhotoStudioHomePage> createState() => _PhotoStudioHomePageState();
}

class _PhotoStudioHomePageState extends State<PhotoStudioHomePage> {
  List<PhotoStudioEntity> photoStudio = [];

  @override
  Widget build(BuildContext context) {
    print("Photostudio home page dagi customer ID: ${widget.customerId}");
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
       
        body: SafeArea(
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.all(12),
            children: [
              Image.asset('assets/images/photo.png'),
              Text(
                'Rasmxona suratlari galeriya korinishida boladi',
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(
                height: 5,
              ),
              Column(
                children: photoStudio.map((e) {
                  return Card(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blueAccent),
                              borderRadius: BorderRadius.all(Radius.circular(14))
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: ListTile(
                                      title: Text(
                                        'Katta rasm o\'lchami: ',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListTile(
                                      title: Column(
                                        children: [
                                          SizedBox(
                                              height: 90,
                                              width: 80,
                                              child: Image.asset("assets/images/portret.png")),
                                          Text(
                                            ' ${e.largeImage.toString()}',
                                            style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.red),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: ListTile(
                                      title: Text(
                                        'Rasm soni: ',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListTile(
                                      title: Column(
                                        children: [

                                          Text(
                                            ' ${e.largePhotosNumber.toString()}',
                                            style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.red),
                                          ),
                                          Text("dona"),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5,),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blueAccent),
                              borderRadius: BorderRadius.all(Radius.circular(14))
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: ListTile(
                                      title: Text(
                                        'Kichik rasm o\'lchami: ',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListTile(
                                      title: Column(
                                        children: [
                                          SizedBox(
                                              height: 80,
                                              width: 90,
                                              child: Image.asset("assets/images/land.png")),
                                          Text(
                                            ' ${e.smallImage.toString()}',
                                            style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.red),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: ListTile(
                                      title: Text(
                                        'Rasm soni: ',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListTile(
                                      title: Column(
                                        children: [

                                          Text(
                                            ' ${e.smallPhotoNumber.toString()}',
                                            style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.red),
                                          ),
                                          Text("dona"),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5,),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blueAccent),
                              borderRadius: BorderRadius.all(Radius.circular(14))
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  title: Text(
                                    'Rasmlar tayyor bo\'lish muddati: ',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Column(
                                    children: [

                                      Text("10",
                                        // ' ${e.largePhotosNumber.toString()}',
                                        style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.red),
                                      ),
                                      Text(" kun"),
                                    ],
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
                                    'Rasmxona narxi: ',
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
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(80),
                      foregroundColor: Colors.white,
                      shape: CircleBorder(),
                      backgroundColor: Colors.green),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => CustomerPhotoStudioOrderPage(
                                  customerId: widget.customerId,
                                )));
                  },
                  child: Text(
                    'Buyurtma berish',
                    style: TextStyle(fontSize: 22),
                  ))
            ],
          ),
        ),
      );
    });

    //
  }
}

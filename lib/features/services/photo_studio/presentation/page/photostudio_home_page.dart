import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PhotoStudioHomePage extends StatelessWidget {
  const PhotoStudioHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Studio Home Page'),
      ),
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,

        padding: EdgeInsets.all(12),
        children: [
          Text('Rasmxona suratlari galeriya korinishida boladi'),
          SizedBox(height: 5,),
          Text('Rasmxona narxi 700 000'),
          TextButton(onPressed: (){},  child: Text('zakaz qilish'))
        ],
      ),
    );
  }
}

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageAddPage extends StatefulWidget {
  const ImageAddPage({Key? key}) : super(key: key);

  @override
  State<ImageAddPage> createState() => _ImageAddPageState();
}

class _ImageAddPageState extends State<ImageAddPage> {
  String imageUrl='';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Center(
              child: IconButton(
                  onPressed: () async {
                    //
                    ImagePicker image = ImagePicker();
                    XFile? xFile =
                        await image.pickImage(source: ImageSource.gallery);
                    if(xFile==null) return;
                    print("::::xFile path: ${xFile.path}");
                    String uniqueFileName=DateTime.now().millisecondsSinceEpoch.toString();
                    //
                    Reference referenceRoot=FirebaseStorage.instance.ref();
                    Reference referenceDirImages=referenceRoot.child('images');
                    Reference referenceImageToUpload=referenceDirImages.child(uniqueFileName);
                   try{
                    await referenceImageToUpload.putFile(File(xFile.path));
                     imageUrl=await referenceImageToUpload.getDownloadURL();
                   }catch(e){}
                    //
                  },
                  icon: Icon(Icons.add_photo_alternate_outlined)),
            )
          ],
        ),
      ),
    );
  }
}

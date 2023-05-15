

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/common_function.dart';

class SelectImage extends StatefulWidget {
  const SelectImage({Key? key, this.imageUrl, required this.onSelect,}) : super(key: key);
  final Function(File?) onSelect;
  final String? imageUrl;

  @override
  State<SelectImage> createState() => _SelectImageState();
}

class _SelectImageState extends State<SelectImage> {
  File? image;
  showImage()
  {
    if (widget.imageUrl != "" && image == null)
      {
        image = null ;

        return NetworkImage(widget.imageUrl.toString());
      }
    else if(widget.imageUrl  == "" && image != null)
      {
        return FileImage(image!);

      }
    else
      {
        image = null ;
        return const AssetImage("assets/images/blood.jpg");
      }
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      children: [
      CircleAvatar(
      radius: 52.5,
      backgroundColor: Colors.red,
      child: CircleAvatar(
        backgroundColor: Colors.grey,
        backgroundImage: showImage(),
        radius: 50,
      ),
    ),

        Positioned(
          bottom: 0,
            right: 0,
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.red,
              child: IconButton(
                onPressed: () async{
                  File? file = await CommonFunctions.pickImage();
                  if(file != null)
                    {
                      image = file;
                      widget.onSelect(image);
                    }
                  setState(() {

                  });
                },
                icon: const Icon(Icons.camera_alt_rounded, color: Colors.white,size: 17,),

              ),
            )
        )
      ]
    );
  }
}

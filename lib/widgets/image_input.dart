import "dart:io";

import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";
import "package:path/path.dart" as path;
import "package:path_provider/path_provider.dart" as path_provider;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future<void> _takePicture() async {
    final imagePicker = ImagePicker();
    final imageFile = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (imageFile == null) return;

    setState(() {
      _storedImage = File(imageFile.path);
    });

    final appDir = await path_provider.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await File(imageFile.path).copy("${appDir.path}/$fileName");

    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _storedImage != null
          ? Image.file(
            _storedImage,
            fit: BoxFit.cover,
            width: double.infinity,
            )
          : const Text("No image yet!", textAlign: TextAlign.center),
          alignment: Alignment.center,
        ),
        SizedBox(),
        Expanded(
          child: TextButton.icon(
            label: const Text("Take a picture"),
            icon: Icon(Icons.camera),
            onPressed: _takePicture,
          ),
        ),
      ],
    );
  }
}
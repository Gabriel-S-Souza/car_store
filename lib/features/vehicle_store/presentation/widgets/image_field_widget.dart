import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class ImageFieldWidget extends StatefulWidget {
  final void Function(Uint8List image)? onImageSelected;

  const ImageFieldWidget({
    super.key,
    this.onImageSelected,
  });

  @override
  State<ImageFieldWidget> createState() => _ImageFieldWidgetState();
}

class _ImageFieldWidgetState extends State<ImageFieldWidget> {
  XFile? _imageFile;

  @override
  Widget build(BuildContext context) => FractionallySizedBox(
        widthFactor: 0.75,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            AspectRatio(
              aspectRatio: 1.4,
              child: InkWell(
                onTap: () => pickImage(context),
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Theme.of(context).primaryColor,
                        Theme.of(context).secondaryHeaderColor,
                      ],
                    ),
                    image: _imageFile != null
                        ? DecorationImage(
                            image: FileImage(File(_imageFile!.path)),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: _imageFile == null
                      ? Icon(
                          Icons.photo_camera,
                          color: Colors.white,
                          size: MediaQuery.of(context).size.width * 0.14,
                        )
                      : null,
                ),
              ),
            ),
            if (_imageFile != null)
              Positioned(
                top: -16,
                right: -16,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Theme.of(context).primaryColor,
                        Theme.of(context).secondaryHeaderColor,
                      ],
                    ),
                  ),
                  child: GestureDetector(
                    child: const Padding(
                      padding: EdgeInsets.all(5.8),
                      child: Icon(
                        Icons.photo_camera,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    onTap: () {
                      pickImage(context);
                    },
                  ),
                ),
              )
          ],
        ),
      );

  Future<void> pickImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final source = await requestImageSource(context);

    if (source == null) return;

    final imageData = await picker.pickImage(
      source: source,
      imageQuality: 50,
      maxWidth: 800,
    );

    if (imageData != null) {
      setState(() {
        _imageFile = imageData;
      });
      final Uint8List image = await imageData.readAsBytes();
      widget.onImageSelected?.call(image);
    }
  }

  Future<ImageSource?> requestImageSource(BuildContext context) async => showModalBottomSheet(
        context: context,
        builder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_imageFile != null)
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Remover imagem'),
                onTap: () {
                  setState(() {
                    _imageFile = null;
                  });
                  context.pop();
                },
              ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Câmera'),
              onTap: () => context.pop(ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Galeria'),
              onTap: () => context.pop(ImageSource.gallery),
            ),
          ],
        ),
      );
}

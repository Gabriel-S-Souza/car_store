import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class UserImageFieldWidget extends StatefulWidget {
  final Uint8List? initialImage;
  final void Function(Uint8List? image)? onImageSelected;

  const UserImageFieldWidget({
    super.key,
    this.initialImage,
    this.onImageSelected,
  });

  @override
  State<UserImageFieldWidget> createState() => _UserImageFieldWidgetState();
}

class _UserImageFieldWidgetState extends State<UserImageFieldWidget> {
  Uint8List? image;

  @override
  void initState() {
    super.initState();
    if (widget.initialImage != null) {
      setState(() {
        image = widget.initialImage;
      });
    }
  }

  Orientation get orientation => MediaQuery.of(context).orientation;

  @override
  Widget build(BuildContext context) => Center(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            InkWell(
              onTap: () => pickImage(context),
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).cardColor,
                      Theme.of(context).cardColor.withAlpha(150)
                    ],
                  ),
                ),
                child: CircleAvatar(
                  radius: 48,
                  backgroundColor: Colors.transparent,
                  backgroundImage: image != null ? MemoryImage(image!) : null,
                  child: image == null
                      ? Icon(
                          Icons.photo_camera,
                          color: Colors.white,
                          size: orientation == Orientation.portrait
                              ? MediaQuery.of(context).size.width * 0.14
                              : MediaQuery.of(context).size.width * 0.06,
                        )
                      : null,
                ),
              ),
            ),
            if (image != null)
              Positioned(
                top: -12,
                right: -12,
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => pickImage(context),
                  child: IgnorePointer(
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: Center(
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
                          child: const Padding(
                            padding: EdgeInsets.all(5.8),
                            child: Icon(
                              Icons.photo_camera,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
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
      imageQuality: 80,
      maxWidth: 1500,
    );

    if (imageData != null) {
      image = await imageData.readAsBytes();
      if (image != null) {
        setState(() {});
        widget.onImageSelected?.call(image);
      }
    }
  }

  Future<ImageSource?> requestImageSource(BuildContext context) async => showModalBottomSheet(
        context: context,
        builder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (image != null)
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Remover imagem'),
                onTap: () {
                  setState(() {
                    image = null;
                    widget.onImageSelected?.call(null);
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

import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../../../setups/utils/constants/default_user_image.dart';

class UserAvatarWidget extends StatelessWidget {
  final Uint8List? image;
  const UserAvatarWidget({super.key, this.image});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.primary,
        ),
        child: CircleAvatar(
          radius: 54,
          backgroundColor: Colors.transparent,
          backgroundImage: MemoryImage(image ?? defaultUserImage),
        ),
      );
}

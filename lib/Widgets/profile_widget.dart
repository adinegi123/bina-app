
import 'package:flutter/material.dart';

import '../constants/color.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClicked;
  final bool isEdit;

  const ProfileWidget(
      {Key? key,
        required this.imagePath,
        required this.onClicked,
        this.isEdit = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(children: [
          buildImage(),
          Positioned(
              bottom: 0, right: 1, child: buildEditIcon(ColorConst.buttonColor))
        ]),
      ),
    );
  }

  Widget buildImage() {
    final image = NetworkImage(imagePath);
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          width: 128,
          height: 128,
          fit: BoxFit.cover,
          child: InkWell(
            onTap: onClicked,
          ),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipOval(
        child: Container(
            color: ColorConst.buttonColor,
            padding: EdgeInsets.all(4),
            child: isEdit
                ? Icon(
              Icons.add_a_photo,
              size: 22,
              color: Colors.white,
            )
                : Icon(
              Icons.edit,
              size: 22,
              color: Colors.white,
            )),
      ),
    );
  }
}


import 'package:flutter/material.dart';

import '../../constants/images.dart';

class PhotoDetailPage extends StatefulWidget {
  final var1;

  const PhotoDetailPage({Key? key, this.var1}) : super(key: key);

  @override
  State<PhotoDetailPage> createState() => _PhotoDetailPageState();
}

class _PhotoDetailPageState extends State<PhotoDetailPage> {
  @override
  Widget build(BuildContext context) {
    int var1 = widget.var1;
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: 'btn1$var1',
            child: Image.asset(
              Images.jpgPost,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            ),
          ),
          Positioned(
            bottom: 8,
            child: Container(
                decoration: BoxDecoration(color: Colors.black12),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum',
                  style: TextStyle(fontSize: 12, color: Colors.black),
                )),
          )
        ],
      ),
      // body: Hero(
      //   tag: 'btn$var1' ,
      //   child: Image.asset(Images.jpgPost  ,
      //     fit: BoxFit.cover,),
      // ),
    );
  }
}


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';



class CommentedPhotoDetailPage extends StatefulWidget {
  final var1;
  final var2;

  const CommentedPhotoDetailPage({Key? key, this.var1, this.var2})
      : super(key: key);

  @override
  State<CommentedPhotoDetailPage> createState() =>
      _CommentedPhotoDetailPageState();
}

class _CommentedPhotoDetailPageState extends State<CommentedPhotoDetailPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(
        "inside commented photo detail------------------var 1>>>>>>>>>>>${widget.var1.toString()}");
    print(
        "inside commented photo detail------------------var 2>>>>>>>>>>>${widget.var2.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    int var1 = widget.var1;
    return Scaffold(
      body: Center(
        child: Hero(
          tag: 'btn2$var1',
          child:    //
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl:
              "${ApiConstants.imageUrl}${widget.var2.toString()}",
              placeholder: (context, url) =>
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/bina_logo.png',
                        ),
                      ),
                    ),
                  ),
              errorWidget: (context, url, error) =>
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/bina_logo.png'),
                      ),
                    ),
                  ),
            ),
          ),
        ),
      ),
      // body: Hero(
      //   tag: 'btn$var1' ,
      //   child: Image.asset(Images.jpgPost  ,
      //     fit: BoxFit.cover,),
      // ),
    );
  }
}

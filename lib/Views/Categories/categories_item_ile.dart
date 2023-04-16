import 'package:flutter/material.dart';

class ItemTile extends StatelessWidget {
  int? itemNo = null;
  String? itemName = null;
  String? itemImage = null;

  // String?  image="";

  ItemTile(
      int? item_no,
      String? item_name,
      String categoryImage,
      // String image
      ) {
    this.itemNo = item_no;
    this.itemName = item_name;
    this.itemImage = categoryImage;
    // this.image;
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Colors.primaries[itemNo! % Colors.primaries.length];
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.lightGreen.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 1,
                offset: const Offset(0, .1),
              ),
            ],
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(2)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Image.network(
                itemImage!,
                width: 50,
                height: 50,
              ),
            ),
            Text(
              itemName!,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

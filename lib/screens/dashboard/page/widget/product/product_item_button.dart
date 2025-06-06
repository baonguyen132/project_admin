import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductItemButton extends StatefulWidget {
  Function () handle  ;

  ProductItemButton({super.key , required this.handle});

  @override
  State<ProductItemButton> createState() => _ProductItemButtonState();
}

class _ProductItemButtonState extends State<ProductItemButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,

      decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(100))
      ),
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: () {
          widget.handle() ;
        },
        child: MouseRegion(
          child: Icon(
            CupertinoIcons.cart_fill_badge_plus,
            color: Colors.white,

          ),
        ),
      ),
    );
  }
}

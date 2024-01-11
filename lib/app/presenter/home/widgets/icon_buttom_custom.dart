import 'package:flutter/material.dart';

class IconButtonCustom extends StatelessWidget {
  final Color backgroundColor;
  final IconData icon;

  const IconButtonCustom({
    super.key,
    required this.backgroundColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child:  Center(
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}

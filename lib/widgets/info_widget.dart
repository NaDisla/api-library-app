import 'package:flutter/material.dart';

class InfoWidget extends StatelessWidget {
  const InfoWidget({
    Key? key,
    required this.info,
    required this.color,
  }) : super(key: key);

  final Object? info;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '$info',
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
      ),
    );
  }
}

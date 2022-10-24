import 'package:flutter/material.dart';

class AlertWidget extends StatelessWidget {
  const AlertWidget({
    Key? key,
    required this.title,
    this.content,
    required this.actions,
  }) : super(key: key);

  final String title;
  final String? content;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content!),
      actions: actions,
    );
  }
}

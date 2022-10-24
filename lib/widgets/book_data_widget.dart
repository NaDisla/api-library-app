import 'package:api_library_app/models/models.dart';
import 'package:api_library_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class BookDataWidget extends StatelessWidget {
  const BookDataWidget({
    Key? key,
    required this.data,
    required this.titleStyle,
    required this.propStyle,
    required this.position,
  }) : super(key: key);

  final List<Book> data;
  final TextStyle titleStyle;
  final TextStyle propStyle;
  final int position;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data[position].title,
          style: titleStyle,
        ),
        const SizedBox(height: 5.0),
        BookDetailWidget(
            propIcon: Icons.category_rounded,
            propTitle: 'Category: ',
            propDetail: data[position].category!,
            propStyle: propStyle),
        const SizedBox(height: 5.0),
        BookDetailWidget(
            propIcon: Icons.person,
            propTitle: 'Author: ',
            propDetail: data[position].author,
            propStyle: propStyle),
        const SizedBox(height: 5.0),
        BookDetailWidget(
            propIcon: Icons.monetization_on,
            propTitle: 'Total Sales: ',
            propDetail: '${data[position].totalSales}',
            propStyle: propStyle),
      ],
    );
  }
}

import 'package:flutter/widgets.dart';

class EmptyEntityList extends StatelessWidget {
  const EmptyEntityList({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) =>
      Center(child: Text(title, style: TextStyle(fontSize: 25)));
}

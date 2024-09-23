import 'package:flutter/material.dart';

class HomeStat extends StatelessWidget {
  const HomeStat({super.key, required this.color, required this.titleText, required this.subheading});
  final Color color;
  final String titleText;
  final String subheading;

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30)
      ),
      child:  Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titleText),
           Row(
            children: [
             const Icon(Icons.tab),
              Text(subheading)
            ],
          )
        ],
      ),
    );
  }
}
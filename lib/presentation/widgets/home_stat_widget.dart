import 'package:flutter/material.dart';

class HomeStat extends StatelessWidget {
  const HomeStat(
      {super.key,
      required this.color,
      required this.titleText,
      required this.subheading,
      required this.image});
  final Color color;
  final String image;
  final String titleText;
  final String subheading;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(30)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              titleText,           
              style:  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold ),
            ),
          ),
          Row(
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 50, maxHeight: 50),
                child: Image.asset(
                  image, 
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(width: 14),
              ConstrainedBox(
                constraints:  BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * 0.14),
                child: Text(
                  subheading,
                   style:  const TextStyle(fontSize: 16),
              ),
              )
            ],
          )
        ],
      ),
    );
  }
}

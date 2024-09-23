import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      style: GoogleFonts.montserrat(fontSize: 20),
    ),
  ),
          Row(
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 50, maxHeight: 50),
                child: Image.asset(
                  image, // Ruta a tu imagen en assets
                  fit: BoxFit.fill,
                ),
                
              ),
               const SizedBox(width: 14),
              Text(subheading, style: GoogleFonts.montserrat(fontSize: 20)),
            ],
          )
        ],
      ),
    );
  }
}

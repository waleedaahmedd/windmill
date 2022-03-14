import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StoreLocatorBox extends StatelessWidget {
  final IconData icons;
  final String title;
  final String text;

  const StoreLocatorBox(
      {Key? key, required this.icons, required this.title, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 10,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 7,
            offset: Offset(0, 0),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icons,
            size: 40.0,
            color: const Color(0xFF0693e3),
          ),
          SizedBox(width: 20.0),
          Container(
            width: MediaQuery.of(context).size.width - 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.montserrat(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  text,
                  style: GoogleFonts.montserrat(
                    color: const Color(0xFF666666),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

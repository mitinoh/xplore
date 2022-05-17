import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xplore/core/UIColors.dart';

class ImageTile extends StatelessWidget {
  const ImageTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            'https://images.unsplash.com/photo-1528744598421-b7b93e12df15?ixlib=rb-1.2.1&ixid=&auto=format&fit=crop&w=928&q=80',
            fit: BoxFit.cover,
            width: mediaQuery.size.width * 1,
            height: mediaQuery.size.height * 1,
          ),
        ),
        Positioned(
          bottom: 5,
          left: 5,
          right: 5,
          child: Container(
            padding:
                const EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
            decoration: BoxDecoration(
                color: UIColors.white.withOpacity(0.6),
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    "nome luogo".toLowerCase(),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

class ImageImported extends StatelessWidget {
  ImageImported({Key? key, required this.path}) : super(key: key);
  final String path;
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
              color: Colors.lightBlue,
              borderRadius: BorderRadius.circular(20)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: // path != "" ?
                Image.file(
              File(path),
            ),
            /*  : CachedNetworkImage(
                      height: mediaQuery.size.height * 0.25,
                      width: mediaQuery.size.height * 1,
                      imageUrl:
                          'https://images.unsplash.com/photo-1528744598421-b7b93e12df15?ixlib=rb-1.2.1&ixid=&auto=format&fit=crop&w=928&q=80',
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                      placeholder: (context, url) => const LoadingIndicator(),
                      errorWidget: (context, url, error) => Center(
                        child: Icon(Iconsax.gallery_slash,
                            size: 30, color: UIColors.lightRed),
                      ),
                    )*/
          ),
        ),
        Positioned(
          top: 20,
          right: 20,
          child: Container(
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.6),
                borderRadius: BorderRadius.circular(20)),
            child: const Icon(
              Icons.close,
              size: 25,
            ),
          ),
        )
      ],
    );
  }
}

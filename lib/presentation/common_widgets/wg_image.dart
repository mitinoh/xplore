import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/presentation/common_widgets/widget_loading_indicator.dart';

class ImageWidget extends StatelessWidget {
  ImageWidget({Key? key, required this.imageUrl, this.height = -1, this.width = -1})
      : super(key: key);

  final String imageUrl;
  double height;
  double width;
  late MediaQueryData _mediaQuery;

  initVariables() {
    if (height < 0) height = _mediaQuery.size.height * 1;
    if (width < 0) width = _mediaQuery.size.width * 1;
  }

  @override
  Widget build(BuildContext context) {
    _mediaQuery = MediaQuery.of(context);
    initVariables();
    return CachedNetworkImage(
      height: height,
      width: width,
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
      placeholder: (context, url) => const LoadingIndicator(),
      errorWidget: (context, url, error) => Center(
        child: Icon(Iconsax.gallery_slash, size: 30, color: Colors.lightBlue),
      ),
    );
  }
}

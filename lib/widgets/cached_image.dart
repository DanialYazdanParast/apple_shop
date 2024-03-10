import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
 final String? imageUrl;
 final double radiys;
 const CachedImage({super.key, this.imageUrl, this.radiys = 0});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radiys),
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        errorWidget: (context, url, error) => Container(color: Colors.red[100]),
        placeholder: (context, url) => Container(color: Colors.grey),
        imageUrl: imageUrl ??
            'http://startflutter.ir/api/files/f5pm8kntkfuwbn1/78q8w901e6iipuk/rectangle_63_7kADbEzuEo.png',
      ),
    );
  }
}

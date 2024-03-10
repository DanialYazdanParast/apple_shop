import 'package:apple_shop/widgets/cached_image.dart';
import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../constants/colors.dart';
import '../data/model/banner.dart';

class BannerSlider extends StatelessWidget {
 final List<BannerCampin> baneerList;
 const BannerSlider(this.baneerList, {super.key});

  @override
  Widget build(BuildContext context) {
    var controller = PageController(viewportFraction: 0.9);
    return Stack(alignment: AlignmentDirectional.bottomCenter, children: [
      SizedBox(
        height: 177,
        child: PageView.builder(
          controller: controller,
          itemCount: baneerList.length,
          itemBuilder: (context, index) {
            return Container(
                margin: const EdgeInsets.symmetric(horizontal: 6),
                child: CachedImage(
                  imageUrl: baneerList[index].thumbnail,
                  radiys: 15,
                ));
          },
        ),
      ),
      Positioned(
        bottom: 10,
        child: SmoothPageIndicator(
          controller: controller,
          count: 3,
          effect: const ExpandingDotsEffect(
              expansionFactor: 4,
              dotHeight: 6,
              dotWidth: 6,
              dotColor: Colors.white,
              activeDotColor: CustumColor.blueIndicator),
        ),
      ),
    ]);
  }
}

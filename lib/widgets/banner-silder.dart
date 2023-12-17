import 'package:apple_store/data/model/banner.dart';
import 'package:apple_store/widgets/cached-image.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../constants/color.dart';

class BannerSlider extends StatelessWidget {
  BannerSlider({super.key, required this.bannerList});
  final List<BannerCamping> bannerList;
  @override
  Widget build(BuildContext context) {
    PageController controller =
        PageController(viewportFraction: 0.82, initialPage: 1);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        width: 340,
        height: 177,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: bannerList.length,
              controller: controller,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: CachedImage(
                    imageUrl: bannerList[index].thumbnail,
                    borderRadius: 15,
                    boxFit: BoxFit.fill,
                  ),
                );
              },
            ),
            Positioned(
              bottom: 15,
              child: SmoothPageIndicator(
                controller: controller,
                count: bannerList.length,
                effect: ExpandingDotsEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  expansionFactor: 4,
                  dotColor: CustomColors.white,
                  activeDotColor: CustomColors.blueIndicator,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

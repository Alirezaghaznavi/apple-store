import 'package:apple_store/bloc/basket/basket-bloc.dart';
import 'package:apple_store/constants/color.dart';
import 'package:apple_store/data/model/product.dart';
import 'package:apple_store/di/di.dart';
import 'package:apple_store/screens/product-detail-screen.dart';
import 'package:apple_store/util/extentions/double-extentions.dart';
import 'package:apple_store/widgets/cached-image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => BlocProvider<BasketBloc>.value(
                value: locatore.get<BasketBloc>(),
                child: ProductDetailScreen(product: product),
              ),
            ),
          );
        },
        child: Container(
          width: 165,
          height: 55,
          decoration: BoxDecoration(
            color: CustomColors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 8,
                child: Container(
                  width: double.infinity,
                  height: 124,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: CachedImage(
                          imageUrl: product.thumbnail,
                          boxFit: BoxFit.fitWidth,
                          borderRadius: 6,
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Image.asset(
                          'assets/images/active_fav_product.png',
                        ),
                      ),
                      Positioned(
                        bottom: 11,
                        left: 5,
                        child: Container(
                          width: 25,
                          height: 15,
                          decoration: BoxDecoration(
                            color: CustomColors.red,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: Text(
                              '${product.percent!.round()}%',
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              softWrap: true,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'SM',
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 10, bottom: 10, left: 10),
                    child: Text(
                      product.name,
                      maxLines: 1,
                      style: TextStyle(fontSize: 15, fontFamily: 'SM'),
                    ),
                  ),
                ],
              ),
              Container(
                height: 55,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: CustomColors.blue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: CustomColors.blue,
                        blurRadius: 15,
                        spreadRadius: -12,
                        offset: Offset(0, 14)),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 5, left: 5),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 20,
                        child: Image.asset(
                          'assets/images/icon_right_arrow_cricle.png',
                          width: 20,
                          height: 20,
                        ),
                      ),
                      Spacer(flex: 8),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            product.price.convertToPrice(),
                            style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontFamily: 'SM',
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            product.realPrice.convertToPrice(),
                            style: TextStyle(
                              fontFamily: 'SM',
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Spacer(flex: 2),
                      Text(
                        'تومان',
                        style: TextStyle(
                          fontFamily: 'SM',
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

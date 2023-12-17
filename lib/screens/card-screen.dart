import 'package:apple_store/bloc/basket/basket-bloc.dart';
import 'package:apple_store/constants/color.dart';
import 'package:apple_store/data/model/card-item.dart';
import 'package:apple_store/widgets/cached-image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardScreen extends StatelessWidget {
  const CardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.bachgroundScreenColor,
      body: SafeArea(
        child: BlocBuilder<BasketBloc, BasketState>(
          builder: (context, state) {
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: headerBox(),
                    ),
                    if (state is BasketDataFechedState) ...{
                      state.basketItemList.fold(
                        (l) {
                          return SliverToBoxAdapter(
                            child: Text(l),
                          );
                        },
                        (r) {
                          return SliverList(
                            delegate: SliverChildBuilderDelegate(
                              childCount: r.length,
                              (context, index) {
                                return OptionCheap(
                                  basketItem: r[index],
                                );
                              },
                            ),
                          );
                        },
                      ),
                    },
                    SliverPadding(padding: EdgeInsets.only(bottom: 60))
                  ],
                ),
                if (state is BasketDataFechedState) ...{
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 44, right: 44, top: 20, bottom: 10),
                    child: SizedBox(
                      height: 53,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          context
                              .read<BasketBloc>()
                              .add(BasketPaymentInitEvent());
                          context
                              .read<BasketBloc>()
                              .add(BasketPaymentRequestEvent());
                        },
                        child: Text(
                          (state.getBasketFinalPrice == 0)
                              ? 'سبد خرید شما خالی است'
                              : '${state.getBasketFinalPrice}',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'SB',
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CustomColors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                },
              ],
            );
          },
        ),
      ),
    );
  }

  Widget headerBox() {
    return Padding(
      padding: const EdgeInsets.only(left: 44, right: 44, top: 20, bottom: 32),
      child: Container(
        width: 340,
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: CustomColors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Image.asset(
                'assets/images/icon_apple_blue.png',
                height: 26,
              ),
            ),
            Expanded(
              child: Text(
                'سبد خرید',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'SB',
                  fontSize: 16,
                  color: CustomColors.blue,
                ),
              ),
            ),
            SizedBox(
              width: 37,
            ),
          ],
        ),
      ),
    );
  }
}

class OptionCheap extends StatelessWidget {
  const OptionCheap({super.key, required this.basketItem});

  final BasketItem basketItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 44, right: 44, bottom: 20),
      width: MediaQuery.of(context).size.width,
      height: 238.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 8,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 8, right: 11, top: 20, bottom: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        basketItem.name,
                        textAlign: TextAlign.start,
                        textDirection: TextDirection.rtl,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'SB',
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "گارانتی 18 ماه مدیا پردازش",
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: 'SM',
                          color: CustomColors.gery,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 22,
                            height: 15,
                            decoration: BoxDecoration(
                              color: CustomColors.red,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2),
                              child: Text(
                                '${basketItem.percent!.round()}%',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'SM',
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            'تومان',
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'SM',
                              color: CustomColors.gery,
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            '${basketItem.price}',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'SM',
                              color: CustomColors.gery,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        height: 35,
                        child: Wrap(
                          alignment: WrapAlignment.end,
                          runSpacing: 10,
                          spacing: 10,
                          children: [
                            Container(
                              width: 108,
                              height: 24,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                border: Border.all(
                                  width: 1,
                                  color: CustomColors.gery.withOpacity(0.3),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/images/icon_options.png'),
                                  SizedBox(width: 10),
                                  Text(
                                    'سبز کله غازی',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontFamily: 'SM',
                                      color: CustomColors.gery,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: CustomColors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 94,
                              height: 24,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                border: Border.all(
                                  width: 1,
                                  color: CustomColors.gery.withOpacity(0.3),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/images/icon_options.png'),
                                  SizedBox(width: 10),
                                  Text(
                                    'گیگابایت',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontFamily: 'SM',
                                      color: CustomColors.gery,
                                    ),
                                  ),
                                  Text(
                                    ' ۲۵۶',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontFamily: 'SM',
                                      color: CustomColors.gery,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 62,
                              height: 24,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                border: Border.all(
                                  width: 1,
                                  color: CustomColors.gery.withOpacity(0.3),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'حذف',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontFamily: 'SM',
                                      color: CustomColors.gery,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Image.asset('assets/images/icon_trash.png'),
                                ],
                              ),
                            ),
                            Container(
                              width: 69,
                              height: 24,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                border: Border.all(
                                  width: 1,
                                  color: CustomColors.gery.withOpacity(0.3),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'ذخیره',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontFamily: 'SM',
                                      color: CustomColors.gery,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Image.asset(
                                    'assets/images/icon_favorite_deactive.png',
                                    width: 15,
                                    height: 15,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 45,
                              height: 24,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                border: Border.all(
                                  width: 1,
                                  color: CustomColors.gery.withOpacity(0.3),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/images/icon_options.png'),
                                  SizedBox(width: 10),
                                  Text(
                                    '1',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontFamily: 'SM',
                                      color: CustomColors.gery,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(top: 32, right: 8, bottom: 42),
                  child: Column(
                    children: [
                      CachedImage(
                        imageUrl: basketItem.thumbnail,
                        borderRadius: 15,
                        boxFit: BoxFit.fitWidth,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: DottedLine(
              dashColor: CustomColors.gery.withOpacity(0.22),
              lineThickness: 3,
              dashLength: 8,
              dashGapLength: 3,
              dashGapColor: Colors.transparent,
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "تومان",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'SM',
                  ),
                ),
                Text(
                  " ${basketItem.realPrice}",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'SM',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

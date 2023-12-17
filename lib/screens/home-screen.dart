import 'package:apple_store/bloc/home/home-bloc.dart';
import 'package:apple_store/constants/color.dart';
import 'package:apple_store/data/model/category.dart';
import 'package:apple_store/data/model/product.dart';
import 'package:apple_store/widgets/banner-silder.dart';
import 'package:apple_store/widgets/category-item-chip.dart';
import 'package:apple_store/widgets/loading-animation.dart';
import 'package:apple_store/widgets/product-item.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScareen extends StatefulWidget {
  const HomeScareen({super.key});

  @override
  State<HomeScareen> createState() => _HomeScareenState();
}

class _HomeScareenState extends State<HomeScareen> {
  CarouselController controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.bachgroundScreenColor,
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<HomeBloc>().add(HomeInitializeRequestEvent());
              },
              child: CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: TopSearchBox(),
                  ),
                  if (state is HomeLoadingState) ...{
                    SliverToBoxAdapter(
                      child: Center(
                        child: LoeadingAnimation(),
                      ),
                    ),
                  } else ...{
                    if (state is HomeResponseState) ...{
                      state.bannerList.fold(
                        (l) {
                          return SliverToBoxAdapter(
                            child: Center(
                              child: Text(l),
                            ),
                          );
                        },
                        (r) {
                          return SliverToBoxAdapter(
                            child: BannerSlider(bannerList: r),
                          );
                        },
                      ),
                    },
                    SliverToBoxAdapter(
                      child: getCategoryListTitle(),
                    ),
                    if (state is HomeResponseState) ...{
                      state.categoryList.fold(
                        (l) {
                          return SliverToBoxAdapter(
                            child: Center(
                              child: Text(l),
                            ),
                          );
                        },
                        (r) {
                          return SliverToBoxAdapter(
                            child: getCategotyList(r),
                          );
                        },
                      )
                    },
                    SliverToBoxAdapter(
                      child: getBestSellerTitle(),
                    ),
                    if (state is HomeResponseState) ...{
                      state.productBestSellerList.fold(
                        (l) {
                          return SliverToBoxAdapter(
                            child: Center(
                              child: Text(l),
                            ),
                          );
                        },
                        (r) {
                          return SliverToBoxAdapter(
                            child: getBestSellerProduct(r),
                          );
                        },
                      ),
                    },
                    SliverToBoxAdapter(
                      child: getMostViewedTitle(),
                    ),
                    if (state is HomeResponseState) ...{
                      state.productHotestList.fold(
                        (l) {
                          return SliverToBoxAdapter(
                            child: Center(
                              child: Text(l),
                            ),
                          );
                        },
                        (r) {
                          return SliverToBoxAdapter(
                            child: getMostViewedProduct(r),
                          );
                        },
                      ),
                    },
                    SliverPadding(
                      padding: EdgeInsets.only(bottom: 20),
                    ),
                  },
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget getMostViewedProduct(List<Product> productList) {
    return Padding(
      padding: const EdgeInsets.only(right: 44, top: 20),
      child: SizedBox(
        height: 216,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: productList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 19),
                child: ProductItem(product: productList[index]),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget getMostViewedTitle() {
    return Padding(
      padding: const EdgeInsets.only(left: 44, right: 44, top: 32),
      child: Row(
        children: [
          Image.asset('assets/images/icon_left_categroy.png'),
          SizedBox(width: 10),
          Text(
            'مشاهد همه',
            style: TextStyle(
                fontFamily: 'SB', fontSize: 12, color: CustomColors.blue),
          ),
          Spacer(),
          Text(
            'پربازدید ترین ها',
            style: TextStyle(
                fontFamily: 'SB', fontSize: 12, color: CustomColors.gery),
          ),
        ],
      ),
    );
  }

  Widget getBestSellerTitle() {
    return Padding(
      padding: const EdgeInsets.only(left: 44, right: 44, top: 32),
      child: Row(
        children: [
          Image.asset('assets/images/icon_left_categroy.png'),
          SizedBox(width: 10),
          Text(
            'مشاهد همه',
            style: TextStyle(
                fontFamily: 'SB', fontSize: 12, color: CustomColors.blue),
          ),
          Spacer(),
          Text(
            'پرفروش ترین ها',
            style: TextStyle(
                fontFamily: 'SB', fontSize: 12, color: CustomColors.gery),
          ),
        ],
      ),
    );
  }

  Widget getBestSellerProduct(List<Product> productList) {
    return Padding(
      padding: const EdgeInsets.only(right: 44, top: 20),
      child: SizedBox(
        height: 216,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: productList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ProductItem(product: productList[index]),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget getCategoryListTitle() {
    return Padding(
      padding: EdgeInsets.only(right: 44, top: 32, left: 44),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'دسته بندی',
            style: TextStyle(
              fontFamily: 'SM',
              fontSize: 13,
              color: CustomColors.gery,
            ),
          ),
        ],
      ),
    );
  }

  Widget getCategotyList(List<Category> categoryList) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, right: 44),
        child: Container(
          width: 80,
          height: 100,
          child: ListView.builder(
            itemCount: categoryList.length,
            physics: BouncingScrollPhysics(),
            controller: PageController(initialPage: 0),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 20),
                child: CategoriesItemChip(category: categoryList[index]),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget getBanerSlider() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
          right: 44,
          left: 44,
          top: 32,
        ),
        child: CarouselSlider.builder(
          itemCount: 4,
          itemBuilder: (context, index, realIndex) {
            return Container(
              width: 340,
              height: 177,
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(15)),
            );
          },
          carouselController: controller,
          options: CarouselOptions(),
        ),
      ),
    );
  }
}

class TopSearchBox extends StatelessWidget {
  const TopSearchBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.only(right: 10, left: 15),
              child: Image.asset(
                'assets/images/icon_apple_blue.png',
                height: 26,
              ),
            ),
            Expanded(
              child: Text(
                'جستوجوی محصولات',
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontFamily: 'SB',
                  fontSize: 16,
                  color: CustomColors.gery,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15, left: 10),
              child: Image.asset('assets/images/icon_search.png'),
            )
          ],
        ),
      ),
    );
  }
}

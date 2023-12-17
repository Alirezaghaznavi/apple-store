import 'dart:ui';

import 'package:apple_store/bloc/basket/basket-bloc.dart';
import 'package:apple_store/bloc/product/product-bloc.dart';
import 'package:apple_store/constants/color.dart';
import 'package:apple_store/data/model/product-image.dart';
import 'package:apple_store/data/model/product-property.dart';
import 'package:apple_store/data/model/product-variant.dart';
import 'package:apple_store/data/model/product.dart';
import 'package:apple_store/data/model/variant-type.dart';
import 'package:apple_store/data/model/varint.dart';
import 'package:apple_store/widgets/cached-image.dart';
import 'package:apple_store/widgets/loading-animation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/comment/comment-bloc.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.product});

  final Product product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        var bloc = ProductBloc();
        bloc.add(ProductDetailRequsetEvent(
            widget.product.id, widget.product.categoryId));
        return bloc;
      },
      child: DetailContentWidget(parentWidget: widget),
    );
  }
}

class DetailContentWidget extends StatelessWidget {
  const DetailContentWidget({super.key, required this.parentWidget});

  final ProductDetailScreen parentWidget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.bachgroundScreenColor,
      body: SafeArea(
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: TopBox(state: state),
                ),
                if (state is ProductLoadingState) ...[
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Center(
                        child: LoeadingAnimation(),
                      ),
                    ),
                  ),
                ] else ...[
                  SliverToBoxAdapter(
                    child: ProductName(productName: parentWidget.product.name),
                  ),
                  if (state is ProductDetailResponseState) ...{
                    state.productImages.fold(
                      (l) {
                        return SliverToBoxAdapter(
                          child: Center(
                            child: Text(l),
                          ),
                        );
                      },
                      (r) {
                        return SliverToBoxAdapter(
                          child: GalleryWidget(
                            productImageList: r,
                            defualtProductTumbnail:
                                parentWidget.product.thumbnail,
                          ),
                        );
                      },
                    ),
                  },
                  if (state is ProductDetailResponseState) ...{
                    state.productVariants.fold(
                      (l) {
                        return SliverToBoxAdapter(
                          child: Center(
                            child: Text(l),
                          ),
                        );
                      },
                      (r) {
                        return SliverToBoxAdapter(
                          child:
                              VariantContainerGenerator(productVariantList: r),
                        );
                      },
                    ),
                  },
                  SliverToBoxAdapter(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 20, right: 44, left: 44),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          if (state is ProductDetailResponseState) ...{
                            state.productProperties.fold(
                              (l) {
                                return Text(l);
                              },
                              (r) {
                                return ProductPeroperties(productProperties: r);
                              },
                            ),
                          },
                          SizedBox(height: 20),
                          ProductDiscreption(
                              description: parentWidget.product.description),
                          SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                isDismissible: true,
                                isScrollControlled: true,
                                showDragHandle: true,
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (context) {
                                  return BlocProvider(
                                    create: (context) => CommentBloc()
                                      ..add(CommentInitialRequestEvent(
                                          parentWidget.product.id)),
                                    child: DraggableScrollableSheet(
                                      initialChildSize: 0.7,
                                      maxChildSize: 0.95,
                                      minChildSize: 0.55,
                                      builder: (context, scrollController) =>
                                          CommentBottomSheet(
                                        scrollController: scrollController,
                                        productId: parentWidget.product.id,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              width: double.infinity,
                              height: 46,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                                border: Border.all(
                                  width: 1,
                                  color: CustomColors.gery,
                                ),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(width: 10),
                                  Image.asset(
                                    'assets/images/icon_left_categroy.png',
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'مشاهده',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'SB',
                                      color: CustomColors.blue,
                                    ),
                                  ),
                                  Spacer(),
                                  Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Container(
                                        height: 26,
                                        width: 26,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: CustomColors.red,
                                        ),
                                      ),
                                      Positioned(
                                        right: 15,
                                        child: Container(
                                          height: 26,
                                          width: 26,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: CustomColors.blue,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 30,
                                        child: Container(
                                          height: 26,
                                          width: 26,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: CustomColors.green,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 45,
                                        child: Container(
                                          height: 26,
                                          width: 26,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: CustomColors.gery,
                                          ),
                                          child: Center(
                                            child: Text(
                                              "+۱۰",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontFamily: 'SM',
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    ':نظرات کاربران',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'SM',
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 44, right: 44, top: 38, bottom: 32),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(child: priceTagButton(parentWidget.product)),
                          SizedBox(width: 10),
                          Expanded(
                              child: addToBasketButton(
                                  parentWidget.product, context)),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }

  Widget addToBasketButton(Product product, BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<ProductBloc>().add(ProductAddToBasket(product));
        context.read<BasketBloc>().add(BasketFechedFromHiveEvent());
      },
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            top: -4.5,
            child: Container(
              width: 140,
              height: 47,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: CustomColors.blue,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: SizedBox(
                height: 55,
                child: Center(
                  child: Text(
                    "افزودن به سبد خرید",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'SB',
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget priceTagButton(Product product) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Positioned(
          top: -4.5,
          child: Container(
            width: 140,
            height: 47,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: CustomColors.green,
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: SizedBox(
              height: 55,
              child: Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'تومان',
                      style: TextStyle(
                        fontFamily: 'SM',
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 5),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${product.price}',
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontFamily: 'SM',
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '${product.realPrice}',
                          style: TextStyle(
                            fontFamily: 'SM',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Container(
                      width: 27,
                      height: 15,
                      decoration: BoxDecoration(
                        color: CustomColors.red,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Text(
                          '${product.percent!.round()}%',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'SM',
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CommentBottomSheet extends StatefulWidget {
  const CommentBottomSheet({
    super.key,
    required this.scrollController,
    required this.productId,
  });

  final ScrollController scrollController;
  final String productId;

  @override
  State<CommentBottomSheet> createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController textEditingController = TextEditingController();

    return Container(
      decoration: BoxDecoration(
        color: CustomColors.bachgroundScreenColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Scaffold(
        body: BlocBuilder<CommentBloc, CommentState>(
          builder: (context, state) {
            if (state is CommentLoadingState) {
              return Center(
                child: LoeadingAnimation(),
              );
            }
            return Column(
              children: [
                Expanded(
                  child: CustomScrollView(
                    controller: widget.scrollController,
                    slivers: [
                      if (state is CommentResponseState) ...{
                        state.comments.fold(
                          (l) {
                            return SliverToBoxAdapter(
                              child: Center(
                                child: Text(l),
                              ),
                            );
                          },
                          (r) {
                            return SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  return Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 25, vertical: 10),
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                (r[index].name.isNotEmpty)
                                                    ? r[index].name
                                                    : 'کاربر',
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  fontSize: 13.8,
                                                  fontFamily: 'SB',
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                r[index].text,
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  fontSize: 12.5,
                                                  fontFamily: 'SM',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: SizedBox(
                                            width: 35,
                                            height: 35,
                                            child: (r[index].avatar.isEmpty)
                                                ? Image.asset(
                                                    'assets/images/profile-circle.png')
                                                : CachedImage(
                                                    imageUrl:
                                                        r[index].userAvatarUrl,
                                                    borderRadius: 8,
                                                  ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                childCount: r.length,
                              ),
                            );
                          },
                        ),
                      },
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: SizedBox(
                    height: 50,
                    child: TextField(
                      textDirection: TextDirection.rtl,
                      controller: textEditingController,
                      decoration: InputDecoration(
                        hintTextDirection: TextDirection.rtl,
                        alignLabelWithHint: true,
                        labelStyle: TextStyle(
                          fontSize: 15,
                          fontFamily: 'SM',
                          color: Colors.black.withOpacity(0.5),
                        ),
                        hintText: 'نظر خود را اینجا بنویسید',
                        hintStyle: TextStyle(
                          fontSize: 16,
                          fontFamily: 'SM',
                          color: Colors.black.withOpacity(0.5),
                          height: 1,
                        ),
                        floatingLabelStyle: TextStyle(
                          fontSize: 16,
                          fontFamily: 'SM',
                          color: Colors.black,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1.5,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: CustomColors.gery,
                            width: 1.8,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 200,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<CommentBloc>().add(CommentPostEvent(
                          textEditingController.text, widget.productId));
                    },
                    child: (state is CommentPostLoadingState)
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : Text(
                            'افزودن نظر',
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'SM',
                              color: Colors.white,
                            ),
                          ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8)
              ],
            );
          },
        ),
      ),
    );
  }
}

class ProductName extends StatelessWidget {
  const ProductName({super.key, required this.productName});

  final String productName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32, bottom: 20, left: 44, right: 44),
      child: Text(
        productName,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'SB',
          fontSize: 16,
          color: CustomColors.black,
        ),
      ),
    );
  }
}

class TopBox extends StatelessWidget {
  TopBox({super.key, required this.state});

  final state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 44, right: 44, top: 20),
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
            if (state is ProductLoadingState) ...{
              Spacer(),
            },
            if (state is ProductDetailResponseState) ...{
              state.productCategory.fold(
                (l) {
                  return Expanded(
                    child: Text(
                      'مشخصات کالا',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'SB',
                        fontSize: 16,
                        color: CustomColors.blue,
                      ),
                    ),
                  );
                },
                (r) {
                  return Expanded(
                    child: Text(
                      r.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'SB',
                        fontSize: 16,
                        color: CustomColors.blue,
                      ),
                    ),
                  );
                },
              ),
            },
            Padding(
              padding: const EdgeInsets.only(right: 15, left: 10),
              child: Image.asset('assets/images/icon_back.png'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductPeroperties extends StatefulWidget {
  const ProductPeroperties({super.key, required this.productProperties});

  final List<ProductProperty> productProperties;

  @override
  State<ProductPeroperties> createState() => _ProductPeropertiesState();
}

class _ProductPeropertiesState extends State<ProductPeroperties> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              if (widget.productProperties.first.value!.isNotEmpty) {
                isVisible = !isVisible;
              }
            });
          },
          child: Container(
            width: double.infinity,
            height: 46,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              border: Border.all(
                width: 1,
                color: CustomColors.gery,
              ),
            ),
            child: Row(
              children: [
                SizedBox(width: 10),
                Image.asset(
                  'assets/images/icon_left_categroy.png',
                ),
                SizedBox(width: 10),
                Text(
                  'مشاهده',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'SB',
                    color: CustomColors.blue,
                  ),
                ),
                Spacer(),
                Text(
                  ':مشخصات فنی',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'SM',
                  ),
                ),
                SizedBox(width: 10),
              ],
            ),
          ),
        ),
        SizedBox(height: 8),
        Visibility(
          visible: isVisible,
          child: Container(
            padding: EdgeInsets.all(5),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              border: Border.all(
                width: 1,
                color: CustomColors.gery,
              ),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.productProperties.length,
              itemBuilder: (context, index) {
                var property = widget.productProperties[index];
                return Flexible(
                  child: Text(
                    '${property.title} : ${property.value}',
                    maxLines: 1,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.start,
                    style:
                        TextStyle(fontSize: 12, fontFamily: 'SM', height: 1.5),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class ProductDiscreption extends StatefulWidget {
  const ProductDiscreption({super.key, required this.description});

  final String description;

  @override
  State<ProductDiscreption> createState() => _ProductDiscreptionState();
}

class _ProductDiscreptionState extends State<ProductDiscreption> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              if (widget.description.isNotEmpty) {
                isVisible = !isVisible;
              }
            });
          },
          child: Container(
            width: double.infinity,
            height: 46,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              border: Border.all(
                width: 1,
                color: CustomColors.gery,
              ),
            ),
            child: Row(
              children: [
                SizedBox(width: 10),
                Image.asset(
                  'assets/images/icon_left_categroy.png',
                ),
                SizedBox(width: 10),
                Text(
                  "مشاهده",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'SB',
                    color: CustomColors.blue,
                  ),
                ),
                Spacer(),
                Text(
                  ':توضیحات محصول',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'SM',
                  ),
                ),
                SizedBox(width: 10),
              ],
            ),
          ),
        ),
        SizedBox(height: 8),
        Visibility(
          visible: isVisible,
          child: Container(
            padding: EdgeInsets.all(5),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              border: Border.all(
                width: 1,
                color: CustomColors.gery,
              ),
            ),
            child: Text(
              widget.description,
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'SM',
                height: 1.5,
              ),
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
            ),
          ),
        ),
      ],
    );
  }
}

class GalleryWidget extends StatefulWidget {
  GalleryWidget(
      {super.key,
      required this.productImageList,
      required this.defualtProductTumbnail});

  final List<ProductImage> productImageList;
  final String defualtProductTumbnail;

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  int selectedImage = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 44, right: 44),
      child: Container(
        width: 340,
        height: 284,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.white),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 10, top: 5, right: 10),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/icon_star.png',
                              width: 20,
                              height: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '4.6',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'SM',
                                fontSize: 12,
                                color: CustomColors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 10, top: 5, right: 50),
                        child: Image.asset(
                          'assets/images/icon_favorite_deactive.png',
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: CachedImage(
                            imageUrl: (widget.productImageList.isEmpty)
                                ? widget.defualtProductTumbnail
                                : widget
                                    .productImageList[selectedImage].imageUrl,
                            borderRadius: 15,
                            boxFit: BoxFit.scaleDown,
                            height: 230,
                            width: 200,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                ],
              ),
            ),
            if (widget.productImageList.isNotEmpty) ...{
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20, top: 5),
                child: SizedBox(
                  height: 70,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: ListView.builder(
                      dragStartBehavior: DragStartBehavior.down,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.productImageList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedImage = index;
                            });
                          },
                          child: Container(
                            width: 70,
                            height: 70,
                            margin: EdgeInsets.only(left: 5, right: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: CustomColors.gery, width: 0.8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: CachedImage(
                                  imageUrl: (widget.productImageList.isEmpty)
                                      ? widget.defualtProductTumbnail
                                      : widget.productImageList[index].imageUrl,
                                  borderRadius: 5,
                                  boxFit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            },
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

class VariantContainerGenerator extends StatelessWidget {
  const VariantContainerGenerator(
      {super.key, required this.productVariantList});

  final List<ProductVariant> productVariantList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var productVariant in productVariantList) ...{
          if (productVariant.variantList.isNotEmpty) ...{
            VariantGeneratorChild(productVariant: productVariant)
          },
        },
      ],
    );
  }
}

class VariantGeneratorChild extends StatelessWidget {
  const VariantGeneratorChild({super.key, required this.productVariant});

  final ProductVariant productVariant;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 44, right: 44),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            productVariant.variantType.title,
            style: TextStyle(fontSize: 12, fontFamily: 'SB'),
          ),
          SizedBox(height: 10),
          if (productVariant.variantType.typeEnum == VariantTypeEnum.COLOR) ...{
            ColorVariantList(colorVarinats: productVariant.variantList),
          },
          if (productVariant.variantType.typeEnum ==
              VariantTypeEnum.STORAGE) ...{
            StorageVariantList(storageVariants: productVariant.variantList),
          }
          // if(productVariant.variantType.type == VariantTypeEnum.VOLTAGE)...{}
        ],
      ),
    );
  }
}

class ColorVariantList extends StatefulWidget {
  const ColorVariantList({super.key, required this.colorVarinats});

  final List<Variant> colorVarinats;

  @override
  State<ColorVariantList> createState() => _ColorVariantListState();
}

class _ColorVariantListState extends State<ColorVariantList> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 24,
        child: ListView.builder(
          itemCount: widget.colorVarinats.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            String categoryColor = 'ff${widget.colorVarinats[index].value}';
            int hexCode = int.parse(categoryColor, radix: 16);
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
              },
              child: Container(
                height: 26,
                width: 26,
                margin: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  border: (_selectedIndex == index)
                      ? Border.all(
                          color: CustomColors.blueIndicator,
                          width: 2,
                          strokeAlign: 1,
                          style: BorderStyle.solid)
                      : null,
                  borderRadius: BorderRadius.circular(8),
                  color: Color(hexCode),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class StorageVariantList extends StatefulWidget {
  const StorageVariantList({super.key, required this.storageVariants});

  final List<Variant> storageVariants;

  @override
  State<StorageVariantList> createState() => _StorageVariantListState();
}

class _StorageVariantListState extends State<StorageVariantList> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 26,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.storageVariants.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
              },
              child: Container(
                width: 74,
                height: 26,
                margin: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: CustomColors.white,
                  border: (_selectedIndex == index)
                      ? Border.all(
                          color: CustomColors.blueIndicator, width: 1.5)
                      : Border.all(color: CustomColors.gery, width: 0.7),
                ),
                child: Center(
                  child: Text(
                    widget.storageVariants[index].value,
                    style: TextStyle(
                      fontFamily: 'SM',
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

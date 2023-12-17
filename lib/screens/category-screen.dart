// ignore_for_file: unused_local_variable

import 'package:apple_store/bloc/category-product/category-product-bloc.dart';
import 'package:apple_store/bloc/category/category-bolc.dart';
import 'package:apple_store/bloc/category/category-event.dart';
import 'package:apple_store/bloc/category/category-state.dart';
import 'package:apple_store/screens/product-list-screen.dart';
import 'package:apple_store/widgets/cached-image.dart';
import 'package:apple_store/widgets/loading-animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants/color.dart';
import '../data/model/category.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    BlocProvider.of<CategoryBloc>(context).add(CategoryRequsetEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.bachgroundScreenColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: headerBox(),
            ),
            BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                if (state is CategoryLoadingState) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: LoeadingAnimation(),
                    ),
                  );
                }
                if (state is CategoryResponseState) {
                  return state.categories.fold(
                    (l) {
                      return SliverToBoxAdapter(
                        child: Center(
                          child: Text(l),
                        ),
                      );
                    },
                    (r) {
                      return getCategroyList(r);
                    },
                  );
                }
                return SliverToBoxAdapter(child: Text('error'));
              },
            ),
            SliverPadding(
              padding: EdgeInsets.only(bottom: 21),
            ),
          ],
        ),
      ),
    );
  }

  SliverPadding getCategroyList(List<Category> categoryList) {
    return SliverPadding(
      padding: EdgeInsets.only(left: 44, right: 44),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => CategoryProductBloc(),
                      child: ProductListScreen(
                        category: categoryList[index],
                      ),
                    ),
                  ),
                );
              },
              child: Expanded(
                child: CachedImage(
                  imageUrl: categoryList[index].thumbnail,
                  borderRadius: 15,
                  boxFit: BoxFit.cover,
                ),
              ),
            );
          },
          childCount: categoryList.length,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
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
                'دسته بندی',
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

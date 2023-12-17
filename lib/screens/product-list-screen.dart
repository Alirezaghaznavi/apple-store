import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/category-product/category-product-bloc.dart';
import '../constants/color.dart';
import '../data/model/category.dart';
import '../widgets/product-item.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key, required this.category});
  final Category category;

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    BlocProvider.of<CategoryProductBloc>(context)
        .add(CategoryProductRequestEvent(widget.category.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.bachgroundScreenColor,
      body: SafeArea(
        child: BlocBuilder<CategoryProductBloc, CategoryProductState>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: headerBox(state, widget.category.title),
                ),
                if (state is CategoryProductLoadingState) ...{
                  SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                },
                if (state is CategotyProductResponeState) ...{
                  state.productsByCategoryId.fold(
                    (l) {
                      return SliverToBoxAdapter(
                        child: Text(l),
                      );
                    },
                    (r) {
                    
                      return SliverPadding(
                        padding: EdgeInsets.only(left: 44, right: 44),
                        sliver: SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return ProductItem(product: r[index]);
                            },
                            childCount: r.length,
                          ),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20,
                            childAspectRatio: 2 / 2.8,
                          ),
                        ),
                      );
                    },
                  ),
                },
                SliverPadding(padding: EdgeInsets.only(bottom: 20)),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget headerBox(state, String title) {
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
                title,
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

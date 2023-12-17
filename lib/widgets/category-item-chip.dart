import 'package:apple_store/bloc/category-product/category-product-bloc.dart';
import 'package:apple_store/data/model/category.dart';
import 'package:apple_store/screens/product-list-screen.dart';
import 'package:apple_store/widgets/cached-image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesItemChip extends StatelessWidget {
  CategoriesItemChip({super.key, required this.category});
  final Category category;

  @override
  Widget build(BuildContext context) {
    String categoryColor = 'ff${category.color}';
    int hexCode = int.parse(categoryColor, radix: 16);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => CategoryProductBloc(),
              child: ProductListScreen(category: category,),
            ),
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: ShapeDecoration(
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(44)),
                  color: Color(hexCode),
                  shadows: [
                    BoxShadow(
                      blurRadius: 10,
                      color: Color(hexCode),
                      offset: Offset(-3, 3),
                      spreadRadius: 0.05,
                      blurStyle: BlurStyle.normal,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 24,
                height: 24,
                child: CachedImage(
                    imageUrl: category.icon, boxFit: BoxFit.contain),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            category.title,
            style: TextStyle(fontSize: 12, fontFamily: 'SB'),
          ),
        ],
      ),
    );
  }
}

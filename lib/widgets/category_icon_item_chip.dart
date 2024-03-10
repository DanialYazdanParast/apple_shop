import 'package:apple_shop/screens/product_list_Screen.dart';
import 'package:apple_shop/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/category_product/category_product_bloc.dart';
import '../data/model/category.dart';

class CategorylItemChip extends StatelessWidget {
  final Category category;
  const CategorylItemChip(
    this.category, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String categoryColor = 'ff${category.color}';
    int hexColor = int.parse(categoryColor, radix: 16);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => CategoryProductBloc(),
              child: ProductListScreen(category),
            ),
          ),
        );
      },
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                height: 56,
                width: 56,
                decoration: ShapeDecoration(
                  color: Color(hexColor),
                  shadows: [
                    BoxShadow(
                        color: Color(hexColor),
                        blurRadius: 25,
                        spreadRadius: -12,
                        offset: const Offset(0, 15))
                  ],
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
              SizedBox(
                height: 24,
                width: 24,
                child: Center(
                  child: CachedImage(
                    imageUrl: category.icon,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            category.title ?? 'محصول',
            style: const TextStyle(fontFamily: 'SB', fontSize: 12),
          ),
        ],
      ),
    );
  }
}

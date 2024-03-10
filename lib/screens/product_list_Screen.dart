import 'package:apple_shop/data/model/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/category_product/category_product_bloc.dart';
import '../constants/colors.dart';
import '../data/model/category.dart';
import '../widgets/product_item.dart';

class ProductListScreen extends StatefulWidget {
  final Category category;
  const ProductListScreen(
    this.category, {
    super.key,
  });

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    BlocProvider.of<CategoryProductBloc>(context)
        .add(CategoryProductGetInitilze(widget.category.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryProductBloc, CategoryProductState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: CustumColor.backgroundScreenColor,
          body: SafeArea(
              child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 44,
                    right: 44,
                    bottom: 32,
                  ),
                  child: Container(
                    height: 46,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 16,
                        ),
                        Image.asset('assets/images/icon_apple_blue.png'),
                        Expanded(
                          child: Text(
                            widget.category.title!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontFamily: 'SB',
                                fontSize: 16,
                                color: CustumColor.blue),
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Image.asset('assets/images/icon_back.png')),
                        const SizedBox(
                          width: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (state is CategoryProductLodingState) ...{
                const SliverToBoxAdapter(
                  child: Center(
                    child: SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator()),
                  ),
                ),
              },
              if (state is CategoryProductSuccessState) ...{
                state.productByCategoryID.fold((l) {
                  return SliverToBoxAdapter(
                    child: Text(l),
                  );
                }, (product) {
                  return CategoryItem(product);
                })
              }
            ],
          )),
        );
      },
    );
  }
}

class CategoryItem extends StatelessWidget {
  final List<Product> product;
  const CategoryItem(
    this.product, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 44),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate((context, index) {
          return ProductItem(product[index]);
        }, childCount: product.length),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 2.8,
            mainAxisSpacing: 22,
            crossAxisSpacing: 22),
      ),
    );
  }
}

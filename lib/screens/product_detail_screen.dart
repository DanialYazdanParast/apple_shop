import 'dart:ui';

import 'package:apple_shop/bloc/basket/basket_bloc.dart';
import 'package:apple_shop/bloc/comment/comment_bloc.dart';
import 'package:apple_shop/bloc/product/product_bloc.dart';
import 'package:apple_shop/bloc/product/product_event.dart';
import 'package:apple_shop/bloc/product/product_state.dart';
import 'package:apple_shop/data/model/product.dart';
import 'package:apple_shop/data/model/product_image.dart';
import 'package:apple_shop/data/model/product_peroperty.dart';
import 'package:apple_shop/data/model/product_variant.dart';
import 'package:apple_shop/data/model/variant.dart';
import 'package:apple_shop/data/model/variant_type.dart';
import 'package:apple_shop/di/di.dart';

import 'package:apple_shop/widgets/cached_image.dart';
import 'package:apple_shop/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/colors.dart';

class ProductDetaileScreen extends StatefulWidget {
  final Product product;
  const ProductDetaileScreen(
    this.product, {
    super.key,
  });

  @override
  State<ProductDetaileScreen> createState() => _ProductDetaileScreenState();
}

class _ProductDetaileScreenState extends State<ProductDetaileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        var bloc = ProductBloc();
        bloc.add(
          ProductInitializeEvent(widget.product.id, widget.product.categoryId),
        );
        return bloc;
      },
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: CustumColor.backgroundScreenColor,
            body: SafeArea(
              child: _getProductDetaileScreen(state, context, widget.product),
            ),
          );
        },
      ),
    );
  }
}

Widget _getProductDetaileScreen(
    ProductState state, BuildContext context, product) {
  if (state is ProductDetailLodingState) {
    return const Center(child: LoadingAnimation());
  } else if (state is ProductDetailResponseState) {
    return CustomScrollView(
      slivers: [
        SliverPadding(padding: EdgeInsets.only(top: 24)),
        if (state is ProductDetailResponseState) ...{
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
                    state.productCategory.fold((l) {
                      return const Expanded(
                        child: Text(
                          'محصول',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'SB',
                              fontSize: 16,
                              color: CustumColor.blue),
                        ),
                      );
                    }, (productCategory) {
                      return Expanded(
                        child: Text(
                          productCategory.title ?? 'دسته بندی',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontFamily: 'SB',
                              fontSize: 16,
                              color: CustumColor.blue),
                        ),
                      );
                    }),
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
        },
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              product.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontFamily: 'SB', fontSize: 16, color: Colors.black),
            ),
          ),
        ),
        if (state is ProductDetailResponseState) ...{
          state.productImage.fold((l) {
            return SliverToBoxAdapter(
              child: Text(l),
            );
          }, (productImageList) {
            return GalleryWidget(product.thumbnail, productImageList);
          })
        },
        if (state is ProductDetailResponseState) ...{
          state.productvarient.fold((l) {
            return SliverToBoxAdapter(
              child: Text(l),
            );
          }, (productvarientList) {
            return VarientContanerGenrator(productvarientList);
          })
        },
        if (state is ProductDetailResponseState) ...{
          state.productProperty.fold((l) {
            return SliverToBoxAdapter(
              child: Text(l),
            );
          }, (propertiyList) {
            return ProductPropertise(propertiyList);
          })
        },
        ProductDescripshen(product.description),
        SliverToBoxAdapter(
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                isDismissible: true,
                useSafeArea: true,
                showDragHandle: true,
                builder: (context) {
                  return BlocProvider(
                      create: (context) {
                        final bloc = CommentBloc(locator.get());
                        bloc.add(CommentInitilzeEvent(product.id));
                        return bloc;
                      },
                      child: CommentBottomsheet(
                        productId: product.id,
                      ));
                },
              );
            },
            child: Container(
              height: 46,
              margin: const EdgeInsets.only(top: 24, left: 44, right: 44),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1, color: CustumColor.gery),
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Image.asset('assets/images/icon_left_categroy.png'),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    ' مشاهده ',
                    style: TextStyle(
                        fontFamily: 'SB',
                        fontSize: 12,
                        color: CustumColor.blue),
                  ),
                  const Spacer(),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        height: 26,
                        width: 26,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      Positioned(
                        right: 15,
                        child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          height: 26,
                          width: 26,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                      Positioned(
                        right: 30,
                        child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          height: 26,
                          width: 26,
                          decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                      Positioned(
                        right: 45,
                        child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          height: 26,
                          width: 26,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                      Positioned(
                        right: 60,
                        child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          height: 26,
                          width: 26,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(8)),
                          child: const Center(
                              child: Text(
                            '+10',
                            style: TextStyle(
                                fontFamily: 'SB',
                                fontSize: 12,
                                color: Colors.white),
                          )),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    ': نظرات کاربران ',
                    style: TextStyle(
                      fontFamily: 'SM',
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 44, right: 44),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PriceTagButton(product),
                AllToBasketButton(product),
              ],
            ),
          ),
        ),
        const SliverPadding(padding: EdgeInsets.only(top: 24)),
      ],
    );
  } else {
    return const Center(
      child: Text('خطایی در دریافت اطلاعات'),
    );
  }
}

class CommentBottomsheet extends StatelessWidget {
  CommentBottomsheet({
    required this.productId,
    super.key,
  });
  final String productId;

  final TextEditingController textContriller =
      TextEditingController(text: 'test1');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentState>(
      builder: (context, state) {
        if (state is CommentloadingState) {
          return const Center(child: LoadingAnimation());
        }
        return Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  if (state is CommentResponseState) ...{
                    state.response.fold((l) {
                      return const SliverToBoxAdapter(
                        child: Center(
                            child: Text('خطایی در نمایش نظرات پیش امده')),
                      );
                    }, (commentList) {
                      if (commentList.isEmpty) {
                        return const SliverToBoxAdapter(
                          child: Center(
                              child: Text('نظری برای این محصول ثبت نشده است')),
                        );
                      }
                      return SliverList(
                          delegate:
                              SliverChildBuilderDelegate((context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 10),
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18)),
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Row(
                              children: [
                                (commentList[index].avatar.isNotEmpty)
                                    ? SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: CachedImage(
                                            imageUrl: commentList[index]
                                                .userThumbnailUrl),
                                      )
                                    : SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: Image.asset(
                                            'assets/images/avatar.png')),
                                const SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          (commentList[index].name.isEmpty)
                                              ? 'کاربر'
                                              : commentList[index].name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Text(commentList[index].text),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }, childCount: commentList.length));
                    })
                  }
                ],
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    TextField(
                      controller: textContriller,
                      decoration: InputDecoration(
                        labelStyle: const TextStyle(
                            fontFamily: 'Sm',
                            fontSize: 18,
                            color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(width: 3, color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                              width: 3, color: CustumColor.blue),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: CustumColor.blue,
                                borderRadius: BorderRadius.circular(15)),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: GestureDetector(
                                onTap: () {
                                  if (textContriller.text.isEmpty) {
                                    return;
                                  }
                                  context.read<CommentBloc>().add(
                                        CommenPostEvent(
                                            productId, textContriller.text),
                                      );
                                },
                                child: const SizedBox(
                                  height: 53,
                                  width: double.infinity,
                                  child: Center(
                                    child: Text(
                                      ' افزودن نظر به محصول ',
                                      style: TextStyle(
                                          fontFamily: 'SB',
                                          fontSize: 16,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

class ProductPropertise extends StatefulWidget {
  final List<Property> productPropertise;

  const ProductPropertise(
    this.productPropertise, {
    super.key,
  });

  @override
  State<ProductPropertise> createState() => _ProductPropertiseState();
}

class _ProductPropertiseState extends State<ProductPropertise> {
  bool _isVisible = false;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isVisible = !_isVisible;
              });
            },
            child: Container(
              height: 46,
              margin: const EdgeInsets.only(top: 24, left: 44, right: 44),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1, color: CustumColor.gery),
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Image.asset('assets/images/icon_left_categroy.png'),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    ' مشاهده ',
                    style: TextStyle(
                        fontFamily: 'SB',
                        fontSize: 12,
                        color: CustumColor.blue),
                  ),
                  const Spacer(),
                  const Text(
                    ': مشخصات فنی ',
                    style: TextStyle(
                      fontFamily: 'SM',
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: _isVisible,
            child: Container(
              margin: const EdgeInsets.only(top: 24, left: 44, right: 44),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1, color: CustumColor.gery),
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.productPropertise.length,
                itemBuilder: (context, index) {
                  var property = widget.productPropertise[index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Text(
                          '${property.titel!} : ${property.value!}',
                          textDirection: TextDirection.rtl,
                          style: const TextStyle(
                            fontFamily: 'SM',
                            fontSize: 14,
                            height: 1.8,
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ProductDescripshen extends StatefulWidget {
  final String productDescripshen;
  const ProductDescripshen(
    this.productDescripshen, {
    super.key,
  });

  @override
  State<ProductDescripshen> createState() => _ProductDescripshenState();
}

class _ProductDescripshenState extends State<ProductDescripshen> {
  bool _isVisible = false;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isVisible = !_isVisible;
              });
            },
            child: Container(
              height: 46,
              margin: const EdgeInsets.only(top: 24, left: 44, right: 44),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1, color: CustumColor.gery),
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Image.asset('assets/images/icon_left_categroy.png'),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    ' مشاهده ',
                    style: TextStyle(
                        fontFamily: 'SB',
                        fontSize: 12,
                        color: CustumColor.blue),
                  ),
                  const Spacer(),
                  const Text(
                    ': توضیحات محصول ',
                    style: TextStyle(
                      fontFamily: 'SM',
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: _isVisible,
            child: Container(
              margin: const EdgeInsets.only(top: 24, left: 44, right: 44),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1, color: CustumColor.gery),
                  borderRadius: BorderRadius.circular(15)),
              child: Text(
                widget.productDescripshen,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                style: const TextStyle(
                    fontFamily: 'SM', fontSize: 16, height: 1.8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VarientContanerGenrator extends StatelessWidget {
  final List<ProductVarint> productVarintList;

  const VarientContanerGenrator(
    this.productVarintList, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Column(
      children: [
        for (var productVarint in productVarintList) ...{
          if (productVarint.variantList.isNotEmpty) ...{
            VarientGenaratorChild(productVarint)
          }
        }
      ],
    ));
  }
}

class VarientGenaratorChild extends StatelessWidget {
  final ProductVarint productVarint;
  const VarientGenaratorChild(this.productVarint, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 44, left: 44),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(productVarint.varientType.titel!,
              style: const TextStyle(
                fontFamily: 'SM',
                fontSize: 12,
              )),
          const SizedBox(
            height: 10,
          ),
          if (productVarint.varientType.type == VariantTypeEnum.COLOR) ...{
            ColorVarinantList(productVarint.variantList),
          },
          if (productVarint.varientType.type == VariantTypeEnum.STORAGE) ...{
            StorageVarinantList(productVarint.variantList)
          },
        ],
      ),
    );
  }
}

class GalleryWidget extends StatefulWidget {
  List<ProductImage> productImageList;
  String? defaultProductThumbnail;
  int selectedItem = 0;

  GalleryWidget(
    this.defaultProductThumbnail,
    this.productImageList, {
    super.key,
  });

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 44),
        child: Container(
          height: 284,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, right: 14, left: 14),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/icon_star.png'),
                          const SizedBox(
                            width: 2,
                          ),
                          const Text(
                            '4.6',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'SM',
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      SizedBox(
                          height: 200,
                          width: 200,
                          child: CachedImage(
                            imageUrl: (widget.productImageList.isEmpty)
                                ? widget.defaultProductThumbnail
                                : widget.productImageList[widget.selectedItem]
                                    .imageUrl,
                          )),
                      const Spacer(),
                      Image.asset('assets/images/icon_favorite_deactive.png'),
                    ],
                  ),
                ),
              ),
              if (widget.productImageList.isNotEmpty) ...{
                SizedBox(
                    height: 70,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 44, right: 44, top: 4),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.productImageList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                widget.selectedItem = index;
                              });
                            },
                            child: Container(
                              height: 70,
                              width: 70,
                              margin: const EdgeInsets.only(left: 20),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: CustumColor.gery,
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: CachedImage(
                                  imageUrl:
                                      widget.productImageList[index].imageUrl,
                                  radiys: 10,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )),
              },
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AllToBasketButton extends StatelessWidget {
  final Product product;
  const AllToBasketButton(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
          height: 60,
          width: 140,
          decoration: BoxDecoration(
              color: CustumColor.blue, borderRadius: BorderRadius.circular(15)),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: GestureDetector(
              onTap: () {
                context.read<ProductBloc>().add(ProductAddToBasket(product));
                context.read<BasketBloc>().add(BasketFetchFromHiveEvent());
              },
              child: const SizedBox(
                height: 53,
                width: 160,
                child: Center(
                  child: Text(
                    'افزودن سبد خرید',
                    style: TextStyle(
                        fontFamily: 'SB', fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PriceTagButton extends StatelessWidget {
  final Product product;
  const PriceTagButton(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
          height: 60,
          width: 140,
          decoration: BoxDecoration(
              color: CustumColor.green,
              borderRadius: BorderRadius.circular(15)),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: SizedBox(
              height: 53,
              width: 160,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Text(
                      'تومان',
                      style: TextStyle(
                        fontFamily: 'SM',
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${product.price}',
                          style: const TextStyle(
                              fontFamily: 'SM',
                              fontSize: 12,
                              color: Colors.white,
                              decoration: TextDecoration.lineThrough),
                        ),
                        Text(
                          '${product.realprice}',
                          style: const TextStyle(
                            fontFamily: 'SM',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      decoration: const BoxDecoration(
                          color: CustumColor.red,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 6),
                        child: Text(
                          '%${product.persent!.round().toString()}',
                          style: const TextStyle(
                              fontFamily: 'SB',
                              fontSize: 12,
                              color: Colors.white),
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

class ColorVarinantList extends StatefulWidget {
  final List<Variant> variantList;

  const ColorVarinantList(this.variantList, {super.key});

  @override
  State<ColorVarinantList> createState() => _ColorVarinantListState();
}

class _ColorVarinantListState extends State<ColorVarinantList> {
  int _selctedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.variantList.length,
          itemBuilder: (context, index) {
            String categoryColor = 'ff${widget.variantList[index].value}';
            int hexColor = int.parse(categoryColor, radix: 16);

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selctedIndex = index;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                height: 30,
                width: 30,
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                    border: (_selctedIndex == index)
                        ? Border.all(
                            width: 1,
                            color: CustumColor.blueIndicator,
                            strokeAlign: BorderSide.strokeAlignOutside)
                        : Border.all(width: 2, color: Colors.white),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Container(
                    decoration: BoxDecoration(
                        color: Color(hexColor),
                        borderRadius: BorderRadius.circular(8))),
              ),
            );
          },
        ),
      ),
    );
  }
}

///////////////////////////////////

class StorageVarinantList extends StatefulWidget {
  final List<Variant> storagevariants;
  const StorageVarinantList(this.storagevariants, {super.key});

  @override
  State<StorageVarinantList> createState() => _StorageVarinantListState();
}

class _StorageVarinantListState extends State<StorageVarinantList> {
  int _selctedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 26,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.storagevariants.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selctedIndex = index;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                height: 25,
                decoration: BoxDecoration(
                    border: (_selctedIndex == index)
                        ? Border.all(width: 2, color: CustumColor.blueIndicator)
                        : Border.all(width: 1, color: CustumColor.gery),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Center(
                    child: Text(
                      widget.storagevariants[index].value!,
                      style: const TextStyle(
                        fontFamily: 'SB',
                        fontSize: 12,
                      ),
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

import 'package:apple_shop/bloc/home/home_bloc.dart';
import 'package:apple_shop/bloc/home/home_state.dart';
import 'package:apple_shop/data/model/category.dart';
import 'package:apple_shop/data/model/product.dart';
import 'package:apple_shop/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home/home_event.dart';
import '../constants/colors.dart';
import '../data/model/banner.dart';
import '../widgets/banner_slider.dart';
import '../widgets/category_icon_item_chip.dart';
import '../widgets/product_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustumColor.backgroundScreenColor,
      body: SafeArea(child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return _getHomeScreenContent(state, context);
        },
      )),
    );
  }
}

Widget _getHomeScreenContent(HomeState state, BuildContext context) {
  if (state is HomeLodingState) {
    return const Center(child: LoadingAnimation());
  } else if (state is HomeRequesSuccessState) {
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<HomeBloc>(context).add(HomeGetInitilzeData());
        //  context.read<HomeBloc>().add(HomeGetInitilzeData());
      },
      child: CustomScrollView(
        slivers: [
          SliverPadding(padding: EdgeInsets.only(top: 24)),
          const _getSearchBox(),
          state.bannerList.fold((exceptionMassage) {
            return SliverToBoxAdapter(
              child: Text(exceptionMassage),
            );
          }, (listBanners) {
            return _getBaneers(listBanners);
          }),
          const _getCategoryListTitel(),
          state.categoryList.fold((exceptionMassage) {
            return SliverToBoxAdapter(child: Text(exceptionMassage));
          }, (categoryList) {
            return _getCategoryList(categoryList);
          }),
          const _getBestSellerTitel(),
          state.bestsellerproductList.fold((exceptionMassage) {
            return SliverToBoxAdapter(child: Text(exceptionMassage));
          }, (bestsellerproductsList) {
            return _getBestSellerProducts(bestsellerproductsList);
          }),
          const _getMostViewedTitel(),
          state.hotestproductList.fold((exceptionMassage) {
            return SliverToBoxAdapter(child: Text(exceptionMassage));
          }, (hotestproductsList) {
            return _getMostViewedProduct(hotestproductsList);
          }),
          SliverPadding(padding: EdgeInsets.only(top: 24)),
        ],
      ),
    );
  } else {
    return const Center(
      child: Text('خطایی در دریافت اطلاعات'),
    );
  }
}

class _getMostViewedProduct extends StatelessWidget {
  List<Product> hotestProductList;
  _getMostViewedProduct(
    this.hotestProductList, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(right: 44),
        child: SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: hotestProductList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ProductItem(hotestProductList[index]),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _getMostViewedTitel extends StatelessWidget {
  const _getMostViewedTitel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 44, right: 44, bottom: 20, top: 32),
        child: Row(
          children: [
            const Text(
              'پر بازدید ترین ها',
              style: TextStyle(
                  fontFamily: 'SB', color: CustumColor.gery, fontSize: 12),
            ),
            const Spacer(),
            const Text(
              'مشاهده همه',
              style: TextStyle(fontFamily: 'SB', color: CustumColor.blue),
            ),
            const SizedBox(
              width: 10,
            ),
            Image.asset('assets/images/icon_left_categroy.png'),
          ],
        ),
      ),
    );
  }
}

class _getBestSellerProducts extends StatelessWidget {
  List<Product> bestsellerproductsList;
  _getBestSellerProducts(
    this.bestsellerproductsList, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(right: 44),
        child: SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: bestsellerproductsList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ProductItem(bestsellerproductsList[index]),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _getBestSellerTitel extends StatelessWidget {
  const _getBestSellerTitel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 44, right: 44, bottom: 20),
        child: Row(
          children: [
            const Text(
              'پر فروشترین ها',
              style: TextStyle(
                  fontFamily: 'SB', color: CustumColor.gery, fontSize: 12),
            ),
            const Spacer(),
            const Text(
              'مشاهده همه',
              style: TextStyle(fontFamily: 'SB', color: CustumColor.blue),
            ),
            const SizedBox(
              width: 10,
            ),
            Image.asset('assets/images/icon_left_categroy.png'),
          ],
        ),
      ),
    );
  }
}

class _getCategoryList extends StatelessWidget {
  List<Category> listCategories;
  _getCategoryList(
    this.listCategories, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(right: 44),
        child: SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: listCategories.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 20),
                child: CategorylItemChip(listCategories[index]),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _getCategoryListTitel extends StatelessWidget {
  const _getCategoryListTitel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(left: 44, right: 44, bottom: 20, top: 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'دسته بندی',
              style: TextStyle(
                  fontFamily: 'SB', color: CustumColor.gery, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class _getBaneers extends StatelessWidget {
  List<BannerCampin> bannerCampain;
  _getBaneers(
    this.bannerCampain, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BannerSlider(bannerCampain),
    );
  }
}

class _getSearchBox extends StatelessWidget {
  const _getSearchBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
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
              Image.asset('assets/images/icon_search.png'),
              const SizedBox(
                width: 10,
              ),
              const Expanded(
                child: Text(
                  'جستجوی محصولات',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontFamily: 'SB', fontSize: 16, color: CustumColor.gery),
                ),
              ),
              Image.asset('assets/images/icon_apple_blue.png'),
              const SizedBox(
                width: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

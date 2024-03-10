import 'package:apple_shop/bloc/category/category_bloc.dart';
import 'package:apple_shop/bloc/category/category_event.dart';
import 'package:apple_shop/bloc/category/category_state.dart';
import 'package:apple_shop/data/model/category.dart';

import 'package:apple_shop/widgets/cached_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/colors.dart';

class CategorryScreen extends StatefulWidget {
  const CategorryScreen({super.key});

  @override
  State<CategorryScreen> createState() => _CategorryScreenState();
}

class _CategorryScreenState extends State<CategorryScreen> {
  @override
  void initState() {
    BlocProvider.of<CategoryBloc>(context).add(CategoryRequestList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustumColor.backgroundScreenColor,
      body: SafeArea(
          child: CustomScrollView(
        slivers: [
          SliverPadding(padding: EdgeInsets.only(top: 24)),
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
                    const Expanded(
                      child: Text(
                        'دسته بندی',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'SB',
                            fontSize: 16,
                            color: CustumColor.blue),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state is CategoryLodingState) {
                return const SliverToBoxAdapter(
                    child: CircularProgressIndicator());
              }
              if (state is CategoryResponseState) {
                return state.response.fold((l) {
                  return SliverToBoxAdapter(
                    child: Center(child: Text(l)),
                  );
                }, (r) {
                  return ListCategory(
                    list: r,
                  );
                });
              }
              return const SliverToBoxAdapter(
                  child: Center(child: Text('error2')));
            },
          ),
          SliverPadding(padding: EdgeInsets.only(top: 24)),
        ],
      )),
    );
  }
}

class ListCategory extends StatelessWidget {
  final List<Category>? list;
  const ListCategory({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 44),
      sliver: SliverGrid(
          delegate: SliverChildBuilderDelegate((context, index) {
            return CachedImage(imageUrl: list?[index].thumbnail);
          }, childCount: list?.length ?? 0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 20)),
    );
  }
}

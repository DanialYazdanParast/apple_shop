import 'package:apple_shop/bloc/basket/basket_bloc.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/data/model/card_item.dart';
import 'package:apple_shop/util/extenstions/double_extension.dart';
import 'package:apple_shop/util/extenstions/string_extentions.dart';
import 'package:apple_shop/widgets/cached_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardScreen extends StatelessWidget {
  const CardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustumColor.backgroundScreenColor,
      body: SafeArea(child: BlocBuilder<BasketBloc, BasketState>(
        builder: (context, state) {
          return Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              CustomScrollView(
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
                                'سبد خرید',
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
                  if (state is BasketDataFetchedState) ...{
                    state.basketItem.fold((l) {
                      return SliverToBoxAdapter(child: Text(l));
                    }, (basketItemList) {
                      return SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          return CardItem(
                              basketItemList.toList()[index], index);
                        }, childCount: basketItemList.length),
                      );
                    })
                  },
                  const SliverPadding(padding: EdgeInsets.only(bottom: 100))
                ],
              ),
              if (state is BasketDataFetchedState) ...{
                Padding(
                  padding:
                      const EdgeInsets.only(left: 44, right: 44, bottom: 20),
                  child: SizedBox(
                    height: 53,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: CustumColor.green,
                            textStyle:
                                const TextStyle(fontSize: 18, fontFamily: 'SM'),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            )),
                        onPressed: () {
                          context
                              .read<BasketBloc>()
                              .add(BasketPaymentInitEvent());

                          context
                              .read<BasketBloc>()
                              .add(BasketPaymentRequestEvent());
                        },
                        child: Text(
                          (state.basketFinalPrice == 0)
                              ? 'سبد خرید شما خالی است'
                              : '  پرداخت مبلغ : ${state.basketFinalPrice.convertToPrice()}  ',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ),
                )
              },
            ],
          );
        },
      )),
    );
  }
}

class CardItem extends StatelessWidget {
  final BasketItem basketItem;
  final int index;

  const CardItem(
    this.basketItem,
    this.index, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 249,
      margin: const EdgeInsets.only(left: 44, right: 44, bottom: 20),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Expanded(
            child: Row(children: [
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        basketItem.name,
                        style: const TextStyle(fontFamily: 'SB', fontSize: 16),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      const Text(
                        'گارانتی 18 ماهه',
                        style: TextStyle(fontFamily: 'SM', fontSize: 12),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                                color: CustumColor.red,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 6),
                              child: Text(
                                '%3',
                                style: TextStyle(
                                    fontFamily: 'SB',
                                    fontSize: 12,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          const Text('تومان',
                              style: TextStyle(fontFamily: 'SM', fontSize: 12)),
                          const SizedBox(
                            width: 4,
                          ),
                          Text('${basketItem.price.convertToPrice()}',
                              style: const TextStyle(
                                  fontFamily: 'SM', fontSize: 12)),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Wrap(
                        spacing: 8,
                        children: [
                          GestureDetector(
                            onTap: (() {
                              context
                                  .read<BasketBloc>()
                                  .add(BasketremoveproductEvent(index));
                            }),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: CustumColor.red,
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 2),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      'حذف',
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                          color: CustumColor.red,
                                          fontFamily: 'SM',
                                          fontSize: 12),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Image.asset('assets/images/icon_trash.png'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const OpshenCheap(
                            'تست',
                            color: '4287f5',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: SizedBox(
                      height: 104,
                      width: 75,
                      child: CachedImage(
                        imageUrl: basketItem.thumbnail,
                      )))
            ]),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DottedLine(
              lineThickness: 3,
              dashLength: 8,
              dashColor: CustumColor.gery.withOpacity(0.5),
              dashGapLength: 3,
              dashGapColor: Colors.transparent,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'تومان',
                  style: TextStyle(fontFamily: "SB", fontSize: 16),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  '${basketItem.realprice.convertToPrice()}',
                  style: const TextStyle(fontFamily: "SB", fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OpshenCheap extends StatelessWidget {
  final String? color;
  final String titel;
  const OpshenCheap(this.titel, {super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: CustumColor.gery,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (color != null) ...{
              Container(
                width: 12,
                height: 12,
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.parseToColor(),
                ),
              )
            },
            Text(titel,
                textDirection: TextDirection.rtl,
                style: const TextStyle(fontFamily: 'SM', fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

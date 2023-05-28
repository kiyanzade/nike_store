import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nike_store/ui/home/bloc/home_bloc.dart';
import 'package:nike_store/ui/product_list/product_list.dart';

import '../../common/exceptions.dart';
import '../../data/product.dart';
import '../../data/repo/banner_repository.dart';
import '../../data/repo/product_repository.dart';
import '../product/product.dart';
import '../widgets/bannerSlider.dart';
import '../widgets/errorRefresh.dart';
import '../widgets/imageService.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final homeBloc = HomeBloc(
            productRepository: productRepository,
            bannerRepository: bannerRepository);
        homeBloc.add(HomeStartedEvent());
        return homeBloc;
      },
      child: SafeArea(
        child: Scaffold(
          body: BlocBuilder<HomeBloc, HomeState>(
            builder: (BuildContext context, state) {
              if (state is HomeSuccessState) {
                return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      switch (index) {
                        case 0:
                          return Container(
                            padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                            child: Image.asset(
                              'assets/images/nike_logo.png',
                              height: 24,
                            ),
                          );

                        case 2:
                          return BannerSlider(
                            banners: state.banners,
                          );
                        case 3:
                          return _HorizontalProductList(
                            title: "جدیدترین",
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const ProductList(sort: ProductSort.latest),
                              ));
                            },
                            products: state.latestProducts,
                          );
                        case 4:
                          return _HorizontalProductList(
                            title: "پربازدیدترین",
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const ProductList(
                                    sort: ProductSort.popular),
                              ));
                            },
                            products: state.popularProducts,
                          );
                        default:
                          return Container();
                      }
                    });
              } else if (state is HomeLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is HomeErrorState) {
                return AppErrorWidget(
                  exception: state.exception,
                  onPressed: () {
                    BlocProvider.of<HomeBloc>(context).add(HomeRefreshEvent());
                  },
                );
              } else
                throw Exception('state is not supported');
            },
          ),
        ),
      ),
    );
  }
}

class _HorizontalProductList extends StatelessWidget {
  final String title;
  final Function() onTap;
  final List<Product> products;
  const _HorizontalProductList({
    super.key,
    required this.title,
    required this.onTap,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 12, left: 12),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              title,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            TextButton(
              onPressed: onTap,
              child: const Text(
                'مشاهده همه',
              ),
            ),
          ]),
        ),
        SizedBox(
          height: 310,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            padding: const EdgeInsets.only(right: 8, left: 8),
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductItem(product: product);
            },
          ),
        )
      ],
    );
  }
}

extension PriceLabel on int {
  String get withPriceLabel => '$separateByComma تومان';

  String get separateByComma {
    final numberFormat = NumberFormat.decimalPattern();
    return numberFormat.format(this);
  }
}

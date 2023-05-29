import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_store/data/repo/product_repository.dart';
import 'package:nike_store/ui/product/product.dart';
import 'package:nike_store/ui/product_list/bloc/product_list_bloc.dart';

class ProductList extends StatefulWidget {
  final int sort;
  const ProductList({super.key, required this.sort});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  int crossAxisCount = 2;
  @override
  void dispose() {
    productListBloc?.close();
    super.dispose();
  }

  ProductListBloc? productListBloc;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('کفش‌های ورزشی')),
      body: BlocProvider<ProductListBloc>(
        create: (context) {
          productListBloc = ProductListBloc(productRepository);
          productListBloc!.add(ProductListStartedEvent(widget.sort));
          return productListBloc!;
        },
        child: BlocBuilder<ProductListBloc, ProductListState>(
          builder: (context, state) {
            if (state is ProductListSuccessedState) {
              final products = state.products;
              return Column(
                children: [
                  Container(
                    height: 56,
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                width: 1,
                                color: Colors.black.withOpacity(0.05))),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 20)
                        ]),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8, left: 8),
                            child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(32),
                                          topRight: Radius.circular(32))),
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      padding: const EdgeInsets.only(
                                          right: 16, top: 12),
                                      height: 250,
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'انتخاب مرتب سازی',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6,
                                            ),
                                            Expanded(
                                              child: ListView.builder(
                                                itemCount:
                                                    state.sortNames.length,
                                                itemBuilder: (context, index) {
                                                  final selectedSortIndex =
                                                      state.sort;
                                                  return InkWell(
                                                    onTap: () {
                                                      productListBloc?.add(
                                                          ProductListStartedEvent(
                                                              index));

                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 14),
                                                      child: Text(
                                                          state
                                                              .sortNames[index],
                                                          style: TextStyle(
                                                            color: index ==
                                                                    selectedSortIndex
                                                                ? Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .primary
                                                                : null,
                                                          )),
                                                    ),
                                                  );
                                                },
                                              ),
                                            )
                                          ]),
                                    );
                                  },
                                );
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon:
                                          const Icon(CupertinoIcons.sort_down)),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('مرتب سازی'),
                                      Text(
                                        state.sortNames[state.sort],
                                        style:
                                            Theme.of(context).textTheme.caption,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                crossAxisCount = crossAxisCount == 2 ? 3 : 2;
                              });
                            },
                            icon: const Icon(CupertinoIcons.square_grid_2x2)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.54,
                        crossAxisCount: crossAxisCount,
                      ),
                      itemCount: products.length,
                      itemBuilder: (BuildContext context, int index) {
                        final product = products[index];
                        return ProductItem(product: product);
                      },
                    ),
                  ),
                ],
              );
            } else if (state is ProductListErrorState) {
              return Center(
                child: Text(state.appException.message),
              );
            } else if (state is ProductListLoadingState) {
              return const Center(child: CupertinoActivityIndicator());
            } else {
              throw Exception('state is not valid');
            }
          },
        ),
      ),
    );
  }
}

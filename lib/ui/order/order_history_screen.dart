
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_store/data/repo/order_repository.dart';
import 'package:nike_store/ui/home/home.dart';
import 'package:nike_store/ui/order/bloc/order_history_bloc.dart';
import 'package:nike_store/ui/product/details.dart';


import '../widgets/imageService.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderHistoryBloc>(
      create: (BuildContext context) {
        final orderHistoryBloc = OrderHistoryBloc(orderRepository);
        orderHistoryBloc.add(OrderHistoryStartedEvent());
        return orderHistoryBloc;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('سوابق سفارش')),
        body: BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
          builder: (context, state) {
            if (state is OrderHistorySuccessState) {
              final orders = state.orders;
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  final products = order.products;
                  return Container(
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black.withOpacity(0.1)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          height: 56,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('شناسه سفارش'),
                                Text(order.id.toString()),
                              ]),
                        ),
                        const Divider(
                          height: 3,
                          thickness: 1,
                        ),
                        Container(
                          height: 56,
                          padding: const EdgeInsets.all(16),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('مبلغ'),
                                Text(order.payablePrice.withPriceLabel),
                              ]),
                        ),
                        const Divider(
                          height: 2,
                          thickness: 1,
                        ),
                        SizedBox(
                          height: 120,
                          child: ListView.builder(
                            padding: const EdgeInsets.only(right: 8, left: 8),
                            itemCount: products.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final product = products[index];
                              return Container(
                                  width: 120,
                                  height: 120,
                                  margin: const EdgeInsets.only(
                                      right: 4, left: 4, top: 8, bottom: 8),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            ProductDetailsScreen(
                                                product: product),
                                      ));
                                    },
                                    child: ImageLoadingService(
                                      imageUrl: product.imageUrl,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ));
                            },
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            } else if (state is OrderHistoryErrorState) {
              return Center(child: Text(state.exception.message));
            } else if (state is OrderHistoryLoadingState) {
              return const Center(child: CupertinoActivityIndicator());
            } else
              throw Exception('state is not supported');
          },
        ),
      ),
    );
  }
}

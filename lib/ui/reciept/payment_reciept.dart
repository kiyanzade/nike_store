import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_store/data/repo/order_repository.dart';
import 'package:nike_store/ui/home/home.dart';
import 'package:nike_store/ui/order/order_history_screen.dart';
import 'package:nike_store/ui/reciept/bloc/payment_reciept_bloc.dart';

class PaymentReciept extends StatelessWidget {
  final int orderId;
  const PaymentReciept({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("رسید پرداخت"), centerTitle: true),
      body: BlocProvider<PaymentRecieptBloc>(
        create: (BuildContext context) {
          return PaymentRecieptBloc(orderRepository)
            ..add(PaymentRecieptStartedEvent(orderId));
        },
        child: BlocBuilder<PaymentRecieptBloc, PaymentRecieptState>(
          builder: (BuildContext context, state) {
            if (state is PaymentRecieptSuccessState) {
              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(16, 48, 16, 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1, color: Colors.black.withOpacity(0.1)),
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      children: [
                        Text(
                            state.data.purchaseSuccess
                                ? "پرداخت با موفقیت انجام شد"
                                : "پرداخت ناموفق",
                            style: Theme.of(context).textTheme.headline6!.apply(
                                color: Theme.of(context).colorScheme.primary)),
                        const SizedBox(
                          height: 32,
                        ),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("وضعیت سفارش",
                                  style: Theme.of(context).textTheme.subtitle1),
                              Text(state.data.paymentStatus,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                            ]),
                        const Divider(
                          height: 32,
                          thickness: 1,
                        ),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("مبلغ",
                                  style: Theme.of(context).textTheme.subtitle1),
                              Text(state.data.payablePrice.withPriceLabel,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                            ]),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                          onPressed: () {
                            Navigator.of(context)
                              ..popUntil((route) => route.isFirst)
                              ..push(MaterialPageRoute(
                                builder: (context) =>
                                    const OrderHistoryScreen(),
                              ));
                          },
                          child: const Text('سوابق سفارش')),
                      const SizedBox(
                        width: 12,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
                          },
                          child: const Text('بازگشت به صفحه اصلی')),
                    ],
                  ),
                ],
              );
            } else if (state is PaymentRecieptLoadingState) {
              return const Center(child: CupertinoActivityIndicator());
            } else if (state is PaymentRecieptErrorState) {
              return Text(state.appExecution.message);
            } else {
              throw Exception('state is not supported');
            }
          },
        ),
      ),
    );
  }
}

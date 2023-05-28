import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_store/data/order.dart';
import 'package:nike_store/ui/cart/cart_price_info.dart';
import 'package:nike_store/ui/reciept/payment_reciept.dart';
import 'package:nike_store/ui/shipping/bloc/shipping_bloc.dart';

import '../../data/repo/order_repository.dart';

class Shipping extends StatefulWidget {
  final int payablePrice;
  final int shippingPrice;
  final int totalPrice;

  Shipping(
      {super.key,
      required this.payablePrice,
      required this.shippingPrice,
      required this.totalPrice});

  @override
  State<Shipping> createState() => _ShippingState();
}

class _ShippingState extends State<Shipping> {
  final TextEditingController firstNameController =
      TextEditingController(text: 'صادق');

  final TextEditingController lastNameController =
      TextEditingController(text: 'کیان زاده');

  final TextEditingController phoneNumberController =
      TextEditingController(text: '09107793789');

  final TextEditingController postalCodeController =
      TextEditingController(text: '8851555151');

  final TextEditingController addressController =
      TextEditingController(text: 'تهران، خیابان رضایی، کوچه شمشاد');

  StreamSubscription? subscription;
  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("تحویل گیرنده"),
      ),
      body: BlocProvider<ShippingBloc>(
        create: (BuildContext context) {
          final shippingBloc = ShippingBloc(orderRepository);
          subscription = shippingBloc.stream.listen((state) {
            if (state is ShippingErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.appException.message)));
            } else if (state is ShippingSuccessState) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PaymentReciept(
                  orderId: state.result.orderId,
                ),
              ));
            }
          });
          return shippingBloc;
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Column(
            children: [
              TextField(
                controller: firstNameController,
                decoration: const InputDecoration(
                  label: Text('نام'),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: lastNameController,
                decoration: const InputDecoration(
                  label: Text('نام خانوادگی'),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: phoneNumberController,
                decoration: const InputDecoration(
                  label: Text('شماره تماس'),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: postalCodeController,
                decoration: const InputDecoration(
                  label: Text('کد پستی'),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(
                  label: Text('آدرس'),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              PriceInfo(
                  payablePrice: widget.payablePrice,
                  shippingPrice: widget.shippingPrice,
                  totalPrice: widget.totalPrice),
              BlocBuilder<ShippingBloc, ShippingState>(
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<ShippingBloc>(context).add(
                                ShippingCreateOrderEvent(CreateOrderParams(
                                    firstNameController.text,
                                    lastNameController.text,
                                    phoneNumberController.text,
                                    postalCodeController.text,
                                    addressController.text,
                                    PaymentMethod.online)));
                          },
                          child: state is ShippingLoadingState
                              ? CupertinoActivityIndicator()
                              : Text('پرداخت اینترنتی')),
                      const SizedBox(
                        width: 16,
                      ),
                      OutlinedButton(
                          onPressed: () {},
                          child: state is ShippingLoadingState
                              ? CupertinoActivityIndicator()
                              : Text('پرداخت در محل')),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

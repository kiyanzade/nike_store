import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nike_store/data/auth_info.dart';
import 'package:nike_store/data/cart_itam.dart';
import 'package:nike_store/data/repo/cart_repository.dart';
import 'package:nike_store/ui/cart/bloc/cart_bloc.dart';
import 'package:nike_store/ui/cart/cart_price_info.dart';
import 'package:nike_store/ui/home/home.dart';
import 'package:nike_store/ui/shipping/shipping.dart';
import 'package:nike_store/ui/widgets/emptyScreen.dart';
import 'package:nike_store/ui/widgets/imageService.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../data/repo/auth_repository.dart';
import '../auth/auth.dart';
import '../widgets/cartItem.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool stateIsSuccsed = false;
  CartBloc? cartBloc;
  StreamSubscription? subscription;
  final RefreshController refreshController = RefreshController();
  @override
  void initState() {
    super.initState();
    AuthRepository.authChangeNotifier.addListener(authChangeNotifierListener);
  }

  void authChangeNotifierListener() {
    cartBloc?.add(
        CartAuthInfoChangedEvent(AuthRepository.authChangeNotifier.value));
  }

  @override
  void dispose() {
    super.dispose();
    AuthRepository.authChangeNotifier
        .removeListener(authChangeNotifierListener);

    subscription?.cancel();
    cartBloc?.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      floatingActionButton: Visibility(
        visible: stateIsSuccsed,
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(left: 32, right: 32),
          child: FloatingActionButton.extended(
            onPressed: () {
              final state = cartBloc!.state;
              if (state is CartSuccessState) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Shipping(
                      shippingPrice: state.cartResponse.shippingPrice,
                      payablePrice: state.cartResponse.payablePrice,
                      totalPrice: state.cartResponse.totalPrice),
                ));
              }
            },
            label: Text('پرداخت'),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("سبد خرید"),
      ),
      body: BlocProvider<CartBloc>(
        create: (context) {
          final CartBloc cartBloc = CartBloc(cartRepository);
          subscription = cartBloc.stream.listen((state) {
            setState(() {
              stateIsSuccsed = state is CartSuccessState;
            });
            if (refreshController.isRefresh) {
              if (state is CartSuccessState) {
                refreshController.refreshCompleted();
              } else if (state is CartErrorState) {
                refreshController.refreshFailed();
              }
            }
          });

          this.cartBloc = cartBloc;
          cartBloc
              .add(CartStartedEvent(AuthRepository.authChangeNotifier.value));
          return cartBloc;
        },
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CartErrorState) {
              return Center(child: Text(state.appException.message));
            } else if (state is CartSuccessState) {
              return SmartRefresher(
                controller: refreshController,
                onRefresh: () {
                  cartBloc?.add(CartStartedEvent(
                      AuthRepository.authChangeNotifier.value));
                },
                child: ListView.builder(
                  padding: EdgeInsets.only(bottom: 80),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (index == state.cartResponse.cartItems.length) {
                      return PriceInfo(
                          payablePrice: state.cartResponse.payablePrice,
                          shippingPrice: state.cartResponse.shippingPrice,
                          totalPrice: state.cartResponse.totalPrice);
                    } else {
                      final cartItem = state.cartResponse.cartItems[index];
                      return CartItemWidget(
                        cartItem: cartItem,
                        onDeleteButtonTapped: () {
                          cartBloc?.add(CartDeleteButtonClickedEvent(
                              cartItem.cartItemtId));
                        },
                        onPlusButtonTapped: () {
                          cartBloc?.add(CartPlusCountButtonClickedEvent(
                              cartItem.cartItemtId));
                        },
                        onMinusButtonTapped: () {
                          if (cartItem.count > 1) {
                            cartBloc?.add(CartMinusCountButtonClickedEvent(
                                cartItem.cartItemtId));
                          }
                        },
                      );
                    }
                  },
                  itemCount: state.cartResponse.cartItems.length + 1,
                ),
              );
            } else if (state is CartAuthRequiredState) {
              return EmptyScreen(
                message: 'برای مشاهده سبد خرید لطفا وارد حساب کاربری خود شوید',
                callToAction: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const AuthScreen(),
                        ),
                      );
                    },
                    child: const Text('ورود به حساب کاربری')),
                image: SvgPicture.asset(
                  'assets/images/auth_required.svg',
                  width: 140,
                ),
              );
            } else if (state is CartEmptyState) {
              return EmptyScreen(
                message: 'تاکنون هیچ محصولی در سبد خرید ثبت نشده است',
                image: SvgPicture.asset('assets/images/empty_cart.svg',
                    width: 200),
              );
            } else {
              throw Exception("Invalid State");
            }
          },
        ),
      ),
    );

    // ValueListenableBuilder<AuthInfo?>(
    //   valueListenable: AuthRepository.authChangeNotifier,
    //   builder: (context, authState, child) {
    //     bool isAuthenticated =
    //         authState != null && authState.accessToken.isNotEmpty;
    //     return SizedBox(
    //       width: MediaQuery.of(context).size.width,
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           Text(isAuthenticated
    //               ? 'خوش آمدید'
    //               : 'لطفا وارد حساب کاربری خود شوید'),
    //           isAuthenticated
    //               ? ElevatedButton(
    //                   onPressed: () {
    //                     authRepository.signOut();
    //                   },
    //                   child: const Text('خروج از حساب'))
    //               : ElevatedButton(
    //                   onPressed: () {
    //                     Navigator.of(context, rootNavigator: true).push(
    //                         MaterialPageRoute(
    //                             builder: (context) => const AuthScreen()));
    //                   },
    //                   child: const Text('ورود')),
    //           ElevatedButton(
    //               onPressed: () async {
    //                 await authRepository.refreshToken();
    //               },
    //               child: const Text('Refresh Token')),
    //         ],
    //       ),
    //     );
    //   },
    // ),
  }
}

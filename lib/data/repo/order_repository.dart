import 'package:flutter/cupertino.dart';
import 'package:nike_store/data/order.dart';
import 'package:nike_store/data/payment_reciept.dart';
import 'package:nike_store/data/source/order_data_source.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../common/http_client.dart';

final IOrderRepository orderRepository =
    OrderRepository(OrderRemoteDataSource(httpClient));

abstract class IOrderRepository {
  Future<CreateOrderResult> create(CreateOrderParams params);
  Future<PaymentRecieptData> getPaymentReciept(int orderId);
  Future<List<OrderEntity>> getOrders();
}

class OrderRepository extends IOrderRepository {
  final IOrderDataSource dataSource;

  OrderRepository(this.dataSource);

  @override
  Future<CreateOrderResult> create(CreateOrderParams params) {
    return dataSource.create(params);
  }

  @override
  Future<PaymentRecieptData> getPaymentReciept(int orderId) {
    return dataSource.getPaymentReciept(orderId);
  }

  @override
  Future<List<OrderEntity>> getOrders() {
    return dataSource.getOrders();
  }
}

import 'package:provider/provider.dart';

class Order {
  String _orderId;
  String _restId, _userId;
  String _orderStatus;
  double _totalPrice;
  String _tableNumber;
  List<String>? _orderItems;

  String get orderId {
    return _orderId;
  }

  set orderId(String orderId) {
    _orderId = orderId;
  }

  String get restId {
    return _restId;
  }

  set restId(String newRestId) {
    _restId = newRestId;
  }

  String get userId {
    return _userId;
  }

  String get orderStatus {
    return _orderStatus;
  }

  set orderStatus(String newOrderStatus) {
    _orderStatus = newOrderStatus;
  }

  double get totalPrice {
    return _totalPrice;
  }

  set totalPrice(double totalPrice) {
    _totalPrice = totalPrice;
  }

  String get tableNumber {
    return _tableNumber;
  }

  set tableNumber(String tableNumber) {
    _tableNumber = tableNumber;
  }

  List<String>? get orderItems {
    return _orderItems;
  }

  set orderItems(List<String>? orderItems) {
    _orderItems = orderItems;
  }

  Order(
      {String? orderId,
      String restId = '',
      String userId = '',
      String orderStatus = '',
      double totalPrice = 0,
      String tableNumber = '',
      List<String>? orderItems})
      : _orderId = orderId = "",
        _restId = restId,
        _userId = userId,
        _orderStatus = orderStatus,
        _totalPrice = totalPrice,
        _tableNumber = tableNumber,
        _orderItems = orderItems;

  Order.fromJson(Map<String, dynamic> map)
      : _orderId = map['orderId'],
        _restId = map['restId'],
        _userId = map['userId'],
        _orderStatus = map['orderStatus'],
        _totalPrice = map['totalPrice'] + .0,
        _tableNumber = map['tableNumber'],
        _orderItems = List<String>.from(map['orderItems']);

  Map<String, dynamic> toJson() {
    return {
      'orderId': _orderId,
      'restId': _restId,
      'userId': _userId,
      'orderStatus': _orderStatus,
      'totalPrice': _totalPrice,
      'tableNumber': _tableNumber,
      'orderItems': _orderItems,
    };
  }

  Order copyWith(Map<String, dynamic> map) {
    return Order.fromJson(map);
  }
}

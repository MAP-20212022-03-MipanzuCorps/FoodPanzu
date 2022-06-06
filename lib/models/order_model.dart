import 'package:provider/provider.dart';

class Order {
  String? _orderId;
  String _restId, _userId;
  String _orderStatus;
  double _totalPrice;
  String _tableNumber;

  String? get orderId {
    return _orderId;
  }

  String get restId {
    return _restId;
  }

  String get userId {
    return _userId;
  }

  String get orderStatus {
    return _orderStatus;
  }

  double get totalPrice {
    return _totalPrice;
  }

  String get tableNumber{
    return _tableNumber;
  }

  Order(
      {String? orderId,
      String restId = '',
      String userId = '',
     String orderStatus = '',
      double totalPrice = 0,
      String tableNumber = ''
      })
      : _orderId = orderId,
        _restId = restId,
        _userId = userId,
        _orderStatus = orderStatus,
        _totalPrice = totalPrice,
      _tableNumber = tableNumber;

  Order.fromJson(Map<String, dynamic> map)
      : _orderId = map['orderId'],
        _restId = map['restId'],
        _userId = map['userId'],
        _orderStatus = map['orderStatus'],
        _totalPrice = map['totalPrice'],
       _tableNumber = map['tableNumber'];

  Map<String, dynamic> toJson() {
    return {
      'orderId': _orderId,
      'restId': _restId,
      'userId': _userId,
      'orderStatus'  : _orderStatus,
      'totalPrice': _totalPrice,
     'tableNumber': _tableNumber
    };
  }

  Order copyWith(Map<String, dynamic> map) {
    return Order.fromJson(map);
  }
}

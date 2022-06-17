class OrderItem {
  String _orderItemId;
  String _menuId;
  int _quantity;
  String _orderId;

  String get orderItemId {
    return _orderItemId;
  }

  OrderItem(
      {String orderItemId = "",
      String menuId = '',
      int quantity = 0,
      String orderId = ""})
      : _orderItemId = orderItemId,
        _menuId = menuId,
        _quantity = quantity,
        _orderId = orderId;

  OrderItem.fromJson(Map<String, dynamic> map)
      : _orderItemId = map['orderItemId'],
        _menuId = map['menuId'],
        _quantity = map['quantity'],
        _orderId = map['orderId'];

  Map<String, dynamic> toJson() {
    return {
      'orderItemId': _orderItemId,
      'menuId': _menuId,
      'quantity': _quantity,
      'orderId': _orderId,
    };
  }

  OrderItem copyWith(Map<String, dynamic> map) {
    return OrderItem.fromJson(map);
  }
}

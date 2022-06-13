import 'package:provider/provider.dart';

class Menu {
  String _menuId, _restId;
  String _category, _foodDesc, _foodName, _foodPicture;
  double _foodPrice;

  String get menuId {
    return _menuId;
  }

  String get category {
    return _category;
  }

  String get foodDesc {
    return _foodDesc;
  }

  String get foodName {
    return _foodName;
  }

  double get foodPrice {
    return _foodPrice;
  }

  String get foodPicture {
    return _foodPicture;
  }

  String get restId {
    return _restId;
  }

  Menu(
      {String menuId = '',
      String category = '',
      String foodDesc = '',
      String foodName = '',
      double foodPrice = 0,
      String foodPicture = '',
      String restId = ''})
      : _menuId = menuId,
        _category = category,
        _foodDesc = foodDesc,
        _foodName = foodName,
        _foodPrice = foodPrice,
        _foodPicture = foodPicture,
        _restId = restId;

  Menu.fromJson(Map<String, dynamic> map)
      : _menuId = map['menuId'],
        _category = map['category'],
        _foodDesc = map['foodDesc'],
        _foodName = map['foodName'],
        _foodPrice = map['foodPrice'],
        _foodPicture = map['foodPicture'],
        _restId = map['restId'];

  Map<String, dynamic> toJson() {
    return {
      'menuId': _menuId,
      'foodName': _foodName,
      'foodDesc': _foodDesc,
      'foodPicture': _foodPicture,
      'foodPrice': _foodPrice,
      'category': _category,
      'restId': _restId,
    };
  }

  Menu copyWith(Map<String, dynamic> map) {
    return Menu.fromJson(map);
  }
}

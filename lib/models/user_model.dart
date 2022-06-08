// ignore_for_file: prefer_final_fields

class UserModel {
  dynamic _userId;
  String _name, _email, _role, _userPic;
  String? _restId;

  get role => _role;
  get restId => _restId;
  get name => _name;
  get email => _email;
  get userPic => _userPic;
  
  UserModel(
      {dynamic userId = "",
      String name = '',
      String email = '',
      String role = '',
      String? restId,
      String userPic=''})
      : _userId = userId,
        _name = name,
        _email = email,
        _role = role,
        _restId = restId,
        _userPic = userPic;

  UserModel.fromJson(Map<String, dynamic> map)
      : _userId = map['userId'],
        _email = map['email'],
        _name = map['name'],
        _role = map['role'],
        _restId = map['restId'],
        _userPic = map['userPic'];

  Map<String, dynamic> toJson() {
    return {
      'userId': _userId,
      'email': _email,
      'name': _name,
      'role': _role,
      'restId': _restId,
      'userPic': _userPic,
    };
  }
}

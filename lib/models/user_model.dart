class UserModel {
  dynamic _userId;
  String _name, _email, _role;
  String? _restId;

  //  UserModel(this._userId, this._email, this._name, this._role, this._restId);

 UserModel(
      {dynamic userId = "",
      String name = '',
      String email = '',
      String role = '',
      String? restId})
      : _userId = userId,
        _name = name,
        _email = email,
        _role = role,
        _restId = restId;

  UserModel.fromJson(Map<String, dynamic> map)
    :  _userId = map['userId'],
    _email = map['email'],
    _name = map['name'],
    _role = map['role'],
    _restId = map['restId'];
  
  // toJson() {
  // String? get restId {
  //   return _restId;
  // }

  // UserModel(
  //     {dynamic userId = "",
  //     String name = '',
  //     String email = '',
  //     String role = '',
  //     String? restId})
  //     : _userId = userId,
  //       _name = name,
  //       _email = email,
  //       _role = role,
  //       _restId = restId;

  Map<String, dynamic> toJson() {
    return {
      'userId': _userId,
      'email': _email,
      'name': _name,
      'role': _role,
      'restId': _restId,
    };
  }
  get role => _role;
  get restId => _restId;
}

  
//   set id(value) => _id = value;

//   get name => _name;
//   set name(value) => _name = value;

//   get photoUrl => _photoUrl;
//   set photoUrl(value) => _photoUrl = value;

//   get login => _login;
//   set login(value) => _login = value;

//   get password => _password;
//   set password(value) => _password = value;

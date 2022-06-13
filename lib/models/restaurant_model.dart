class Restaurant {
  dynamic _restId;
  String _restName,
      _restDesc,
      _restAddress,
      _restZipCode,
      _ssmNumber,
      _restPicture;
  bool _status;

  Restaurant(this._restId, this._ssmNumber, this._restName, this._restAddress,
      this._restZipCode, this._restDesc, this._restPicture, this._status);

  Restaurant.fromJson(Map<String, dynamic> map)
      : _restId = map['restId'],
        _ssmNumber = map['ssmNumber'],
        _restName = map['restName'],
        _restAddress = map['restAddress'],
        _restZipCode = map['restZipCode'],
        _restDesc = map['restDesc'],
        _restPicture = map['restPicture'],
        _status = map['status'];

  get restName {
    return _restName;
  }

  toJson() {
    return {
      'ssmNumber': _ssmNumber,
      'restName': _restName,
      'restAddress': _restAddress,
      'restZipCode': _restZipCode,
      'restDesc': _restDesc,
      'restPicture': _restPicture,
      'status': _status,
    };
  }

  get restStatus => _status;
  get restName => _restName;

}

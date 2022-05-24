class Restaurant {
  dynamic _restId;
  String _restName, _restDesc, _restPicture, _ssmNumber, _restAddress;
  bool _status;

  Restaurant(
      {dynamic restId = '',
      String ssmNumber = '',
      String restName = '',
      String restAddress = '',
      String restDesc = '',
      String restPicture = '',
      bool status = false})
      : _restId = restId,
        _ssmNumber = ssmNumber,
        _restName = restName,
        _restAddress = restAddress,
        _restDesc = restDesc,
        _restPicture = restPicture,
        _status = status;

  Restaurant.fromJson(Map<String, dynamic> map)
      : _restId = map['restId'],
        _ssmNumber = map['ssmNumber'],
        _restName = map['restName'],
        _restAddress = map['restAddress'],
        _restDesc = map['restDesc'],
        _restPicture = map['restPicture'],
        _status = map['status'];

  toJson() {
    return {
      _ssmNumber: 'ssmNumber',
      _restId: 'restId',
      _restName: 'restName',
      _restAddress: 'restAddress',
      _restDesc: 'restDesc',
      _restPicture: 'restPicture',
      _status: 'status',
    };
  }
}


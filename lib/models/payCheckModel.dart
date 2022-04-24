class payCheckModel
{
  String uid;
  String owneruid;
  String payCheckDate;
  String payCheckUrl;

  payCheckModel({required this.uid,required this.owneruid,required this.payCheckDate,required this.payCheckUrl});

  // data from server
  factory payCheckModel.fromMap(map)
  {
    return payCheckModel(
        uid:map['uid'],
        payCheckUrl: map['payCheckUrl'],
        payCheckDate: map['payCheckDate'],
        owneruid: map['owneruid']
    );
  }

// send data to server
  Map<String,dynamic> toMap()
  {
    return
      {
        'uid':uid,
        'payCheckUrl':payCheckUrl,
        'payCheckDate':payCheckDate,
        'owneruid':owneruid


      };
  }
}
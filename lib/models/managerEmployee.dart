class managerModel
{
  String uid;
  String id;
  String? email;
  String firstName;
  String lastName;
  String type;

  managerModel({required this.id,required this.uid,required this.email,required this.firstName,required this.lastName, required this.type});

  // data from server
  factory managerModel.fromMap(map)
  {
    return managerModel(
        uid:map['uid'],
        email: map['email'],
        firstName: map['firstname'],
        lastName: map['secondname'],
        type: map['type'],
         id: map['id']
    );
  }

// send data to server
  Map<String,dynamic> toMap()
  {
    return
      {
        'uid':id,
        'uid':uid,
        'email':email,
        'firstname':firstName,
        'lastname': lastName,
        'type':type,

      };
  }
}
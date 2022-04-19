class employeeModel
{
  String uid;
  String? email;
  String firstName;
  String lastName;
  String type;
  String manager;

  employeeModel({required this.uid,required this.email,required this.firstName,required this.lastName, required this.type, required this.manager});

  // data from server
  factory employeeModel.fromMap(map)
  {
    return employeeModel(
        uid:map['uid'],
        email: map['email'],
        firstName: map['firstName'],
        lastName: map['secondName'],
        type: map['type'],
        manager: map['manager']
    );
  }

// send data to server
  Map<String,dynamic> toMap()
  {
    return
      {
        'uid':uid,
        'email':email,
        'firstName':firstName,
        'lastName': lastName,
        'type':type,
        'manager':manager
      };
  }
}
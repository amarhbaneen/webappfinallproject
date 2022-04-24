import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ionicons/ionicons.dart';
import 'package:webappfinallproject/models/employeeModel.dart';

class addEmployee extends StatefulWidget {
  PageController page = PageController();
  addEmployee(this.page);

  @override
  _addEmployeeState createState() => _addEmployeeState();
}

class _addEmployeeState extends State<addEmployee> {
  late String email;
  late String password;
  late String name , lname;
  late String Id;
  var manager;


  bool _obscureText = true;
  final _formkey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/3),
        child: Form(
          key: _formkey,
          child: ListView(
            children: <Widget>[
              Padding(padding: const EdgeInsets.only(top: 10)),
              Padding(
                padding: const EdgeInsets.all(2),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => name = value,
                  decoration: InputDecoration(
                    labelText: "Enter Your First Name",
                    icon: Icon(Icons.person),
                  ),
                ),
              ),
              Padding(padding: const EdgeInsets.only(top: 10)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => lname = value,
                  decoration: InputDecoration(
                    labelText: "Enter Last Name",
                    icon: Icon(Icons.person),
                  ),
                ),
              ),
              Padding(padding: const EdgeInsets.only(top: 10)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => email = value,
                  decoration: InputDecoration(
                    labelText: "Enter  Email",
                    icon: Icon(Icons.email),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) => Id = value,
                  decoration: InputDecoration(
                    labelText: "Enter Manager ID",
                    icon: Icon(Icons.call),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  autocorrect: false,
                  obscureText: _obscureText,
                  onChanged: (value) => password = value,
                  decoration: InputDecoration(
                    labelText: "Enter Password",
                    icon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color: Theme
                            .of(context)
                            .primaryColorLight,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  autocorrect: false,
                  obscureText: _obscureText,
                  onChanged: (value) => password = value,
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    icon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color: Theme
                            .of(context)
                            .primaryColorLight,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Padding(padding:const EdgeInsets.all(9.0),
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('users').where('type', isEqualTo: 'manager').snapshots(),
                  builder: (context,snapshot)
                  {
                    List<DropdownMenuItem>  managersName =[];
                    if(!snapshot.hasData)
                    {
                      Text('Loading .. ');
                    }
                    else{

                      for (int i=0;i<snapshot.data!.docs.length;i++)
                      {
                        DocumentSnapshot doc = snapshot.data!.docs[i];
                        managersName.add(
                          DropdownMenuItem(child: Text(doc['firstname']),
                            value: '${doc['firstname']}',
                          ),

                        );
                      }

                    }
                    return Row(
                      mainAxisAlignment:  MainAxisAlignment.center,
                      children: [
                        Icon(Ionicons.person),
                        SizedBox(width: 10),
                        DropdownButton<dynamic>(items: managersName, onChanged: (managervalue) {
                          setState(() {
                            manager = managervalue;
                          });
                        },
                          value: manager,
                          isExpanded: false,
                          hint: const Text('choose manager of the employee'),
                        ),

                      ],
                    );
                  },
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Expanded(
                    child: ElevatedButton(onPressed: () {
                      register(email, password);
                      widget.page.jumpTo(0);
                    }, child: Text('Register Employee'),
                      style: ElevatedButton.styleFrom(
                        onPrimary: Colors.white,
                        primary: Colors.black,
                        minimumSize: Size(30,50),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),

                      ),
                    ),
                  )),

            ],
          ),
        ),
      ),

    );
  }

  postDetailsToFirestore(createdUser) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    employeeModel userModel = employeeModel(
        uid: createdUser,
        email: email,
        firstName: name,
        lastName: lname,
        type: 'employee',
        id: Id, manager: ''
    );

    // writing all the values

    await firebaseFirestore
        .collection("users")
        .doc(userModel.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");
  }

  Future<void> register(String email, String password) async {
    var CreatedUser;
    late String errorMessage;
    FirebaseApp app = await Firebase.initializeApp(
        name: 'Secondary', options: Firebase
        .app()
        .options);

    var auth = FirebaseAuth.instanceFor(app: app);
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) =>
      {
        CreatedUser = auth.currentUser?.uid,
        postDetailsToFirestore(CreatedUser)
      })
          .catchError((e) {
        Fluttertoast.showToast(msg: e.message);
      });
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      Fluttertoast.showToast(msg: errorMessage);


    }
    await app.delete();
  }


}




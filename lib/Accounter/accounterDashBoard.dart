import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'package:webappfinallproject/Accounter/paycheckScreen.dart';

class AccountDashboard extends StatefulWidget {
  const AccountDashboard({Key? key}) : super(key: key);

  @override
  State<AccountDashboard> createState() => _AccountDashboardState();
}

class _AccountDashboardState extends State<AccountDashboard> {
  PageController page = PageController();
  late int employeeNumber = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DashBoard'),
        centerTitle: true,
        backgroundColor: Colors.black,
        bottom: PreferredSize(
            child: Container(
              color: Colors.grey,
              height: 4.0,
            ),
            preferredSize: Size.fromHeight(4.0)),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SideMenu(
            controller: page,
            style: SideMenuStyle(
                displayMode: SideMenuDisplayMode.auto,
                hoverColor: Colors.blue[100],
                selectedColor: Colors.black,
                selectedTitleTextStyle: TextStyle(color: Colors.white),
                selectedIconColor: Colors.white,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 5.0)),
                backgroundColor: Colors.white),
            title: Column(
              children: [],
            ),
            footer: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Accounter Dashboard',
                style: TextStyle(fontSize: 15),
              ),
            ),
            items: [
              SideMenuItem(
                priority: 0,
                title: 'Dashboard',
                onTap: () {
                  page.jumpToPage(0);
                },
                icon: Icon(Icons.home),
                badgeContent: Text(
                  '3',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SideMenuItem(
                priority: 1,
                title: 'PayCheck',
                onTap: () {
                  page.jumpToPage(1);
                },
                icon: Icon(Icons.file_copy_rounded),
              ),
              SideMenuItem(
                priority: 2,
                title: 'Files',
                onTap: () {
                  page.jumpToPage(2);
                },
                icon: Icon(Icons.file_copy_rounded),
              ),
              SideMenuItem(
                priority: 3,
                title: 'Download',
                onTap: () {
                  page.jumpToPage(3);
                },
                icon: Icon(Icons.download),
              ),
              SideMenuItem(
                priority: 4,
                title: 'Settings',
                onTap: () {
                  page.jumpToPage(4);
                },
                icon: Icon(Icons.settings),
              ),
              SideMenuItem(
                priority: 6,
                title: 'Exit',
                onTap: () async {},
                icon: Icon(Icons.exit_to_app),
              ),
            ],
          ),
          Expanded(
            child: PageView(
              controller: page,
              children: [
                Row(children: [
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Expanded(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: 1000,
                            maxWidth: 500,
                          ),
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black, width: 5.0)),
                              child: buildEmployee()),
                        ),
                      ),
                      Expanded(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: 1000,
                            maxWidth: 500,
                          ),
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black, width: 5.0)),
                              child: buildManagerList()),
                        ),
                      ),
                    ],
                  ),

                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 5.0)),
                      child: Expanded(
                        child: Column(
                          children: [
                            DigitalClock(
                              areaDecoration: BoxDecoration(color: Colors.transparent),
                              areaAligment: AlignmentDirectional.topCenter,
                              hourMinuteDigitDecoration:
                              BoxDecoration(color: Colors.transparent),
                              hourMinuteDigitTextStyle: TextStyle(fontSize: 100),
                              secondDigitTextStyle: TextStyle(fontSize: 50),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
                Container(
                  color: Colors.white,
                  child: Center(
                    child: pyacheck()
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      'Files',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      'Download',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      'Settings',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildEmployee() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employees'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where("type", isEqualTo: 'employee')
            .snapshots(),
        builder: (context, snapshot) {
          return Column(children: [
            snapshot.hasData
                ? Expanded(
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return Column(children: [
                      InkWell(
                          onTap: () {},
                          child: Card(
                            elevation: 5,
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Text((snapshot.data?.docs[index]
                                ['firstName'][0])
                                    .toUpperCase()),
                                backgroundColor: Colors.black,
                                radius: 24,
                              ),
                              trailing: MaterialButton(
                                  onPressed: () {
                                    String? uid = snapshot
                                        .data?.docs[index].id
                                        .toString();
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(uid)
                                        .delete();
                                  },
                                  child: Text(
                                    "remove",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: Colors.black),
                              title: Text(
                                snapshot.data?.docs[index]['firstName'],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                  snapshot.data?.docs[index]['lastName'],
                                  style:
                                  TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          )),
                    ]);
                  },
                  itemCount: snapshot.data!.docs.length,
                ))
                : Center(
              child: CupertinoActivityIndicator(),
            )
          ]);
        },
      ),
    );
  }

  Widget buildManagerList() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Managers'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where("type", isEqualTo: 'manager')
            .snapshots(),
        builder: (context, snapshot) {
          return Column(children: [
            snapshot.hasData
                ? Expanded(
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return Column(children: [
                      InkWell(
                          onTap: () {},
                          child: Card(
                            elevation: 5,
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Text((snapshot.data?.docs[index]
                                ['firstname'][0])
                                    .toUpperCase()),
                                backgroundColor: Colors.black,
                                radius: 24,
                              ),
                              trailing: MaterialButton(
                                  onPressed: () {
                                    String? uid = snapshot
                                        .data?.docs[index].id
                                        .toString();
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(uid)
                                        .delete();
                                  },
                                  child: Text(
                                    "remove",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: Colors.black),
                              title: Text(
                                snapshot.data?.docs[index]['firstname'],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                  snapshot.data?.docs[index]['lastname'],
                                  style:
                                  TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          )),
                    ]);
                  },
                  itemCount: snapshot.data!.docs.length,
                ))
                : Center(
              child: CupertinoActivityIndicator(),
            )
          ]);
        },
      ),
    );
  }
}

import 'package:api_with_provider/user_component.dart';
import 'package:api_with_provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'user_model.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<UserProvider>(context, listen: false).getUsers(context);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context, listen: false);

    debugPrint('users screen');
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          provider.getUsers(context);
        },
        child: Consumer<UserProvider>(
          builder: (context, value, child) {
            return value.isLoading
                // show loading while the data is being fetched
                ? Center(child: CircularProgressIndicator())
                : Center(
                    child: value.users.isEmpty
                        // if there is no data in the list, show it
                        // using listview because the RefreshIndicator widget works in listview
                        ? ListView(
                            children: [
                              Center(
                                child: Text(
                                  'No Data',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          )
                        // show the users when the data is fetched successfully
                        : ListView.builder(
                            itemCount: value.users.length,
                            itemBuilder: (context, index) {
                              UserModel user = value.users[index];
                              return UserComponent(user: user);
                            },
                          ),
                  );
          },
        ),
      ),
    );
  }
}

// import 'dart:convert';
// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http2;
//
// import '../../user_model.dart';
//
// class Users extends StatefulWidget {
//   const Users({super.key});
//
//   @override
//   State<Users> createState() => _UsersState();
// }
//
// class _UsersState extends State<Users> {
//   List<UserModel> users = [];
//   bool _isLoading = false;
//   Future<void> getUsers() async {
//     users = [];
//     setState(() {
//       _isLoading = true;
//     });
//     var response = await http2
//         .get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
//     if (response.statusCode == 200) {
//       print('success');
//       setState(() {
//         _isLoading = false;
//       });
//       var data = jsonDecode(response.body.toString());
//       for (var i in data) {
//         users.add(UserModel.fromJson(i));
//       }
//     } else {
//       print('error');
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getUsers();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           Random().nextInt(100).toString(),
//           style: TextStyle(fontSize: 30),
//         ),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : Center(
//               child: ListView.builder(
//                   itemCount: users.length,
//                   itemBuilder: (context, index) {
//                     UserModel user = users[index];
//                     return Padding(
//                       padding: EdgeInsets.symmetric(vertical: 8.0),
//                       child: Card(
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 16.0),
//                           child: Column(
//                             children: [
//                               MyRow(
//                                   title: 'Name:',
//                                   subtitle: user.name ?? "No name"),
//                               MyRow(
//                                   title: 'Username:',
//                                   subtitle: user.username ?? "No username"),
//                               MyRow(
//                                   title: 'Email:',
//                                   subtitle: user.email ?? "noemail@gmail.com"),
//                               MyRow(
//                                   title: 'Address:',
//                                   subtitle:
//                                       "Suite: ${user.address!.suite}, Street ${user.address!.street}, City: ${user.address!.city}"),
//                               MyRow(
//                                   title: 'Phone: ',
//                                   subtitle: user.phone ?? "No phone"),
//                               MyRow(
//                                   title: 'Website: ',
//                                   subtitle: user.website ?? "No website"),
//                               MyRow(
//                                   title: 'Company: ',
//                                   subtitle: user.company!.name ?? "No company")
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   })),
//     );
//   }
// }
//
// class MyRow extends StatelessWidget {
//   final String title, subtitle;
//   MyRow({super.key, required this.title, required this.subtitle});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         children: [
//           Text(title),
//           SizedBox(
//             width: 8,
//           ),
//           Expanded(
//               child: Text(
//             subtitle,
//             textAlign: TextAlign.end,
//           )),
//         ],
//       ),
//     );
//   }
// }

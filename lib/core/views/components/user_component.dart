import 'package:api_with_provider/core/models/user_model.dart';
import 'package:flutter/material.dart';

class UserComponent extends StatelessWidget {
  const UserComponent({
    super.key,
    required this.user,
  });

  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              // name
              MyRow(title: 'Name:', subtitle: user.name ?? "No name"),
              // username
              MyRow(
                  title: 'Username:', subtitle: user.username ?? "No username"),
              // email
              MyRow(
                  title: 'Email:', subtitle: user.email ?? "noemail@gmail.com"),
              // address
              MyRow(
                  title: 'Address:',
                  subtitle:
                      "Suite: ${user.address!.suite}, Street ${user.address!.street}, City: ${user.address!.city}"),
              // phone
              MyRow(title: 'Phone: ', subtitle: user.phone ?? "No phone"),
              // website
              MyRow(title: 'Website: ', subtitle: user.website ?? "No website"),
              // company
              MyRow(
                  title: 'Company: ',
                  subtitle: user.company!.name ?? "No company")
            ],
          ),
        ),
      ),
    );
  }
}

class MyRow extends StatelessWidget {
  final String title, subtitle;

  MyRow({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(title),
          SizedBox(
            width: 8,
          ),
          Expanded(
              child: Text(
            subtitle,
            textAlign: TextAlign.end,
          )),
        ],
      ),
    );
  }
}

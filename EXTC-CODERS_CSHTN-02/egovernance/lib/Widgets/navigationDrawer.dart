import 'package:egovernance/Widgets/navigationDrawerBodyItem.dart';
import 'package:egovernance/Widgets/navigationDrawerHeader.dart';
import 'package:flutter/material.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          navigationDrawerHeader(),
          navigationDrawerBodyItem(
              icon: Icons.enhanced_encryption_outlined,text: 'Wallet'),
          navigationDrawerBodyItem(
              icon: Icons.account_circle,text: 'Profile'),

          navigationDrawerBodyItem(
              icon: Icons.event_note,text: 'Events'),
          Divider(),
          navigationDrawerBodyItem(
              icon: Icons.notifications_active,text: 'Notifications'),
          navigationDrawerBodyItem(
              icon: Icons.contact_phone,text: 'Contact Info'),
          ListTile(
            title: Text('App version 1.0.0'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
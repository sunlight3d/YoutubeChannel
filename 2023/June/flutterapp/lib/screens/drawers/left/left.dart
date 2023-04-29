import 'package:flutter/material.dart';

import '../../settings/settings.dart';

class LeftDrawer extends StatefulWidget {
  @override
  _LeftDrawerState createState() => _LeftDrawerState();
}

class _LeftDrawerState extends State<LeftDrawer> {
  int _selectedIndex = 0;

  final List<DrawerItem> _drawerItems = [
    DrawerItem(Icons.attach_money, 'Price board'),
    DrawerItem(Icons.star, 'Watch list'),
    DrawerItem(Icons.business, 'Industry'),
    DrawerItem(Icons.trending_up, 'Top stocks'),
    DrawerItem(Icons.notifications, 'Notification'),
    DrawerItem(Icons.bar_chart, 'Equities Trading'),
    DrawerItem(Icons.timeline, 'Derivatives Trading'),
    DrawerItem(Icons.shopping_cart, 'Right Trading'),
    DrawerItem(Icons.person_outline, 'S-Products'),
    DrawerItem(Icons.account_balance_wallet, 'Cash Transaction'),
    DrawerItem(Icons.account_balance, 'Assets Management'),
    DrawerItem(Icons.person, 'Account Management'),
    DrawerItem(Icons.add_box, 'Abc Plus'),
    DrawerItem(Icons.settings, 'Settings'),
    DrawerItem(Icons.contact_mail, 'Contact'),
  ];

  void _selectDrawerItem(int index) {
    if(index == 13) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SettingsScreen()),
      );
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('images/logo.png', height: 50),
                    SizedBox(width: 10),
                    Text(
                      'Welcome to my App',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Login'),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        side: BorderSide(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                    )),
                    SizedBox(width: 20,),
                    Expanded(child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Login'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        side: BorderSide(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                    ),)
                  ],
                )
              ],
            ),
          ),
          _buildDrawerItem(_drawerItems[0], 0),
          _buildDrawerItem(_drawerItems[1], 1),
          _buildDrawerItem(_drawerItems[2], 2),
          _buildDrawerItem(_drawerItems[3], 3),
          _buildDrawerItem(_drawerItems[4], 4),
          SizedBox(height: 10),
          Divider(height: 1, color: Colors.grey),
          _buildDrawerItem(_drawerItems[5], 5),
          _buildDrawerItem(_drawerItems[6], 6),
          _buildDrawerItem(_drawerItems[7], 7),
          _buildDrawerItem(_drawerItems[8], 8),
          _buildDrawerItem(_drawerItems[9], 9),
          _buildDrawerItem(_drawerItems[10], 10),
          _buildDrawerItem(_drawerItems[11], 11),
          SizedBox(height: 10),
          Divider(height: 1, color: Colors.grey),
          _buildDrawerItem(_drawerItems[12], 12),
          _buildDrawerItem(_drawerItems[13], 13),
          _buildDrawerItem(_drawerItems[14], 14),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(DrawerItem item, int index) {
    return InkWell(
      onTap: () => _selectDrawerItem(index),
      child: Container(
        color: index == _selectedIndex ? Colors.green[100] : null,
        child: ListTile(
          leading: Icon(item.icon),
          title: Text(
            item.title,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}

class DrawerItem {
  final IconData icon;
  final String title;
  const DrawerItem(this.icon, this.title);
}
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _orderConfirmation = true;
  bool _authenticateWithFingerprint = false;
  bool _orderCondition = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          _buildSectionHeader('General'),
          _buildListTile('Language', 'English', Icons.arrow_forward_ios),
          _buildListTile('Theme', 'Light', Icons.arrow_forward_ios),
          _buildSwitchListTile(
            'Order Confirmation',
            _orderConfirmation,
                (value) => setState(() => _orderConfirmation = value),
          ),
          _buildListTile('Notification', '', Icons.arrow_forward_ios),
          _buildSectionHeader('Security'),
          _buildListTile('Two factors authentication', '', Icons.arrow_forward_ios),
          _buildListTile('Smart OTP', '', Icons.arrow_forward_ios),
          _buildSwitchListTile(
            'Authenticate with Fingerprint',
            _authenticateWithFingerprint,
                (value) => setState(() => _authenticateWithFingerprint = value),
          ),
          _buildSectionHeader('Display'),
          _buildListTile('Format', '', Icons.arrow_forward_ios),
          _buildListTile('Index Quick Bar', '', Icons.arrow_forward_ios),
          _buildSwitchListTile(
            'Order Condition',
            _orderCondition,
                (value) => setState(() => _orderCondition = value),
          ),
          _buildSectionHeader('About this App'),
          _buildListTile('Rate us', '', Icons.arrow_forward_ios),
          _buildListTile('Privacy & Disclaimer', '', Icons.arrow_forward_ios),
          _buildListTile('App Version', '', Icons.arrow_forward_ios),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      color: Colors.grey[200],
      padding: const EdgeInsets.all(16.0),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18.0,
        ),
      ),
    );
  }

  Widget _buildListTile(String title, String subtitle, IconData icon) {
    return InkWell(
      onTap: () => print('Tapped $title'),
      child: Container(
        color: Colors.white,
        child: ListTile(
          title: Text(title),
          subtitle: Text(subtitle),
          trailing: Icon(icon),
        ),
      ),
    );
  }

  Widget _buildSwitchListTile(
      String title,
      bool value,
      void Function(bool) onChanged,
      ) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }
}

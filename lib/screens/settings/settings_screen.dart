import 'package:flutter/material.dart';
import 'package:her_rides_user/theme/theme_provider.dart'; // Import ThemeProvider
import 'package:provider/provider.dart'; // Import provider package

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false; // To manage dark mode state

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context); // Access ThemeProvider

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor, // Use theme's background color
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor, // Use theme's app bar color
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).appBarTheme.iconTheme?.color), // Use theme's icon color
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Settings',
          style: Theme.of(context).appBarTheme.titleTextStyle, // Use theme's title style
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: OutlinedButton.icon(
              onPressed: () {
                // Help functionality
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Theme.of(context).textTheme.bodyLarge?.color, // Use theme's text color
                side: BorderSide(color: Theme.of(context).dividerColor), // Use theme's divider color
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              icon: Icon(Icons.help_outline, size: 18, color: Theme.of(context).iconTheme.color), // Use theme's icon color
              label: Text('Help', style: TextStyle(fontSize: 14, color: Theme.of(context).textTheme.bodyLarge?.color)), // Use theme's text color
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // General Section
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'GENERAL',
              style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color, fontWeight: FontWeight.bold, fontSize: 13), // Use theme's text color
            ),
          ),
          Card(
            margin: EdgeInsets.zero,
            elevation: 0.5,
            color: Theme.of(context).cardTheme.color, // Use theme's card color
            shape: Theme.of(context).cardTheme.shape, // Use theme's card shape
            child: Column(
              children: [
                _SettingsListItem(
                  icon: Icons.person_outline,
                  title: 'Profile',
                  subtitle: '+91 9737611429',
                  onTap: () {},
                  textColor: Theme.of(context).textTheme.bodyLarge?.color, // Use theme's text color
                  iconColor: Theme.of(context).iconTheme.color, // Use theme's icon color
                ),
                _SettingsListItem(
                  icon: Icons.favorite_border,
                  title: 'Favourites',
                  subtitle: 'Manage favourite locations',
                  onTap: () {},
                  textColor: Theme.of(context).textTheme.bodyLarge?.color,
                  iconColor: Theme.of(context).iconTheme.color,
                ),
                _SettingsListItem(
                  icon: Icons.tune,
                  title: 'Preferences',
                  subtitle: 'Manage preferences',
                  onTap: () {},
                  textColor: Theme.of(context).textTheme.bodyLarge?.color,
                  iconColor: Theme.of(context).iconTheme.color,
                ),
                _SettingsListItem(
                  icon: Icons.tablet_mac,
                  title: 'App shortcuts',
                  subtitle: 'Create shortcuts on home launcher',
                  isLast: true, // No divider after this item
                  onTap: () {},
                  textColor: Theme.of(context).textTheme.bodyLarge?.color,
                  iconColor: Theme.of(context).iconTheme.color,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Dark Mode Toggle
          Card(
            margin: EdgeInsets.zero,
            elevation: 0.5,
            color: Theme.of(context).cardTheme.color,
            shape: Theme.of(context).cardTheme.shape,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.dark_mode_outlined, color: Theme.of(context).iconTheme.color), // Use theme's icon color
                      const SizedBox(width: 16),
                      Text(
                        'Dark Mode',
                        style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.bodyLarge?.color), // Use theme's text color
                      ),
                    ],
                  ),
                  Switch(
                    value: themeProvider.themeMode == ThemeMode.dark, // Use themeProvider's state
                    onChanged: (value) {
                      themeProvider.toggleTheme(); // Toggle theme using provider
                    },
                    activeColor: Colors.pink,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Others Section
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'OTHERS',
              style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color, fontWeight: FontWeight.bold, fontSize: 13), // Use theme's text color
            ),
          ),
          Card(
            margin: EdgeInsets.zero,
            elevation: 0.5,
            color: Theme.of(context).cardTheme.color,
            shape: Theme.of(context).cardTheme.shape,
            child: Column(
              children: [
                _SettingsListItem(
                  icon: Icons.info_outline,
                  title: 'About',
                  subtitle: '8.62.0',
                  onTap: () {},
                  textColor: Theme.of(context).textTheme.bodyLarge?.color,
                  iconColor: Theme.of(context).iconTheme.color,
                ),
                _SettingsListItem(
                  icon: Icons.rocket_launch_outlined,
                  title: 'Subscribe to Beta',
                  subtitle: 'Get early access to latest features',
                  onTap: () {},
                  textColor: Theme.of(context).textTheme.bodyLarge?.color,
                  iconColor: Theme.of(context).iconTheme.color,
                ),
                _SettingsListItem(
                  icon: Icons.logout,
                  title: 'Logout',
                  onTap: () {},
                  textColor: Theme.of(context).textTheme.bodyLarge?.color,
                  iconColor: Theme.of(context).iconTheme.color,
                ),
                _SettingsListItem(
                  icon: Icons.delete_outline,
                  title: 'Delete Account',
                  textColor: Colors.red, // Red color for delete account
                  iconColor: Colors.red, // Red color for icon
                  isLast: true,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsListItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final Color? textColor; // Made nullable to use theme default
  final Color? iconColor; // Made nullable to use theme default
  final bool isLast;

  const _SettingsListItem({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
    this.textColor,
    this.iconColor,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: iconColor ?? Theme.of(context).iconTheme.color), // Use default theme color if null
          title: Text(
            title,
            style: TextStyle(fontSize: 16, color: textColor ?? Theme.of(context).textTheme.bodyLarge?.color), // Use default theme color if null
          ),
          subtitle: subtitle != null
              ? Text(
                  subtitle!,
                  style: TextStyle(fontSize: 13, color: Theme.of(context).textTheme.bodySmall?.color), // Use theme's text color
                )
              : null,
          trailing: Icon(Icons.arrow_forward_ios, color: Theme.of(context).iconTheme.color, size: 16), // Use theme's icon color
          onTap: onTap,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        ),
        if (!isLast)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(color: Theme.of(context).dividerColor, height: 0.5), // Use theme's divider color
          ),
      ],
    );
  }
} 
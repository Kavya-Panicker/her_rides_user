import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:her_rides_user/screens/settings/settings_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  // Dummy user data for the drawer
  final String userName = "Kavya Panicker";
  final String userNumber = "9737611429";
  final String userRating = "5.00 My Rating";

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width, // Make drawer full width
      backgroundColor: Theme.of(context).scaffoldBackgroundColor, // Use theme's background color
      child: Column(
        children: [
          // Top navigation bar
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 10,
              bottom: 10,
              left: 16,
              right: 16,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).appBarTheme.backgroundColor, // Use theme's app bar color
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.grey.withOpacity(0.2)
                      : Colors.black.withOpacity(0.5), // Adjust shadow for dark mode
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color), // Use theme's icon color
                  onPressed: () => Navigator.pop(context),
                ),
                SizedBox(width: 8),
                Text(
                  'Menu',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.titleLarge?.color, // Use theme's title color
                  ),
                ),
              ],
            ),
          ),
          // User info section with padding
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.pink.withOpacity(0.1)
                    : Colors.grey.shade800, // Adjust color for dark mode
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.person, color: Theme.of(context).iconTheme.color, size: 30), // Use theme's icon color
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userName,
                            style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color, fontSize: 18, fontWeight: FontWeight.bold), // Use theme's text color
                          ),
                          Text(
                            userNumber,
                            style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color, fontSize: 14), // Use theme's text color
                          ),
                        ],
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios, color: Theme.of(context).iconTheme.color, size: 16), // Use theme's icon color
                    ],
                  ),
                  Divider(color: Theme.of(context).dividerColor, height: 20, thickness: 1), // Use theme's divider color
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 20), // Amber color for star can remain constant
                      SizedBox(width: 8),
                      Text(
                        userRating,
                        style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color, fontSize: 16), // Use theme's text color
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios, color: Theme.of(context).iconTheme.color, size: 16), // Use theme's icon color
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Scrollable menu items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                _DrawerItem(icon: Icons.help_outline, text: 'Help', onTap: () {},
                  textColor: Theme.of(context).textTheme.bodyLarge?.color,
                  iconColor: Theme.of(context).iconTheme.color,),
                _DrawerItem(icon: Icons.card_giftcard, text: 'Parcel - Send Items', onTap: () {},
                  textColor: Theme.of(context).textTheme.bodyLarge?.color,
                  iconColor: Theme.of(context).iconTheme.color,),
                _DrawerItem(icon: Icons.payment, text: 'Payment', onTap: () {},
                  textColor: Theme.of(context).textTheme.bodyLarge?.color,
                  iconColor: Theme.of(context).iconTheme.color,),
                _DrawerItem(icon: Icons.history, text: 'My Rides', onTap: () {},
                  textColor: Theme.of(context).textTheme.bodyLarge?.color,
                  iconColor: Theme.of(context).iconTheme.color,),
                _DrawerItem(icon: Icons.security, text: 'Safety', onTap: () {},
                  textColor: Theme.of(context).textTheme.bodyLarge?.color,
                  iconColor: Theme.of(context).iconTheme.color,),
                _DrawerItem(icon: FontAwesomeIcons.gift, text: 'Refer and Earn', subtitle: 'Get ₹50', onTap: () {},
                  textColor: Theme.of(context).textTheme.bodyLarge?.color,
                  iconColor: Theme.of(context).iconTheme.color,),
                _DrawerItem(icon: Icons.emoji_events, text: 'My Rewards', onTap: () {},
                  textColor: Theme.of(context).textTheme.bodyLarge?.color,
                  iconColor: Theme.of(context).iconTheme.color,),
                _DrawerItem(icon: Icons.card_membership, text: 'Power Pass', onTap: () {},
                  textColor: Theme.of(context).textTheme.bodyLarge?.color,
                  iconColor: Theme.of(context).iconTheme.color,),
                _DrawerItem(icon: FontAwesomeIcons.coins, text: 'Rapido Coins', onTap: () {},
                  textColor: Theme.of(context).textTheme.bodyLarge?.color,
                  iconColor: Theme.of(context).iconTheme.color,),
                _DrawerItem(icon: Icons.notifications, text: 'Notifications', onTap: () {},
                  textColor: Theme.of(context).textTheme.bodyLarge?.color,
                  iconColor: Theme.of(context).iconTheme.color,),
                _DrawerItem(icon: Icons.assignment, text: 'Claims', onTap: () {},
                  textColor: Theme.of(context).textTheme.bodyLarge?.color,
                  iconColor: Theme.of(context).iconTheme.color,),
                _DrawerItem(icon: Icons.settings, text: 'Settings', onTap: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SettingsScreen()),
                  );
                },
                  textColor: Theme.of(context).textTheme.bodyLarge?.color,
                  iconColor: Theme.of(context).iconTheme.color,),
              ],
            ),
          ),
          // Bottom padding
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

// Reusable widget for Drawer items
class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final String? subtitle;
  final VoidCallback? onTap;
  final Color? textColor;
  final Color? iconColor;

  const _DrawerItem({
    required this.icon,
    required this.text,
    this.subtitle,
    this.onTap,
    this.textColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: iconColor ?? Theme.of(context).iconTheme.color), // Pink icon
          title: Text(
            text,
            style: TextStyle(color: textColor ?? Theme.of(context).textTheme.bodyLarge?.color, fontSize: 16),
          ),
          subtitle: subtitle != null
              ? Text(
                  subtitle!,
                  style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color, fontSize: 12),
                )
              : null,
          trailing: Icon(Icons.arrow_forward_ios, color: Theme.of(context).iconTheme.color, size: 16),
          onTap: onTap, // Use the provided onTap callback
        ),
        Divider(color: Theme.of(context).dividerColor, height: 0, indent: 16, endIndent: 16), // Separator line
      ],
    );
  }
} 
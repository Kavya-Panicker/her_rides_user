import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      backgroundColor: Colors.white,
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
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.pink),
                  onPressed: () => Navigator.pop(context),
                ),
                SizedBox(width: 8),
                Text(
                  'Menu',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink,
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
                color: Colors.pink.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.person, color: Colors.pink, size: 30),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userName,
                            style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            userNumber,
                            style: TextStyle(color: Colors.grey[700], fontSize: 14),
                          ),
                        ],
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
                    ],
                  ),
                  Divider(color: Colors.grey[300], height: 20, thickness: 1),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      SizedBox(width: 8),
                      Text(
                        userRating,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
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
                _DrawerItem(icon: Icons.help_outline, text: 'Help'),
                _DrawerItem(icon: Icons.card_giftcard, text: 'Parcel - Send Items'),
                _DrawerItem(icon: Icons.payment, text: 'Payment'),
                _DrawerItem(icon: Icons.history, text: 'My Rides'),
                _DrawerItem(icon: Icons.security, text: 'Safety'),
                _DrawerItem(icon: FontAwesomeIcons.gift, text: 'Refer and Earn', subtitle: 'Get ₹50'),
                _DrawerItem(icon: Icons.emoji_events, text: 'My Rewards'),
                _DrawerItem(icon: Icons.card_membership, text: 'Power Pass'),
                _DrawerItem(icon: FontAwesomeIcons.coins, text: 'Rapido Coins'),
                _DrawerItem(icon: Icons.notifications, text: 'Notifications'),
                _DrawerItem(icon: Icons.assignment, text: 'Claims'),
                _DrawerItem(icon: Icons.settings, text: 'Settings'),
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

  const _DrawerItem({
    required this.icon,
    required this.text,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.pink), // Pink icon
          title: Text(
            text,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          subtitle: subtitle != null
              ? Text(
                  subtitle!,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                )
              : null,
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
          onTap: () {
            // Handle item tap (e.g., navigate to a new page)
            Navigator.pop(context); // Close the drawer
          },
        ),
        Divider(color: Colors.grey[200], height: 0, indent: 16, endIndent: 16), // Separator line
      ],
    );
  }
} 
import 'package:flutter/material.dart';
import 'package:her_rides_user/screens/services/services_tab.dart';
import 'package:her_rides_user/screens/notification/notification_tab.dart';
import 'package:her_rides_user/screens/profile/profile_tab.dart';
import 'package:her_rides_user/screens/address_selection/address_selection_modal.dart';
import 'package:her_rides_user/screens/address_selection/available_rides_modal.dart';
import 'package:her_rides_user/widgets/app_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Corrected import
import 'package:her_rides_user/screens/activity/activity_screen.dart'; // New import for ActivityScreen

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  int _toggleIndex = 0; // 0: Transport, 1: Delivery

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Dummy user data for the drawer
  final String userName = "Kavya Panicker";
  final String userNumber = "9737611429";
  final String userRating = "5.00 My Rating";

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return Stack(
          children: [
            // Map Placeholder
            Positioned.fill(
              child: Container(
                color: Theme.of(context).colorScheme.surface, // Use theme's surface color
              ),
            ),
            // Top bar
            Positioned(
              top: 32,
              left: 16,
              right: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _CircleButton(
                    icon: Icons.menu,
                    onTap: () {
                      print("Menu button tapped!");
                      _scaffoldKey.currentState?.openDrawer();
                    },
                  ),
                  _CircleButton(
                    icon: Icons.local_activity,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ActivityScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
            // Search and toggle
            Positioned(
              left: 24,
              right: 24,
              top: 100,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardTheme.color, // Use theme's card color
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.pink.withOpacity(0.08)
                          : Colors.black.withOpacity(0.3), // Adjust shadow for dark mode
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.search, color: Theme.of(context).iconTheme.color), // Use theme's icon color
                        const SizedBox(width: 8),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              final result = await showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                                ),
                                builder: (context) => AddressSelectionModal(),
                              );
                              if (result != null && result['from'] != null && result['to'] != null) {
                                await showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                                  ),
                                  builder: (context) => AvailableRidesModal(
                                    from: result['from'],
                                    to: result['to'],
                                  ),
                                );
                              }
                            },
                            child: Text(
                              'Where would you go?',
                              style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.bodySmall?.color), // Use theme's text color
                            ),
                          ),
                        ),
                        Icon(Icons.favorite_border, color: Theme.of(context).iconTheme.color), // Use theme's icon color
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.light
                            ? const Color(0xFFF3E6F6)
                            : Colors.grey.shade700, // Adjust color for dark mode
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => _toggleIndex = 0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: _toggleIndex == 0
                                      ? Theme.of(context).colorScheme.primary
                                      : Colors.transparent, // Use theme's primary color
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                alignment: Alignment.center,
                                child: Text(
                                  'Transport',
                                  style: TextStyle(
                                    color: _toggleIndex == 0
                                        ? Theme.of(context).colorScheme.onPrimary
                                        : Theme.of(context).colorScheme.primary, // Use theme's onPrimary/primary color
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => _toggleIndex = 1),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: _toggleIndex == 1
                                      ? Theme.of(context).colorScheme.primary
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                alignment: Alignment.center,
                                child: Text(
                                  'Delivery',
                                  style: TextStyle(
                                    color: _toggleIndex == 1
                                        ? Theme.of(context).colorScheme.onPrimary
                                        : Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Suggestions Section (Services)
            Positioned(
              top: 270, // Adjust this value based on desired spacing
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Suggestions',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyLarge?.color), // Use theme's text color
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ServicesTab()),
                            );
                          },
                          child: Text(
                            'See all',
                            style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 16), // Use theme's primary color
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _ServiceItem(
                          icon: Icons.electric_scooter,
                          label: 'Scooter',
                          isPromo: false,
                          onTap: () async {
                            await showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                                side: BorderSide(color: Theme.of(context).dividerColor), // Use theme's divider color
                              ),
                              builder: (context) => AddressSelectionModal(),
                            );
                          },
                        ),
                        _ServiceItem(
                          icon: Icons.pedal_bike,
                          label: 'Bike',
                          isPromo: true,
                          onTap: () async {
                            await showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                                side: BorderSide(color: Theme.of(context).dividerColor), // Use theme's divider color
                              ),
                              builder: (context) => AddressSelectionModal(),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Reserve a ride in advance section
            Positioned(
              top: 480, // Adjust this value based on desired spacing
              left: 0,
              right: 0,
              child: SizedBox(
                height: 180, // Set a fixed height for the horizontal list
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 4,
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.1), // Use theme's primary color with opacity
                      child: Container(
                        width: 300, // Fixed width for each card
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Reserve a ride in',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyLarge?.color), // Use theme's text color
                                  ),
                                  Text(
                                    'advance',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyLarge?.color), // Use theme's text color
                                  ),
                                  const SizedBox(height: 16),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Request Reserve functionality
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Theme.of(context).colorScheme.surface, // Use theme's surface color
                                      foregroundColor: Theme.of(context).colorScheme.primary, // Use theme's primary color
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                    ),
                                    child: const Text('Request Reserve', style: TextStyle(fontSize: 16)),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Placeholder for image
                            Container(
                              width: 100,
                              height: 120,
                              decoration: BoxDecoration(
                                color: Theme.of(context).brightness == Brightness.light
                                    ? Colors.grey.shade200
                                    : Colors.grey.shade700, // Adjust color for dark mode
                                borderRadius: BorderRadius.circular(12),
                                image: const DecorationImage(
                                  image: AssetImage('assets/reserve_ride_placeholder.png'), // Placeholder image
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16), // Spacing between cards
                    Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 4,
                      color: Theme.of(context).cardTheme.color, // Use theme's card color
                      child: Container(
                        width: 300, // Fixed width
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: Text(
                            'More content here',
                            style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color), // Use theme's text color
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      case 1:
        return const ServicesTab();
      case 2:
        return const NotificationTab();
      case 3:
        return const ProfileTab();
      default:
        return Container();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: _getPage(_selectedIndex),
      drawer: const AppDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Theme.of(context).colorScheme.primary, // Use theme's primary color
        unselectedItemColor: Theme.of(context).textTheme.bodySmall?.color, // Use theme's text color
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).cardColor, // Use theme's card color for nav bar background
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.miscellaneous_services),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
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

  const _DrawerItem({
    required this.icon,
    required this.text,
    this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Theme.of(context).iconTheme.color), // Use theme's icon color
          title: Text(
            text,
            style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color, fontSize: 16), // Use theme's text color
          ),
          subtitle: subtitle != null
              ? Text(
                  subtitle!,
                  style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color, fontSize: 12), // Use theme's text color
                )
              : null,
          trailing: Icon(Icons.arrow_forward_ios, color: Theme.of(context).iconTheme.color, size: 16), // Use theme's icon color
          onTap: onTap, // Use the provided onTap callback
        ),
        Divider(color: Theme.of(context).dividerColor, height: 0, indent: 16, endIndent: 16), // Use theme's divider color
      ],
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor, // Use theme's card color
      shape: const CircleBorder(),
      elevation: 4,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(icon, color: Theme.of(context).iconTheme.color), // Use theme's icon color
        ),
      ),
    );
  }
}

// Widget for service items
class _ServiceItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isPromo;
  final VoidCallback? onTap;

  const _ServiceItem({
    required this.icon,
    required this.label,
    this.isPromo = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Apply the onTap here
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor, // Use theme's card color
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.pink.withOpacity(0.05)
                      : Colors.black.withOpacity(0.2), // Adjust shadow for dark mode
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              children: [
                Center(
                  child: Icon(icon, size: 30, color: Theme.of(context).colorScheme.primary), // Use theme's primary color
                ),
                if (isPromo)
                  Positioned(
                    top: 4,
                    right: 4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.green, // You can adjust this color
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Promo',
                        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 10, fontWeight: FontWeight.bold), // Use theme's onPrimary color
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(fontSize: 14, color: Theme.of(context).textTheme.bodyLarge?.color, fontWeight: FontWeight.w500), // Use theme's text color
          ),
        ],
      ),
    );
  }
} 
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
                color: Colors.white,
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
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.pink.withOpacity(0.08),
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
                        const Icon(Icons.search, color: Colors.grey),
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
                            child: const Text(
                              'Where would you go?',
                              style: TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          ),
                        ),
                        Icon(Icons.favorite_border, color: Colors.grey[400]),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3E6F6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => _toggleIndex = 0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: _toggleIndex == 0 ? const Color(0xFFE91E63) : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                alignment: Alignment.center,
                                child: Text(
                                  'Transport',
                                  style: TextStyle(
                                    color: _toggleIndex == 0 ? Colors.white : Colors.pink,
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
                                  color: _toggleIndex == 1 ? const Color(0xFFE91E63) : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                alignment: Alignment.center,
                                child: Text(
                                  'Delivery',
                                  style: TextStyle(
                                    color: _toggleIndex == 1 ? Colors.white : Colors.pink,
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
                        const Text(
                          'Suggestions',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ServicesTab()),
                            );
                          },
                          child: const Text(
                            'See all',
                            style: TextStyle(color: Colors.pink, fontSize: 16),
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
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
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
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
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
                      color: const Color(0xFFF0E6F6), // Light pink/purple shade
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
                                  const Text(
                                    'Reserve a ride in',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                                  ),
                                  const Text(
                                    'advance',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                                  ),
                                  const SizedBox(height: 16),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Request Reserve functionality
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.pink,
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
                                color: Colors.grey.shade200,
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
                      color: Colors.white, // Another card for potential future use or more content
                      child: Container(
                        width: 300, // Fixed width
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: Text(
                            'More content here',
                            style: TextStyle(color: Colors.black54),
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
        selectedItemColor: const Color(0xFFE91E63),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
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
      color: Colors.white,
      shape: const CircleBorder(),
      elevation: 4,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(icon, color: Colors.grey[700]),
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
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.pink.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              children: [
                Center(
                  child: Icon(icon, size: 30, color: Colors.pink),
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
                      child: const Text(
                        'Promo',
                        style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
} 
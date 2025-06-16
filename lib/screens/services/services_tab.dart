import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:her_rides_user/screens/address_selection/address_selection_modal.dart';
import 'package:her_rides_user/screens/address_selection/available_rides_modal.dart';

class ServicesTab extends StatelessWidget {
  const ServicesTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Define the two-wheeler service data
    final List<Map<String, dynamic>> twoWheelerServices = [
      {
        'name': 'Bike',
        'icon': FontAwesomeIcons.motorcycle,
        'isPromo': true,
      },
      {
        'name': 'Scooter',
        'icon': Icons.electric_scooter,
        'isPromo': false,
      },
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor, // Use theme's background color
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor, // Use theme's app bar background color
        title: Text(
          'Services',
          style: Theme.of(context).appBarTheme.titleTextStyle, // Use theme's title style
        ),
        elevation: 0,
        iconTheme: Theme.of(context).appBarTheme.iconTheme, // Use theme's icon theme
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Go anywhere, get anything',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge?.color, // Use theme's text color
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.8, // Adjust as needed
              ),
              itemCount: twoWheelerServices.length,
              itemBuilder: (context, index) {
                final service = twoWheelerServices[index];
                return _ServiceItem(
                  name: service['name'],
                  icon: service['icon'],
                  isPromo: service['isPromo'],
                  useFaIcon: service['icon'] is IconData && service['icon'] == FontAwesomeIcons.motorcycle,
                  onTap: () async { // Add onTap callback
                    final result = await showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                        side: BorderSide(color: Theme.of(context).dividerColor), // Use theme's divider color
                      ),
                      builder: (context) => AddressSelectionModal(),
                    );
                    if (result != null && result['from'] != null && result['to'] != null) {
                      await showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                          side: BorderSide(color: Theme.of(context).dividerColor), // Use theme's divider color
                        ),
                        builder: (context) => AvailableRidesModal(
                          from: result['from'],
                          to: result['to'],
                        ),
                      );
                    }
                  },
                );
              },
            ),
            const SizedBox(height: 40),
            Text(
              'Get anything done',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge?.color, // Use theme's text color
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            // This section can be populated later if more services are needed
            Container(
              height: 100, // Placeholder height
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor, // Use theme's card color
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Text(
                'No delivery services for two-wheelers yet',
                style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color), // Use theme's text color
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ServiceItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final bool isPromo;
  final bool useFaIcon;
  final VoidCallback? onTap; // Add onTap property

  const _ServiceItem({
    required this.name,
    required this.icon,
    this.isPromo = false,
    this.useFaIcon = false,
    this.onTap, // Initialize onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector( // Wrap with GestureDetector
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor, // Use theme's card color
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (useFaIcon)
                    FaIcon(
                      icon,
                      size: 40,
                      color: Theme.of(context).colorScheme.primary, // Use theme's primary color
                    ) else
                    Icon(
                      icon,
                      size: 40,
                      color: Theme.of(context).colorScheme.primary, // Use theme's primary color
                    ),
                  const SizedBox(height: 8),
                  Text(
                    name,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge?.color, // Use theme's text color
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            if (isPromo)
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary, // Use theme's primary color for promo tag
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'Promo',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary, // Use theme's onPrimary color for promo text
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
} 
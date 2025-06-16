import 'package:flutter/material.dart';
import 'package:her_rides_user/screens/ride_details/ride_details_screen.dart';

class AvailableRidesModal extends StatelessWidget {
  final String from;
  final String to;
  AvailableRidesModal({required this.from, required this.to});

  final List<Map<String, dynamic>> rides = const [
    {
      'type': 'Scooter',
      'brand': 'Honda Activa',
      'desc': 'Experienced Two-Wheeler Drivers at Your Service',
      'price': 89.0,
      'eta': '3 min',
      'arrival_time': '5 min',
      'drop_off_time': '20 min',
      'img': Icons.electric_scooter,
      'seats': 2,
    },
    {
      'type': 'Scooter',
      'brand': 'TVS Jupiter',
      'desc': 'Smooth and Safe Ride for Women',
      'price': 95.0,
      'eta': '4 min',
      'arrival_time': '7 min',
      'drop_off_time': '25 min',
      'img': Icons.electric_scooter,
      'seats': 2,
    },
    {
      'type': 'Bike',
      'brand': 'Hero Splendor',
      'desc': "Solo Riders' First Pick! Smooth Economic Rides!",
      'price': 110.0,
      'eta': '5 min',
      'arrival_time': '8 min',
      'drop_off_time': '30 min',
      'img': Icons.pedal_bike,
      'seats': 2,
    },
    {
      'type': 'Bike',
      'brand': 'Bajaj Pulsar',
      'desc': 'Beat the Traffic and Reach Your Destination Faster!',
      'price': 120.0,
      'eta': '6 min',
      'arrival_time': '10 min',
      'drop_off_time': '35 min',
      'img': Icons.pedal_bike,
      'seats': 2,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Choose a trip or swipe up for more',
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.pink),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: rides.length,
                  itemBuilder: (context, index) {
                    final ride = rides[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(color: Colors.pink.shade100, width: 1),
                      ),
                      elevation: 2,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RideDetailsScreen(ride: ride),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.pink.shade50,
                                child: Icon(ride['img'], color: Colors.pink, size: 32),
                                radius: 28,
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      ride['brand'],
                                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.pink, fontSize: 16),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      ride['desc'],
                                      style: const TextStyle(fontSize: 13, color: Colors.black87),
                                    ),
                                    const SizedBox(height: 8),
                                    Wrap(
                                      spacing: 12,
                                      runSpacing: 8,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(Icons.people, size: 16, color: Colors.grey),
                                            const SizedBox(width: 4),
                                            Text('${ride['seats']}'),
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(Icons.timer, size: 16, color: Colors.grey),
                                            const SizedBox(width: 4),
                                            Text(
                                              ride['eta'],
                                              style: const TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(Icons.departure_board, size: 16, color: Colors.grey),
                                            const SizedBox(width: 4),
                                            Text(
                                              'Arrive: ${ride['arrival_time']}',
                                              style: const TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(Icons.directions_bike, size: 16, color: Colors.grey),
                                            const SizedBox(width: 4),
                                            Text(
                                              'Drop: ${ride['drop_off_time']}',
                                              style: const TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Text(
                                '₹ ${ride['price'].toStringAsFixed(2)}',
                                style: const TextStyle(
                                  color: Colors.pink,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
} 
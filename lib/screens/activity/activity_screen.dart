import 'package:flutter/material.dart';
import 'package:her_rides_user/screens/activity/activity_data.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).iconTheme.color),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Activity',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Past',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyLarge?.color),
                ),
                IconButton(
                  icon: Icon(Icons.tune, color: Theme.of(context).iconTheme.color),
                  onPressed: () {
                    // Filter functionality
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: pastActivities.length,
              itemBuilder: (context, index) {
                final activity = pastActivities[index];
                if (activity['type'] == 'map') {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: Theme.of(context).cardTheme.elevation,
                      color: Theme.of(context).cardColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                            child: Image.asset(
                              'assets/map_placeholder.png',
                              height: 180,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${activity['from']} & ${activity['to']}',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Theme.of(context).textTheme.bodyLarge?.color),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${activity['date']} • ${activity['time']}',
                                  style: TextStyle(fontSize: 14, color: Theme.of(context).textTheme.bodySmall?.color),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '₹${activity['price'].toStringAsFixed(2)}',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Theme.of(context).colorScheme.primary),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    Expanded(
                                      child: OutlinedButton.icon(
                                        onPressed: () {},
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: Theme.of(context).colorScheme.primary,
                                          side: BorderSide(color: Theme.of(context).colorScheme.primary),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                          padding: const EdgeInsets.symmetric(vertical: 12),
                                        ),
                                        icon: Icon(Icons.star_border, size: 20, color: Theme.of(context).iconTheme.color),
                                        label: Text('Rate', style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.bodyLarge?.color)),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: OutlinedButton.icon(
                                        onPressed: () {},
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: Theme.of(context).colorScheme.primary,
                                          side: BorderSide(color: Theme.of(context).colorScheme.primary),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                          padding: const EdgeInsets.symmetric(vertical: 12),
                                        ),
                                        icon: Icon(Icons.replay, size: 20, color: Theme.of(context).iconTheme.color),
                                        label: Text('Rebook', style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.bodyLarge?.color)),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (activity['type'] == 'ride') {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: Theme.of(context).cardTheme.elevation,
                      color: Theme.of(context).cardColor,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Theme.of(context).brightness == Brightness.light
                                  ? Colors.pink.shade50
                                  : Colors.grey.shade700,
                              radius: 28,
                              child: Icon(Icons.directions_car, color: Theme.of(context).colorScheme.primary, size: 32),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    activity['destination'],
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Theme.of(context).textTheme.bodyLarge?.color),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${activity['date']} • ${activity['time']}',
                                    style: TextStyle(fontSize: 13, color: Theme.of(context).textTheme.bodySmall?.color),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '₹${activity['price'].toStringAsFixed(2)}',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Theme.of(context).colorScheme.primary),
                                  ),
                                ],
                              ),
                            ),
                            OutlinedButton.icon(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Theme.of(context).colorScheme.primary,
                                side: BorderSide(color: Theme.of(context).colorScheme.primary),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              ),
                              icon: Icon(Icons.replay, size: 20, color: Theme.of(context).iconTheme.color),
                              label: Text('Rebook', style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.bodyLarge?.color)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
} 
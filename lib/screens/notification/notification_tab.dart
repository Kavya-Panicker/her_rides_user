import 'package:flutter/material.dart';

class NotificationTab extends StatelessWidget {
  const NotificationTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        centerTitle: true,
        leading: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
        title: Text(
          'Notification',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          const SizedBox(height: 8),
          Text(
            'Today',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          const SizedBox(height: 8),
          _NotificationCard(
            highlighted: true,
            title: 'Payment confirm',
            description: 'Lorem ipsum dolor sit amet consectetur. Ultrici es tincidunt eleifend vitae',
            time: '15 min ago.',
          ),
          _NotificationCard(
            highlighted: false,
            title: 'Payment confirm',
            description: 'Lorem ipsum dolor sit amet consectetur. Ultrici es tincidunt eleifend vitae',
            time: '25 min ago.',
          ),
          const SizedBox(height: 16),
          Text(
            'Yesterday',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          const SizedBox(height: 8),
          _NotificationCard(
            highlighted: true,
            title: 'Payment confirm',
            description: 'Lorem ipsum dolor sit amet consectetur. Ultrici es tincidunt eleifend vitae',
            time: '15 min ago.',
          ),
          _NotificationCard(
            highlighted: false,
            title: 'Payment confirm',
            description: 'Lorem ipsum dolor sit amet consectetur. Ultrici es tincidunt eleifend vitae',
            time: '25 min ago.',
          ),
          _NotificationCard(
            highlighted: false,
            title: 'Payment confirm',
            description: 'Lorem ipsum dolor sit amet consectetur. Ultrici es tincidunt eleifend vitae',
            time: '25 min ago.',
          ),
          _NotificationCard(
            highlighted: true,
            title: 'Payment confirm',
            description: 'Lorem ipsum dolor sit amet consectetur. Ultrici es tincidunt eleifend vitae',
            time: '15 min ago.',
          ),
        ],
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final bool highlighted;
  final String title;
  final String description;
  final String time;

  const _NotificationCard({
    required this.highlighted,
    required this.title,
    required this.description,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: highlighted
            ? (isDarkMode ? Colors.pink.shade900.withOpacity(0.4) : const Color(0xFFFFE3F0))
            : Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: highlighted
              ? (isDarkMode ? Colors.pink.shade700 : const Color(0xFFE91E63).withOpacity(0.2))
              : Theme.of(context).dividerColor.withOpacity(0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(
              fontSize: 13,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            time,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).textTheme.bodySmall?.color,
            ),
          ),
        ],
      ),
    );
  }
} 
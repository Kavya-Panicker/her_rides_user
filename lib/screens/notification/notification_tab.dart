import 'package:flutter/material.dart';

class NotificationTab extends StatelessWidget {
  const NotificationTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text(
          'Notification',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          const SizedBox(height: 8),
          const Text(
            'Today',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.black,
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
          const Text(
            'Yesterday',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.black,
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
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: highlighted ? const Color(0xFFFFE3F0) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: highlighted ? const Color(0xFFE91E63).withOpacity(0.2) : Colors.grey.withOpacity(0.08),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Color(0xFFE91E63),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            time,
            style: TextStyle(
              fontSize: 12,
              color: Colors.pink[300],
            ),
          ),
        ],
      ),
    );
  }
} 
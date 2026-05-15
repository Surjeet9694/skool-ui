import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final notifications = [
      (Icons.check_circle_rounded, 'Attendance Marked', 'Your attendance for today has been recorded.', false, const Color(0xFF10B981)),
      (Icons.assignment_rounded, 'New Homework', 'Math: Chapter 5 exercises due on May 16.', true, const Color(0xFF4F46E5)),
      (Icons.payments_rounded, 'Fee Reminder', 'Term fee payment is due on May 20.', true, const Color(0xFFF59E0B)),
      (Icons.notifications_rounded, 'School Notice', 'School will remain closed on May 15 for a public holiday.', false, const Color(0xFF06B6D4)),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Mark all read'),
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, i) {
          final (icon, title, body, isUnread, color) = notifications[i];
          return Card(
            child: ListTile(
              leading: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              title: Row(
                children: [
                  Expanded(
                    child: Text(title,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                  if (isUnread)
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(body, style: theme.textTheme.bodySmall),
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}

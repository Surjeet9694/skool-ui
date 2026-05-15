import 'package:flutter/material.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Attendance')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 10,
        itemBuilder: (context, index) {
          final date = DateTime.now().subtract(Duration(days: index));
          final isPresent = index % 4 != 2;
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: isPresent
                    ? const Color(0xFF10B981).withOpacity(0.15)
                    : colorScheme.error.withOpacity(0.15),
                child: Icon(
                  isPresent ? Icons.check_rounded : Icons.close_rounded,
                  color: isPresent ? const Color(0xFF10B981) : colorScheme.error,
                ),
              ),
              title: Text(
                '${date.day}/${date.month}/${date.year}',
                style: theme.textTheme.titleSmall
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(isPresent ? 'Present' : 'Absent',
                  style: TextStyle(
                    color: isPresent
                        ? const Color(0xFF10B981)
                        : colorScheme.error,
                  )),
              trailing: const Icon(Icons.chevron_right_rounded),
            ),
          );
        },
      ),
    );
  }
}

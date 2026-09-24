import 'package:flutter/material.dart';
import 'package:nti/core/theme/app_colors.dart';

class TaskGroup {
  const TaskGroup(this.label, this.color, this.icon);
  final String label;
  final Color color;
  final IconData icon;
}

const List<TaskGroup> kTaskGroups = [
  TaskGroup('Home', Color(0xFFF7C6D9), Icons.home_rounded),
  TaskGroup('Personal', AppColors.primary, Icons.person_rounded),
  TaskGroup('Work', AppColors.black, Icons.work_rounded),
];

/// Rounded field that opens a small menu to pick a task group.
class GroupDropdown extends StatelessWidget {
  const GroupDropdown({super.key, required this.value, required this.onChanged});

  final TaskGroup value;
  final ValueChanged<TaskGroup> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<TaskGroup>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.grey),
          items: kTaskGroups.map((group) {
            return DropdownMenuItem(
              value: group,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: group.color.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(group.icon, size: 16, color: group.color),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    group.label,
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (g) {
            if (g != null) onChanged(g);
          },
          padding: const EdgeInsets.symmetric(vertical: 4),
        ),
      ),
    );
  }
}

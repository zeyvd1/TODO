import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:nti/core/constants/app_assets.dart';
import 'package:nti/core/theme/app_colors.dart';
import 'package:nti/core/widgets/custom_button.dart';
import 'package:nti/core/widgets/custom_text_field.dart';
import 'package:nti/core/widgets/detail_app_bar.dart';
import 'package:nti/features/todo/view/widgets/group_dropdown.dart';
import 'package:nti/features/todo/view_model/task_view_model.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _taskViewModel = TaskViewModel();
  bool _isLoading = false;

  TaskGroup _group = kTaskGroups.first;
  DateTime? _endTime;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickEndTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (date == null || !mounted) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time == null) return;

    setState(() {
      _endTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  String get _endTimeLabel {
    if (_endTime == null) return '';

    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    final hour =
        _endTime!.hour % 12 == 0 ? 12 : _endTime!.hour % 12;

    final suffix = _endTime!.hour >= 12 ? 'pm' : 'am';

    final minute =
        _endTime!.minute.toString().padLeft(2, '0');

    return '${_endTime!.day} ${months[_endTime!.month - 1]}, '
        '${_endTime!.year}  $hour:$minute $suffix';
  }

  Future<void> _submit() async {
    setState(() => _isLoading = true);
    try {
      await _taskViewModel.createTask(
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
      );
      if (!mounted) return;
      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: const DetailAppBar(
        title: 'Add Task',
      ),

      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            24,
            0,
            24,
            24,
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  AppImages.flag,
                  width: double.infinity,
                  height: (width * 0.55).clamp(160, 260),
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 20),

              // Title
              CustomTextField(
                hintText: 'Title',
                controller: _titleController,
              ),

              const SizedBox(height: 16),

              // Description
              CustomTextField(
                hintText: 'Description',
                controller: _descriptionController,
              ),

              const SizedBox(height: 16),

              // Group
              GroupDropdown(
                value: _group,
                onChanged: (g) {
                  setState(() {
                    _group = g;
                  });
                },
              ),

              const SizedBox(height: 16),

              // End Time
              InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: _pickEndTime,
                child: Container(
                  width: double.infinity,

                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),

                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.border,
                    ),
                  ),

                  child: Row(
                    children: [
                      SvgPicture.asset(
                        AppSvgs.date,
                        width: 20,
                        height: 20,
                      ),

                      const SizedBox(width: 10),

                      Text(
                        _endTime == null
                            ? 'End Time'
                            : _endTimeLabel,

                        style: TextStyle(
                          fontSize: 15,
                          color: _endTime == null
                              ? AppColors.grey
                              : AppColors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // Add Task Button
              CustomButton(
                text: _isLoading ? '...' : 'Add Task',
                onPressed: _isLoading ? null : _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
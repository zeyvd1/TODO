import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:nti/core/constants/app_assets.dart';
import 'package:nti/core/theme/app_colors.dart';
import 'package:nti/core/widgets/custom_button.dart';
import 'package:nti/core/widgets/custom_text_field.dart';
import 'package:nti/core/widgets/detail_app_bar.dart';
import 'package:nti/features/todo/model/task_model.dart';
import 'package:nti/features/todo/view/widgets/group_dropdown.dart';
import 'package:nti/features/todo/view_model/task_view_model.dart';

class EditTaskScreen extends StatefulWidget {
  const EditTaskScreen({
    super.key,
    required this.task,
  });

  final TaskModel task;

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final _taskViewModel = TaskViewModel();
  bool _isLoading = false;

  late final _titleController =
      TextEditingController(text: widget.task.title);

  late final _descriptionController =
      TextEditingController(text: widget.task.description);

  late TaskGroup _group = kTaskGroups.firstWhere(
    (g) => g.label == widget.task.group,
    orElse: () => kTaskGroups.first,
  );

  late bool _isDone = widget.task.status == 'Done';

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _update() async {
    if (widget.task.id == null) {
      Navigator.pop(context);
      return;
    }
    setState(() => _isLoading = true);
    try {
      await _taskViewModel.updateTask(
        id: widget.task.id!,
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

  Future<void> _delete() async {
    if (widget.task.id == null) {
      Navigator.pop(context);
      return;
    }
    setState(() => _isLoading = true);
    try {
      await _taskViewModel.deleteTask(widget.task.id!);
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
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: DetailAppBar(
        title: 'Edit Task',

        trailing: GestureDetector(
          onTap: _isLoading ? null : _delete,

          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 8,
            ),

            decoration: BoxDecoration(
              color: AppColors.danger,
              borderRadius: BorderRadius.circular(20),
            ),

            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  AppSvgs.delete,
                  width: 16,
                  height: 16,
                ),

                const SizedBox(width: 4),

                const Text(
                  'Delete',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
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
              // Status
              Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(
                      AppImages.flag,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          _isDone
                              ? 'Done'
                              : 'In Progress',

                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: AppColors.black,
                          ),
                        ),

                        Text(
                          _isDone
                              ? 'Congrats!'
                              : "Believe you can, and you're halfway there.",

                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.black,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

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

              // Date & Time
              Container(
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
                      '${widget.task.date}  ${widget.task.time}',

                      style: const TextStyle(
                        fontSize: 15,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Buttons
              if (!_isDone) ...[
                CustomButton(
                  text: 'Mark as Done',

                  onPressed: () {
                    setState(() {
                      _isDone = true;
                    });
                  },
                ),

                const SizedBox(height: 12),

                CustomButton(
                  text: 'Update',
                  outlined: true,
                  onPressed: _isLoading ? null : _update,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
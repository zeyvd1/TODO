
class TaskModel {
  const TaskModel({
    this.id,
    required this.title,
    required this.description,
    this.date = '',
    this.time = '',
    this.image,
    this.group = 'Home',
    this.status = 'In Progress',
  });

  final int? id;
  final String title;
  final String description;
  final String date;
  final String time;
  final String? image;
  final String group; // 'Home' | 'Personal' | 'Work' (local only for now)
  final String status; // 'In Progress' | 'Done' (local only for now)

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    final raw = json['created_at'] ?? json['end_time'] ?? json['date'];
    String date = '', time = '';
    if (raw != null) {
      final parsed = DateTime.tryParse(raw.toString());
      if (parsed != null) {
        date = '${parsed.day.toString().padLeft(2, '0')}/'
            '${parsed.month.toString().padLeft(2, '0')}/${parsed.year}';
        final hour = parsed.hour % 12 == 0 ? 12 : parsed.hour % 12;
        final suffix = parsed.hour >= 12 ? 'PM' : 'AM';
        time = '$hour:${parsed.minute.toString().padLeft(2, '0')} $suffix';
      }
    }
    return TaskModel(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      date: date,
      time: time,
      image: json['image'] ?? json['image_url'],
    );
  }
}

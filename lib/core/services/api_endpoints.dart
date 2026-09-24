class ApiEndpoints {

  // Users
  static const String register = 'register';
  static const String login = 'login';
  static const String changePassword = 'change_password';
  static const String refreshToken = 'refresh_token';
  static const String updateProfile = 'update_profile';
  static const String getUserData = 'get_user_data';
  static const String deleteUser = 'delete_user';

  // Tasks
  static const String newTask = 'new_task';
  static const String myTasks = 'my_tasks';
  static String task(int id) => 'tasks/$id'; // update (PUT) / delete (DELETE)
}

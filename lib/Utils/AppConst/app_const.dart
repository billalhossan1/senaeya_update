class AppConstants {
  static String bearerToken = "token";
  // static String userId = "UserId";
  static String onBoard = "Onboard";
  static bool isHuawei = false;

  /// <====================== All Response Message Static==============================>

  static String successfull = "Request Successfull";
  static String error = "Oops, something went wrong";
  static String profileID = "profileID";
  static String userStatus = "userStatus";
  static String rememberMe = "rememberMe";
  static var chatId = "chatID";

  static String onlineImage =
      "https://images.unsplash.com/photo-1546961329-78bef0414d7c?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fHVzZXJ8ZW58MHx8MHx8fDA%3D";

  static String teethHelth =
      "https://images.unsplash.com/photo-1606811971618-4486d14f3f99?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8dGVldGh8ZW58MHx8MHx8fDA%3D";
}

enum Status { loading, error, completed, internetError }

class FirebasePathConstant {
  static final VAL_KEY = "#:::";
  static final PATH_DATA = {
    "MESS_LIST_PATH": "chat_room/" + VAL_KEY + "/mess_list",
    "USER_INFOR": "user_information",
    "WEDDING_INFOR": "wedding_information",
  };

  static String getPath(String name, String key) {
    if (PATH_DATA[name] == null) return "";
    return PATH_DATA[name]!.replaceFirst(VAL_KEY, key);
  }
}

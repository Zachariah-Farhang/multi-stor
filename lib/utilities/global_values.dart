class GlobalValues {
  static final GlobalValues _instance = GlobalValues._internal();

  factory GlobalValues() {
    return _instance;
  }

  GlobalValues._internal();

  String userType = '';
}

enum AppTheme<T> {
  light(),
  dark();

  const AppTheme();

  static AppTheme _current = AppTheme.light;
  static set current(AppTheme value) => _current = value;
}
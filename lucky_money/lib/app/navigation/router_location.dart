enum AppRouterLocation {
  root(name: 'splash', path: '/splash'),
  home(name: 'homePage', path: '/homePage'),
  add(name: 'addPage', path: '/addPage'),
  item(name: 'itemPage', path: '/itemPage');

  /// Represents the route name
  ///
  /// Example: `AppRouteLocation.home.name`
  /// Returns: 'home'
  final String name;

  /// Represents the route path
  ///
  /// Example: `AppRouteLocation.home.path`
  /// Returns: '/home'
  final String path;

  const AppRouterLocation({required this.name, required this.path});

  @override
  String toString() => name;
}

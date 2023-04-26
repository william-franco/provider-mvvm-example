class Environments {
  static const String baseURL = String.fromEnvironment(
    'jsonplaceholder',
    defaultValue: 'https://jsonplaceholder.typicode.com',
  );

  static const String todos = String.fromEnvironment(
    'todos',
    defaultValue: '/todos',
  );

  static const String photos = String.fromEnvironment(
    'photos',
    defaultValue: '/photos',
  );
}

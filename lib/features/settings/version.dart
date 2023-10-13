enum Version {
  version1('1.0.0', 'https://jsonplaceholder.typicode.com'),
  version2('2.0.0', 'https://api.openweathermap.org/data/2.5'),
  version3('2.1.0', 'https://api.openweathermap.org/data/2.5');

  final String name;
  final String baseUrl;
  const Version(this.name, this.baseUrl);
}

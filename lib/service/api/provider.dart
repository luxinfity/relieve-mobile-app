class Provider {
  final String name = '';
  String completeUri = '';
  String secret = '';

  Provider setUri(String uri) {
    this.completeUri = uri + name;
    return this;
  }

  Provider setSecret(String secret) {
    this.secret = secret;
    return this;
  }

  /// Always invoke this function before call get / post resource
  void checkProvider() {
    if (name.isEmpty) throw Exception('name is Empty');
    if (completeUri.isEmpty) throw Exception('completeUri is Empty');
    if (secret.isEmpty) throw Exception('secret is Empty');
  }
}

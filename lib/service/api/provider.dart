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
    if (name.isEmpty) throw StateError('name is Empty');
    if (completeUri.isEmpty) throw StateError('completeUri is Empty');
    if (secret.isEmpty) throw StateError('secret is Empty');
  }
}

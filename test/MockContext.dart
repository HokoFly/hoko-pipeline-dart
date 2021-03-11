class MockContext {
  static const int MAX_RETRY_TIME = 3;

  int _retryTime = 1;

  void addRetryTime() {
    _retryTime++;
  }

  bool isLimitedRetryTime() => _retryTime >= MAX_RETRY_TIME;

}
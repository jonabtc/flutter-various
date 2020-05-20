import 'package:flutter/material.dart';

abstract class WebViewState {
  const WebViewState();
}

class Uninitialized extends WebViewState {}

class Initialized extends WebViewState {
  final double progress;
  final String url;

  const Initialized({this.progress = 0.0, @required this.url});

  @override
  String toString() {
    return 'Initialized {progress: $progress, url: $url}';
  }
}

class Loading extends WebViewState {
  final double progress;

  const Loading({@required this.progress});

  @override
  String toString() {
    return 'Initialized {progress: $progress}';
  }
}

class Finished extends WebViewState {}

class Error extends WebViewState {
  final String error;

  const Error({this.error});

  @override
  String toString() {
    return 'Error {error: $error}';
  }
}

abstract class WevViewEvent {
  const WevViewEvent();
}

class WebViewStarted extends WevViewEvent {}

class WebViewLoading extends WevViewEvent {
  final String url;
  final double progress;

  const WebViewLoading({this.url='', this.progress = 1});

  WebViewLoading update({
    String url,
    int progress,
  }) {
    return WebViewLoading(
      url: url ?? this.url,
      progress: progress/100 ?? this.progress,
    );
  }
}

class WebViewLoaded extends WevViewEvent {}

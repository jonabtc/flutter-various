import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_view/webview_state.dart';
import 'package:web_view/wevbiew_event.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WebViewBloc extends Bloc<WevViewEvent, WebViewState> {
  @override
  WebViewState get initialState => Uninitialized();

  @override
  Stream<WebViewState> mapEventToState(WevViewEvent event) async* {
    if (event is WebViewStarted) yield* _mapWebViewStartedToState();
    if (event is WebViewLoading) yield* _mapWebViewLoadingToState(event);
    if (event is WebViewLoaded) yield* _mapWebViewLoadedToState();
  }

  Stream<WebViewState> _mapWebViewStartedToState() async* {
     try{
      yield Initialized(url: await _getInitUrl());
    } catch (e){
      yield Error(error: e);
    }
  }

  Stream<WebViewState> _mapWebViewLoadingToState(WebViewLoading event) async* {
    if(event.url.isNotEmpty && event.url.contains('https://us-central1-zwippeapp-dev.cloudfunctions.net/validation')){
      yield Finished();
    }
  }

  Stream<WebViewState> _mapWebViewLoadedToState() async* {

  }

  Future<String> _getInitUrl() async {
    var url = 'https://us-central1-zwippeapp-dev.cloudfunctions.net/payment';
    var response = await http.get(url);
    return json.decode(response.body)['processUrl'];
  }
}

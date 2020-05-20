import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:web_view/webview_bloc.dart';
import 'package:web_view/webview_state.dart';
import 'package:web_view/wevbiew_event.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp2());
}

class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: MainPage(),
      routes: {
        'web': (context) => Scaffold(
              appBar: AppBar(),
              body: BlocProvider<WebViewBloc>(
                create: (context) => WebViewBloc()..add(WebViewStarted()),
                child: WebView(),
              ),
            ),
      },
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: RaisedButton(
          child: Text('ABRIR VISTA WEB'),
          onPressed: () => Navigator.pushNamed(context, 'web'),
        ),
      ),
    );
  }
}

class WebView extends StatelessWidget {
  InAppWebViewController webView;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WebViewBloc, WebViewState>(
      builder: (context, state) {
        if (state is Finished) Navigator.pop(context);
        if (state is Uninitialized) return LinearProgressIndicator();
        if (state is Initialized) return _buildWebView(state.url, context);
        if (state is Error) return null; //TODO: implement error page
        return Container();
        
      },
    );
  }

  _buildWebView(String url, BuildContext context) {
    return InAppWebView(
      initialUrl: url,
      initialHeaders: {},
      initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
        debuggingEnabled: true,
      )),
      onWebViewCreated: (InAppWebViewController controller) {
        webView = controller;
      },
      onLoadStart: (InAppWebViewController controller, String url) {
        BlocProvider.of<WebViewBloc>(context).add(WebViewLoading(url:url));
      },
      onLoadStop: (InAppWebViewController controller, String url) async {
        print('[DEBUG] onLoadStop/');
      },
      onProgressChanged: (InAppWebViewController controller, int progress) {},
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  InAppWebViewController webView;
  String url = "";
  double progress = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('InAppWebView Example'),
        ),
        body: buildWebView(),
      ),
    );
  }

  Container buildWebView() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
              child: progress < 1.0 ? LinearProgressIndicator() : Container()),
          Expanded(
            child: FutureBuilder<Object>(
              future: _getInitUrl(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return InAppWebView(
                    initialUrl: snapshot.data,
                    initialHeaders: {},
                    initialOptions: InAppWebViewGroupOptions(
                        crossPlatform: InAppWebViewOptions(
                      debuggingEnabled: true,
                    )),
                    onWebViewCreated: (InAppWebViewController controller) {
                      webView = controller;
                      print('se creó la web');
                    },
                    onLoadStart:
                        (InAppWebViewController controller, String url) {
                      if (url.contains(
                          'https://us-central1-zwippeapp-dev.cloudfunctions.net/validation'))
                        Navigator.pop(context);
                    },
                    onLoadStop:
                        (InAppWebViewController controller, String url) async {
                      print('[DEBUG] onLoadStop/');
                      setState(() {
                        this.url = url;
                      });
                    },
                    onProgressChanged:
                        (InAppWebViewController controller, int progress) {
                      print('[DEBUG] onProgressChanged/');
                      setState(() {
                        this.progress = progress / 100;
                      });
                    },
                  );
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<String> _getInitUrl() async {
    var url = 'https://us-central1-zwippeapp-dev.cloudfunctions.net/payment';
    var response = await http.get(url);
    return json.decode(response.body)['processUrl'];
  }
}

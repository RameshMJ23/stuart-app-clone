import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuartappclone/screens/constants/constants.dart';
import 'package:stuartappclone/screens/no_internet_screen_builder.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {

  String url;

  WebViewScreen({required this.url});

  late WebViewController controller;
  final ValueNotifier<bool> _webViewNotifier = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return NoInternetScreenBuilder(
      child: Scaffold(
        backgroundColor: getPeachColor,
        appBar: getLeadingOnlyAppBar(context: context),
        body: ValueListenableBuilder<bool>(
          valueListenable: _webViewNotifier,
          builder: (context, webLoaded, child){
            return Stack(
              children: [
                WebView(
                  backgroundColor: Colors.transparent,
                  initialUrl: url,
                  onWebViewCreated: (controller){
                    this.controller = controller;
                    Future.delayed(const Duration(seconds: 1)).then((value){
                      _webViewNotifier.value = true;
                    });
                  },
                  onPageStarted: (url){

                  },
                ),
                Visibility(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: getVioletColor,
                      ),
                    ),
                  ),
                  visible: webLoaded == false,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

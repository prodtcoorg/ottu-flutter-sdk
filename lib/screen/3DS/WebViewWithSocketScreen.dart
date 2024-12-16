import 'package:flutter/material.dart';
import 'package:ottu/Networkutils/networkUtils.dart';
import 'package:ottu/consts/colors.dart';
import 'package:ottu/consts/htmlString.dart';
import 'package:ottu/models/3DSResponse.dart';
import 'package:ottu/screen/3DS/utils/functions.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewWithSocketScreen extends StatefulWidget {
  final ThreeDsResponse? threeDsResponse;

  const WebViewWithSocketScreen({
    super.key,
    this.threeDsResponse,
  });

  @override
  State<WebViewWithSocketScreen> createState() => _WebViewWithSocketScreenState();
}

class _WebViewWithSocketScreenState extends State<WebViewWithSocketScreen> {
  late final WebViewController _webViewController;
  late ThreeDsResponse threeDsResponse;

  @override
  void initState() {
    super.initState();
    setState(() {
      threeDsResponse = NetworkUtils.threeDSResponse;
    });
    WebViewWithSocketScreenFunction.init(
      threeDsResponse.wsUrl.toString() ?? '',
      threeDsResponse.referenceNumber.toString() ?? '',
      context,
    );
  }

  @override
  void dispose() {
    WebViewWithSocketScreenFunction.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SafeArea(
        child: WebViewWidget(
          controller: _webViewController = WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..setBackgroundColor(Colors.transparent)
            ..loadHtmlString(HtmlString.htmlString(threeDsResponse.html ?? '<h1>Error Loading HTML</h1>')),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebView extends StatefulWidget {
  const MyWebView({super.key});

  @override
  State<MyWebView> createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  late final WebViewController webViewController;

  @override
  void initState() {
    super.initState();
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadFlutterAsset("assets/start.html"); /* <- ACCESS DENIED ERROR */
    // ..loadRequest(Uri.parse(               /* <- INITIALIZATION FAILED ERROR */
    //         "https://connectpathdev-yasmani-ap-southeast-1.awsapps.com/connect/ccp-v2/")
    // 'https://connectpathflex-qa-us-east-1.awsapps.com/auth/?client_id=564fda62f107a665&redirect_uri=https%3A%2F%2Fconnectpathflex-qa-us-east-1.my.connect.aws%2Fauth%2Fcode&state=AQICAHiJkEcyDBmtgpjcZs79mq_4BNhTdpoQw0a19y_71b1WiwG2ewcsmvdpr4-ZCD3oBpa6AAAApjCBowYJKoZIhvcNAQcGoIGVMIGSAgEAMIGMBgkqhkiG9w0BBwEwHgYJYIZIAWUDBAEuMBEEDOiCgJBMC6iYeWtJlwIBEIBfbxDlSdtsMi8AWGfSLUz8pfTs6YE3OHsKz6U6-DXSH-mkKtXwSNpN_S4YD9HZRaNtG7ZqIUn-viVLXci6OsuRF2FztNBRumh0uwIuPL_FPESh00sVUcpSZJ48084xTJc='),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
            onPressed: () {
              webViewController.goBack();
            },
            child: const Text("Back"),
          ),
          ElevatedButton(
            onPressed: () async {
              webViewController.runJavaScript(
                  """var endpoint = connect.Endpoint.byPhoneNumber("+13054912981");
                        var agent = new connect.Agent();
                        agent.connect(endpoint, {
                          success: function() { console.log("outbound call connected"); },
                          failure: function(err) {
                            console.log("outbound call connection failed");
                            console.log(err);
                          }
                    });""");
            },
            child: const Text("Call"),
          ),
          ElevatedButton(
            onPressed: () async {
              var logs = await webViewController
                  .runJavaScriptReturningResult("connect.getLog()");
              print(logs.toString());
            },
            child: const Text("Get logs"),
          ),
        ],
      ),
      body: WebViewWidget(controller: webViewController),
    );
  }
}

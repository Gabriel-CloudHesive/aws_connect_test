import 'package:aws_connect_api/connect-2017-08-08.dart';
import 'package:aws_connect_test/my_web_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_js/flutter_js.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: amazonConnect,
                child: const Text('Call from Amazon Connect'),
              ),
              const Divider(thickness: 1),
              Builder(builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyWebView(),
                        ));
                  },
                  child: const Text('Show WebView'),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  void amazonConnect() async {
    final service = Connect(
      region: 'ap-southeast-1',
      endpointUrl: "https://connect.ap-southeast-1.amazonaws.com",
      credentials: AwsClientCredentials(
        accessKey: "ASIASJ3TVY5DILGSQWOW",
        secretKey: "lSXVaCYzcdSZr2Xia56tFn0Vbi2xi+2j+cnhHEHZ",
        sessionToken:
            "IQoJb3JpZ2luX2VjEEcaCXVzLWVhc3QtMSJGMEQCIFq7Jh/p5OC8XKsxRruVUoAg3sVLw0rdju5TsU9/txsdAiArtv/iQsZBh8Ot55VjQVr2vwkAqJJT48jzG8o08bkvbiqhAwgwEAEaDDE1ODYxOTUxODc5MCIMsASiThg6LcnVLE8PKv4CD51M2b+TI0es0R5BYNwfJ5kpDI1ng9LowMiBPnJnmQwOs80e/XGL92Sch61f2Fojbj4AQxzPV63sMzVoVDDC9rJPtsUpgGMmV0rh8qkTJbMHQWrcIwsnF3CBinDraZ7jJZvoLpPBzkn0n3HwFl1Xgumpa/S6WwzhtfCn6tFnyR5cmdTEUNQJ6NppznufvTsKMhzIys7tq079B/C8jIXrOFTMHLbnjvbb4S1Aty20FEx8JtLskymtXVcfEQmBdvu8iQ+VpLARfArlB53Q2pLC3ptxq5m2JX2ril0qyUlKKupBHbPW5pAi/cVLaETqRSkxTuZZglYMGnRS5ls0grt2OgZE0LREYMbWMlMi6mW5/6zVScpA4oeO/+wGeTHcEl3iTVoFBrwUOyhHrEn4gBeW1IbMQ9V6pMAs8HbQVrBpeTuNh41lMy2eTHBkTiDcF80ASCBAPuAU07XMaAYjG2tZPSAf9z9zhxtgVnVgj0gieEiAoMZi3QpPRongTS5yjzCQk4eoBjqnASWKwZGoY6P8Cx7BzVyUHYtJgdoplLyu4oiHyDG7fVKFCnX6VS/lLimRadNjGkBQvb0Qihg2tDLiArqE6pCTqWrJtCKWeexpz0GgmYV6BSRjki62hzmQPUfl/BIZGceV8WgrWPaXaAcbqVhjJnLOukGW6F9qZkrlmshHKg8auzuRZo7eNFwLtpnTecs0N3AE223VKekY2eleDgQwNpHQeBIli73tb3MD",
      ),
    );

    ListInstancesResponse instancesResponse = await service.listInstances();
    List<InstanceSummary>? instacesList = instancesResponse.instanceSummaryList;
    InstanceSummary instance = instacesList!.elementAt(0);

    service.startOutboundVoiceContact(
        contactFlowId: "5974d26c-868f-462c-9a72-7f196858bfbb",
        destinationPhoneNumber: "+13054912981",
        instanceId: instance.id!,
        queueId: "766f3755-ac91-4d4d-81d2-f1374e69a206");
  }
}

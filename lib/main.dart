import 'package:aws_connect_api/connect-2017-08-08.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  TextEditingController textController = TextEditingController();
  late String number;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: textController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a phone number'),
              ),
              ElevatedButton(
                onPressed: callFromAmazonConnect,
                child: const Text('Call from Amazon Connect'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void callFromAmazonConnect() async {
    final service = Connect(
      region: 'ap-southeast-1',
      endpointUrl: "https://connect.ap-southeast-1.amazonaws.com",
      credentials: AwsClientCredentials(
        accessKey: "ASIASJ3TVY5DBAAWKU5A",
        secretKey: "FcE7SuUPMmDcTTTWlUrnaQ5Q/0ZE6AdxBFeXXYyx",
        sessionToken:
            "IQoJb3JpZ2luX2VjEPH//////////wEaCXVzLWVhc3QtMSJHMEUCIQCCchfsBDltS4K19DYAjVM7BieKQNd/LEF1WrocfbXGpAIgYM8rBrKH5MAJCILq3tIVri41qb4iNSj4qeFtTJBGuJ8qqgMI2f//////////ARABGgwxNTg2MTk1MTg3OTAiDMgvpiH5MPVbnhIqdCr+An+ovK8dfYFzk7IWj6KxTv+5Ez88S22ObjxRe8Wg7FjwLVj2gDSBc17hbL6R+X7WcQyBu+5b5FWYfaYCqe6RWXgP10BLrYCR1PWDqDT8BCU3HUbOE7U6cGWG2ojbQK3e54lDYY/F+zezRCoUgPsccKVz03ri103xGWdM9RaMzigWTZuP1yKnVKjxc7R2m3OhxgJlpYjnZJfrVuNBFGr0g/Jj0Xm/WU9ZOvzbrifaEflqZ7cidrdl9BKQov28zZeDf1g7nsOwCcUyY29MY6OMhb5Jm+GOLHnB0A1IQI8oX4ohH518vvEgHTVNh59zblmSibqO4gezvEVTUOdAGtJF6zs7YURz9HaQDLejZhfxRK0Xddtbyr+CPZ0DrRiv7cvtsSjqBq658YpVJoKc8dISHITzjynhfTwGTA5t4UvvFUjEWN2LnwKVI5QoKDHKljdti28SGvSSOkRKO6mxGcrUcIepBtzhniw4yHgQ7Ns9sQXZnKfGrEaElk2YrSq2ppUwz7SsqAY6pgFRTd0OCXSHi00nU/XDcemhOwEhocdtHTJ9Qsko+bv0xaDFCJuosHpgCApYxiMPYybFc4Swf2dB14oloXd8m/ja0o/SAofcs3ecTPqdJ4Ww1HvokO30IdIUtV2gbrywX0XUoidXmwuXIo1uniAz9CkSyMDKGUbKAp/u8yUilsqfs83tWjpYTiPvQyt9EcCGxO0ISDuI4FJd+vSyigxVnA3jiAFYeXIz",
      ),
    );

    ListInstancesResponse instancesResponse = await service.listInstances();
    List<InstanceSummary>? instacesList = instancesResponse.instanceSummaryList;
    InstanceSummary instance = instacesList!.elementAt(0);

    service.startOutboundVoiceContact(
        contactFlowId: "5974d26c-868f-462c-9a72-7f196858bfbb",
        destinationPhoneNumber: "+1${textController.text}",
        instanceId: instance.id!,
        queueId: "766f3755-ac91-4d4d-81d2-f1374e69a206");
  }
}

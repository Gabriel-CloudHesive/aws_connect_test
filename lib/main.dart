import 'package:flutter/material.dart';
import 'package:aws_connect_api/connect-2017-08-08.dart';
import 'package:shared_aws_api/shared.dart' as s;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: ElevatedButton(onPressed: myAction, child: const Text('Test')),
        ),
      ),
    );
  }

  void myAction() async {
    final service = Connect(
      region: 'ap-southeast-1',
      endpointUrl: "https://connect.ap-southeast-1.amazonaws.com",
      credentials: AwsClientCredentials(
        accessKey: "ASIASJ3TVY5DEKLQMIH5",
        secretKey: "KN+1eUjIlEiB4QYDRLSyU5wx0rMA9Of/O9SU+C7C",
        sessionToken:
            "IQoJb3JpZ2luX2VjEPr//////////wEaCXVzLWVhc3QtMSJHMEUCIEN2ft/mXgTzDB9o6ZLw6C1UfuJoISmdq87TSypRbjKLAiEAo382Zgd3BUiu07vpTOAcrRxWyGrDe8eJPEbOjEtuP74qqgMIw///////////ARABGgwxNTg2MTk1MTg3OTAiDM78e0yrA9xo+ANvgyr+Aj5CKiGDRXcAX4brQqkkhyv4Ha4exJwb70rGvC3sRUPTrmb+hyrvyPdYxDkvVPhsWH5tNQxYN1VD/j6M662tS7udg5wDXOGDw6hqZtkSy5qiOBovGB75LyvZ6dgZ+v6qcESNJ3qBHtYBUew/1Llu07wVyOERa6WZuqARg/X3rUWa8t+GWueIft8rek98BA0zNw1d0GjAxdvTu7IiR3ygVW5V+7J9QjNOVAvgMW4BHCnw6T3P7Jxpg7PpCT7u79/feaHb49cjoEaiv4ZCEUOcQQwgVmKxhVphvoxnqO+gCyW9IzeGa+XbqFCvzVumwGQvv2YvWWfce2+gFGBbNjt5+XUrQ3IJd8qI/W+pF7E7pqQqagxSq6LgVatBtR5W3DkFvNPkVOYm76XPIViwSTasy1c9jUxzdS55DpMzvDKXSXhDWImqOTY41/WNDUccDb6CzhlZQmeJLl7ym5ZPZJa01suKgaeOfzD9ggizsfqYfiTotdY7uOAFCjK2dQplowYw34K+pwY6pgH7jCBxl4b7qBUhO94zS+N7ILHnqndejKjPL7uo+8DysO6KaHzvXwvGsHRnroUAHShQyQ1O68uYEV1O5MzZ5fhHdiBnOZDTvh/OAOMLi1MIvscUI1h4Qex+4k37xRA9fSFsh93q81Ms6Zmcc245m9h4MPf7VLZqzHGuqFTHsYTryM8cWoJCure5EPIdSS5mVUPHGRiscpi4quXrKz/KFrzA2ShlvPxg",
      ),
    );

    ListInstancesResponse inst = await service.listInstances();
    List<InstanceSummary>? summaryList = inst.instanceSummaryList;
    InstanceSummary sum = summaryList!.elementAt(0);
    service.createQuickConnect(
      instanceId: sum.id!,
      name: "QCTest!!!",
      description: "Description test.",
      quickConnectConfig: QuickConnectConfig(
        quickConnectType: QuickConnectType.phoneNumber,
        phoneConfig: PhoneNumberQuickConnectConfig(phoneNumber: "+13054912981"),
      ),
    );
  }
}

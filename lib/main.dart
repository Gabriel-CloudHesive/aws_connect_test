import 'package:flutter/material.dart';
import 'package:aws_connect_api/connect-2017-08-08.dart';

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
          child: ElevatedButton(
            onPressed: myAction,
            child: const Text('Test'),
          ),
        ),
      ),
    );
  }

  void myAction() async {
    final service = Connect(
      region: 'ap-southeast-1',
      endpointUrl: "https://connect.ap-southeast-1.amazonaws.com",
      credentials: AwsClientCredentials(
        accessKey: "ASIASJ3TVY5DLZ6EGNZL",
        secretKey: "lU2LxzFyqREfk2rW6/0/ePMoQefzGQQWRZc3t6kc",
        sessionToken:
            "IQoJb3JpZ2luX2VjEA4aCXVzLWVhc3QtMSJGMEQCIHikqfcRQrQZmik5TBedrfLDZaQpR9HFQzoeyZVIvzECAiAEIP1TSEwC4zm7+gJu92R3idWS8YnKred+MBqB4ta+iSqqAwjX//////////8BEAEaDDE1ODYxOTUxODc5MCIM/fiT0IIeyoAUFCQ0Kv4CqPRmgggxJ4OuWHOJ4voF4b2n6dvwz/CcF9cUfmu0I2g17LVA5wa+b0U+rT+Zt3IyZypLi3b3bPTpiTTZCg9DJ8mspOwlNitR+s12OIXbqlGPPdM2WXdCo6g00m++l3eiS6/qqsVBrdtOYNLU2IJ6Jvr5NHs1OrEvCHQxPadhBxHpA77KR4p6/E19TB6jpq89uPaXL+HbKa+6heaZafBv0d+1T031SrEf/l0jiolcTn0jd6cND770nQWKJNgijx147ynyTBDN1jaUQB7XKuH3HKSCeGDzzBeheSZZ6AHc+GWUJGQIRnTKGEHM5enMoO9AsU1dsYgTKO14mEBl1+JxDMksORPuBqmIDTi4yHSHq8ySkOL+ES24J/qt+YWGCi/7ekKw716HcB1e+TTrM3aHS2j+Vo0hfDM4KEW4fj8upsO/Ax9aQspQcn4gUwMZoS5V3W5wtZ7IbA+NE5802iTTE6cbbG1hlJ620JjmQEIkxGYCU7bVbouec63H9sjpGzC2qMKnBjqnAeqWllNJz4dW7DQWNoEfrYFhnj9hcH88bdX5+qdFh/T072jc5HBEabCkL7zs5a18j/JWIGO0Jbo5W1U1m8dvqeD12+twD7YsqZWJmXtM0bgLrB7A+ud5vvL3dB++vKysINwV4k7cxEiDXZ56AMVRuPSxySb29vS+EPJDUDD8Z6V+eYEuyu0JJqO/TIMBdS8LIeiaK8OLDkrIFFZSxu+kYqYHoHRhKDjT",
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

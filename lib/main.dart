import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Platform specific code'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform=const MethodChannel('flutter.native/helper');

  String response='';
  String _responseFromNativeCode='Waiting for response....';

  Future<void> callPlatformSpecificCode()async{
    try{
      final String result=await platform.invokeMethod('helloFromNativeCode');
      response=result;
    }on PlatformException catch(e){
      response='Failed to Invoke: ${e.message}';
    }

    setState(() {
      _responseFromNativeCode=response;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(_responseFromNativeCode),
            ElevatedButton(onPressed: callPlatformSpecificCode,
                child: Text('Call Native Method'))
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

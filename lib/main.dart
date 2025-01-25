import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screen_send_request/send_requests/Provider/send_request_provider.dart';
import 'package:screen_send_request/send_requests/page/screen_send_request.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SendRequestProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: RequestCreationScreen(),
        locale: Locale('ar'),
      ),
    );
  }
}

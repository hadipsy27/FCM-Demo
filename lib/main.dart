import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      // Rory
      // apiKey: "AIzaSyCcdNsuQXpcFcZ5F9j1iywNhYb249Bm7fk",
      // appId: "1:728075040437:android:bc222c28cc82754548f0fc",
      // messagingSenderId: "728075040437",
      // projectId: "bni-merchant-development",

      // Hadi
      // apiKey: "AIzaSyDTMmNqJ790JLR0gPG2MMgOoZElNiE0Xqc",
      // appId: "1:635472076618:android:936dea160f40d67ac0abb3",
      // messagingSenderId: "635472076618",
      // projectId: "merchant-development-bni",

      apiKey: "AIzaSyCzBcMi2trGPkimHruffot4m7iX95S422Y",
      appId: "1:22172628822:android:d0666a315570781ade08f7",
      messagingSenderId: "22172628822",
      projectId: "bni-merchant-flutter-d2e9a",
    ),
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message: ${message.messageId}');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   void initState() {
//     super.initState();

//     FirebaseMessaging.instance.getToken().then((token) {
//       print("FCM Token: $token");
//     });

//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print('Got a message whilst in the foreground!');
//       print('Message data: ${message.data}');

//       if (message.notification != null) {
//         print('Message also contained a notification: ${message.notification}');
//         _showNotification(message.notification!);
//       }
//     });

//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print('Message clicked!');
//     });
//   }

//   void _showNotification(RemoteNotification notification) {
//     showDialog(
//       context: context,
//       builder: (_) {
//         return AlertDialog(
//           title: Text(notification.title ?? ''),
//           content: Text(notification.body ?? ''),
//         );
//       },
//     );
//   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('FCM Example'),
// //       ),
// //       body: const Center(
// //         child: Image.asset(‘assets/images/my_image.png’),
// //         child: Text('Waiting for notifications...'),
// //       ),
// //     );
// //   }
// // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('FCM Example'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(
//                 'assets/img/3d-glassy-plush-blue-creature-with-playful-eyes-and-a-quirky-grin.png'),
//             SizedBox(
//                 height: 20), // Add some space between the image and the text
//             const Text('Waiting for notifications...'),
//           ],
//         ),
//       ),
//     );
//   }

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    FirebaseMessaging.instance.getToken().then((token) {
      print("FCM Token: $token");
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        _showNotification(message.notification!, message.data);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message clicked!');
    });
  }

  void _showNotification(
      RemoteNotification notification, Map<String, dynamic> data) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(notification.title ?? 'No Title'),
          content: Text('${notification.body ?? 'No Body'}\n'
              'Transaction Date and Time: ${data['transactionDate']} ${data['transactionTime']}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BNI Merchant'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
                'assets/img/3d-glassy-plush-blue-creature-with-playful-eyes-and-a-quirky-grin.png'),
            SizedBox(
                height: 20), // Add some space between the image and the text
            const Text('Waiting for notifications...'),
          ],
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vato/SplashScreen.dart';
import 'package:vato/constants/light_colors.dart';
import 'package:vato/screens/CompanyScreen/company_screen.dart';
import 'package:vato/screens/Login/SignInScreen.dart';
import 'package:vato/services/API.dart';
import 'package:vato/services/OperationsService.dart';
import 'package:vato/widgets/navBar.dart';

import 'constants/constants.dart';
import 'utils/isnotified.dart' as globals;

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

final apiProvider = Provider((ref) => API());
Future<void> main() async {
  /* HttpOverrides.global = MyHttpOverrides();

  WidgetsFlutterBinding.ensureInitialized();
  OperationService _operationService = new OperationService();
  AwesomeNotifications().initialize(
    a+q < // set the icon to null if you want to use the default app icon
      'resource://drawable/icon',
      [
        NotificationChannel(
            channelKey: 'big_picture',
            channelName: 'Big pictures',
            channelDescription: 'Notifications with big and beautiful images',
            defaultColor: Color(0xFF9D50DD),
            ledColor: Color(0xFF9D50DD),
            vibrationPattern: lowVibrationPattern),
        NotificationChannel(
          channelKey: 'basic_channel',
          channelDescription: 'Simple Notification',
        ),
      ]
  );

  String res;

  FirebaseApp firebaseApp = await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await AwesomeNotifications().actionStream.listen((event) {

_operationService.checkoutParking(event.createdDate.toString()).then((value) => print(value.toString()));
  });
  */

  runApp(ProviderScope(child: MyApp()));
}
/*
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  await Firebase.initializeApp();

  print("Handling a background message: ${message.data.toString()}");


  if(
  !StringUtils.isNullOrEmpty(message.notification?.title, considerWhiteSpaceAsEmpty: true) ||
      !StringUtils.isNullOrEmpty(message.notification?.body, considerWhiteSpaceAsEmpty: true)
  ){
    print('message also contained a notification: ${message.notification}');

    String imageUrl;
    imageUrl ??= message.notification.android?.imageUrl;
    imageUrl ??= message.notification.apple?.imageUrl;

    Map<String, dynamic> notificationAdapter = {
      NOTIFICATION_CHANNEL_KEY: 'basic_channel',
      NOTIFICATION_ID:
      message.data[NOTIFICATION_CONTENT]??[NOTIFICATION_ID] ??
          message.messageId ??
          Random().nextInt(2147483647),
      NOTIFICATION_TITLE:
      message.data[NOTIFICATION_CONTENT]??[NOTIFICATION_TITLE] ??
          message.notification?.title,
      NOTIFICATION_BODY:
      message.data[NOTIFICATION_CONTENT]??[NOTIFICATION_BODY] ??
          message.notification?.body ,
      NOTIFICATION_LAYOUT:
      StringUtils.isNullOrEmpty(imageUrl) ? 'Default' : 'BigPicture',
      NOTIFICATION_BIG_PICTURE: imageUrl
    };

    AwesomeNotifications().createNotificationFromJsonData(notificationAdapter);
  }
  else {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 10,
            channelKey: 'basic_channel',
            title: jsonDecode(message.data["content"])["title"],
            body: jsonDecode(message.data["content"])["body"],
            createdDate: jsonDecode(message.data["content"])["payload"]["id"]
                .toString()
          //  payload: valueMap
          //  ticker:  jsonDecode(message.data["content"])["ticker"],
        ), actionButtons: [
      NotificationActionButton(key: "YES", label: "YES",),
      NotificationActionButton(key: "NO", label: "NO"),
    ]
    );
  }
  }


// Declared as global, outside of any class

/// Global variables
/// * [GlobalKey<NavigatorState>]
class GlobalVariable {

  /// This global key is used in material app for navigation through firebase notifications.
  /// [navState] usage can be found in [notification_notifier.dart] file.
  static final GlobalKey<NavigatorState> navState = GlobalKey<NavigatorState>();
}
*/

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey(debugLabel: "Main Navigator");

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: "Workpoint",
      theme: ThemeData(primaryColor: LightColors.kDarkBlue),
      routes: <String, WidgetBuilder>{
        //   SIGN_IN: (BuildContext context) => SignInScreen(),
        Splashscreen: (BuildContext context) => SplashScreen(),
        //  "request": (BuildContext context) => navigationScreen(1,null,null,0,"Teamrequests",null,"Teamrequests")
      },
      home: SplashScreen(),
    );
  }
  /*
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  //Stream<RemoteMessage> _firebaseMessaging = FirebaseMessaging.onMessage;

  FlutterLocalNotificationsPlugin fltNotification;
  void pushFCMtoken() async {
    String token=await messaging.getToken();
  }
  @override
  void initState() {
    initMessaging();

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      if (message != null) {

        return   Navigator.push(
            navigatorKey.currentState.context,
            MaterialPageRoute(
                builder: (context) => navigationScreen(1,null,null,0,"Teamrequests",null,"Teamrequests")));
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      setState(() {
        globals.isnotified = true;
        globals.countnotified = globals.countnotified + 1;
      });
      if (message.data["screen"]=="team") {
        return  Navigator.push(
            navigatorKey.currentState.context,
            MaterialPageRoute(
                builder: (context) => navigationScreen(
                    1, null, null, 0, "Teamrequests", null, "Teamrequests")));
      }
      else if (message.data["screen"]=="myrequest") {
        return Navigator.push(
            navigatorKey.currentState.context,
            MaterialPageRoute(
                builder: (context) =>
                    navigationScreen(
                        1,
                        null,
                        null,
                        0,
                        "Myrequests",
                        null,
                        "Myrequests")));
      }
      else {
        return  Navigator.push(
            navigatorKey.currentState.context,
            MaterialPageRoute(
                builder: (context) => SplashScreen()));
      }
    });

    pushFCMtoken();
    super.initState();

  }

  void initMessaging() {
    var androiInit = AndroidInitializationSettings('@mipmap/ic_launcher');//for logo
    var iosInit = IOSInitializationSettings();
    var initSetting=InitializationSettings(android: androiInit,iOS:
    iosInit);
    fltNotification = FlutterLocalNotificationsPlugin();
    fltNotification.initialize(initSetting,onSelectNotification: (String payload)async{
      return Navigator.push(
          navigatorKey.currentState.context,
          MaterialPageRoute(
              builder: (context) => navigationScreen(1,null,null,0,"Teamrequests",null,"Teamrequests")));
    });
    var androidDetails =
    AndroidNotificationDetails('1', 'channelName', 'channel Description');
    var iosDetails = IOSNotificationDetails();
    var generalNotificationDetails =
    NotificationDetails(android: androidDetails, iOS: iosDetails);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {     RemoteNotification notification=message.notification;
    AndroidNotification android=message.notification?.android;
    if(notification!=null && android!=null){
      //  fltNotification.show(
      // notification.hashCode, notification.title, notification.
      // body, generalNotificationDetails);
      fltNotification.show(
          notification.hashCode, notification.title, notification.body, generalNotificationDetails,payload: "Notification");
    }
    setState(() {
      globals.isnotified = true;
      globals.countnotified = globals.countnotified + 1;
    });
    });
  }
*/
}

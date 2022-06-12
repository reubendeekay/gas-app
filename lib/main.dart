import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gas/constants.dart';
import 'package:gas/firebase_options.dart';
import 'package:gas/providers/auth_provider.dart';
import 'package:gas/providers/location_provider.dart';
import 'package:gas/screens/auth/login.dart';
import 'package:gas/screens/home/homepage.dart';
import 'package:gas/widgets/loading_screen.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => LocationProvider()),
        ChangeNotifierProvider(create: (ctx) => AuthProvider()),
      ],
      child: GetMaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primaryColor: kIconColor,
              appBarTheme: AppBarTheme(
                iconTheme: const IconThemeData(
                  color: Colors.black,
                ),
                backgroundColor: Colors.transparent,
                toolbarTextStyle: TextTheme(
                  headline6: GoogleFonts.poppins(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ).bodyText2,
                titleTextStyle: TextTheme(
                  headline6: GoogleFonts.poppins(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ).headline6,
              ),
              textTheme: GoogleFonts.ibmPlexSansTextTheme()),
          home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? const InitialLoadingScreen()
                    : const LoginPage();
              })),
    );
  }
}

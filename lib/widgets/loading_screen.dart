import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gas/models/request_model.dart';
import 'package:gas/providers/auth_provider.dart';
import 'package:gas/providers/gas_providers.dart';
import 'package:gas/providers/location_provider.dart';
import 'package:gas/screens/home/homepage.dart';
import 'package:gas/screens/home/main_page.dart';
import 'package:gas/screens/trail/trail_screen.dart';
import 'package:get/route_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class InitialLoadingScreen extends StatefulWidget {
  const InitialLoadingScreen({Key? key}) : super(key: key);

  @override
  State<InitialLoadingScreen> createState() => InitialLoadingScreenState();
}

class InitialLoadingScreenState extends State<InitialLoadingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
      await Provider.of<AuthProvider>(context, listen: false).getCurrentUser();
      await Provider.of<LocationProvider>(context, listen: false)
          .getCurrentLocation();

      await Provider.of<GasProviders>(context, listen: false).getAllProviders();

      Get.offAll(() => const MainPage());
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: size.height,
            width: size.width,
            child: Image.asset(
              'assets/images/delivery.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: size.height,
            width: size.width,
            color: Colors.white.withOpacity(0.9),
            child: Center(
              child: SizedBox(
                height: 200,
                width: 200,
                child: Lottie.asset('assets/loading.json'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

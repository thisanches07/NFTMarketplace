import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nftmarketplace/utils/dimensions.dart';

import '../../controllers/popular_nft_controller.dart';
import '../../controllers/recommended_nft_controller.dart';
import '../../routes/route_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  late Animation<double> animation;
  late AnimationController controller;

  Future<void> _loadResource() async{
    await Get.find<PopularNftController>().getPopularNftList();
    await Get.find<RecommendedNftController>().getRecommendedNftList();
  }

  @override
  void initState(){
    super.initState();
    _loadResource();
    controller = new AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2))..forward();

    animation = new CurvedAnimation(
        parent: controller,
        curve: Curves.linear);
    Timer(
      Duration(seconds: 3),
        ()=>Get.offNamed(RouteHelper.getInitial())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(scale: animation,
          child: Center(child: Image.asset("assets/image/NFTLogo1.png", width: Dimensions.splashImg,))),
          Center(child: Image.asset("assets/image/NFTLogo2.png", width: Dimensions.splashImg,))
        ],
      ),
    );
  }
}

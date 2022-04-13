import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nftmarketplace/controllers/popular_nft_controller.dart';
import 'package:nftmarketplace/pages/home/main_nft_page.dart';
import 'package:nftmarketplace/routes/route_helper.dart';
import 'controllers/recommended_product_controller.dart';
import 'helper/dependencies.dart' as dep;
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<PopularNftController>().getPopularNftList();
    Get.find<RecommendedNftController>().getRecommendedNftList();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',

      home: MainNFTPage(),
      initialRoute: RouteHelper.initial,
      getPages: RouteHelper.routes,
    );
  }
}


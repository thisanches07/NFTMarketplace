import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nftmarketplace/controllers/popular_nft_controller.dart';
import 'package:nftmarketplace/pages/home/main_nft_page.dart';
import 'package:nftmarketplace/pages/home/nft_page_body.dart';
import 'package:nftmarketplace/pages/nft/popular_nft_detail.dart';
import 'package:nftmarketplace/pages/nft/recommended_nft_detail.dart';
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
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainNFTPage(),
    );
  }
}


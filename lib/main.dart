import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nftmarketplace/pages/nft/popular_nft_detail.dart';
import 'package:nftmarketplace/pages/nft/recommended_nft_detail.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PopularNftDetail(),
    );
  }
}


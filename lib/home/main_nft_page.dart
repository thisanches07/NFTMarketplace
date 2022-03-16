import 'package:flutter/material.dart';
import 'package:nftmarketplace/home/nft_page_body.dart';
import 'package:nftmarketplace/utils/colors.dart';
import 'package:nftmarketplace/widgets/big_text.dart';
import 'package:nftmarketplace/widgets/small_text.dart';

class MainNFTPage extends StatefulWidget {
  const MainNFTPage({Key? key}) : super(key: key);

  @override
  _MainNFTPageState createState() => _MainNFTPageState();
}

class _MainNFTPageState extends State<MainNFTPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top:45,bottom: 15),
              padding: EdgeInsets.only(left: 20,right: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Column(
                      children: [
                        BigText(text: "Marketplace", color: AppColors.mainColor),
                        Row(
                          children: [
                            SmallText(text: "Brazil", color: Colors.black54,),
                            Icon(Icons.arrow_drop_down_rounded)

                          ],
                        )
                      ],
                    ),
                    Center(
                      child: Container(
                        width: 45,
                        height: 45,
                        child: Icon(Icons.search, color: Colors.white),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColors.mainColor,
                        ),
                      ),
                    )
                  ]
              )
          ),
          NftPageBody(),
        ],
      ),
    );
  }
}

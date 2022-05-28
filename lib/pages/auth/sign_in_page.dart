import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nftmarketplace/pages/auth/sign_up_page.dart';
import 'package:nftmarketplace/utils/colors.dart';
import 'package:nftmarketplace/utils/dimensions.dart';
import 'package:nftmarketplace/widgets/app_text_field.dart';
import 'package:nftmarketplace/widgets/big_text.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  @override
  Widget build(BuildContext context){
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: Dimensions.screenHeight*0.05),
            Container(
              height: Dimensions.screenHeight*0.25,
              child: Center(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 80,
                  backgroundImage: AssetImage(
                    "assets/image/NFTLogo1.png"
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: Dimensions.width20),
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello",
                    style: TextStyle(
                      fontSize: Dimensions.font20*3+Dimensions.font20/2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Sign into your account",
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: Dimensions.font20,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: Dimensions.height20),
            AppTextField(
              textController: emailController,
              hintText: "Email",
              icon: Icons.email
            ),
            SizedBox(height: Dimensions.height20),
            AppTextField(
              textController: passwordController,
              hintText: "Password",
              icon: Icons.password_sharp
            ),
            SizedBox(height: Dimensions.height10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RichText(
                  text: TextSpan(
                    text: "Sign into your account",
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: Dimensions.font20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(width: Dimensions.screenWidth*0.05)
              ],
            ),
            SizedBox(height: Dimensions.height20+Dimensions.height20),
            Container(
              width: Dimensions.screenWidth/2,
              height: Dimensions.screenHeight/13,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: AppColors.mainColor
              ),
              child: Center (
                child: BigText(
                  text: "Sign In",
                  size: Dimensions.font20+Dimensions.font20/2,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: Dimensions.height20),
            RichText(
              text: TextSpan(
                text: "Don\'t have am account? ",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: Dimensions.font20,
                  fontWeight: FontWeight.w500
                ),
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()..onTap=()=>Get.to(() => SignUpPage(), transition: Transition.fade),
                    text: "Create",
                    style: TextStyle(
                      color: AppColors.mainBlackColor,
                      fontSize: Dimensions.font20,
                      fontWeight: FontWeight.bold
                    )
                  )
                ]
              ),
            ),
            SizedBox(height: Dimensions.height30),
          ],
        ),
      ),
    );
  }
}
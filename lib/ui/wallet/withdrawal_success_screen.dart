import 'package:canine_castle_mobile/providers/auth_provider.dart';
import 'package:canine_castle_mobile/resources/constants/dimension_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../Widgets/components.dart';
import '../../Widgets/custom_text.dart';
import '../../providers/wallet_provider.dart';
import '../../resources/constants/color_constants.dart';
import '../../resources/constants/font_constants.dart';
import '../../resources/constants/image_constant.dart';

class WithdrawalSuccessScreen extends StatefulWidget {
  const WithdrawalSuccessScreen({super.key});

  @override
  State<WithdrawalSuccessScreen> createState() =>
      _WithdrawalSuccessScreenState();
}

class _WithdrawalSuccessScreenState extends State<WithdrawalSuccessScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      Future.delayed(const Duration(seconds: 3), () {
        authProvider.getProfile(context: context);
        setState(() {
          // Here you can write your code for open new view
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<WalletProvider>(builder: (ctx, walletProvider, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.38),
                child: Column(
                  children: [
                    SvgPicture.asset(success),
                    const BodyTextPrimaryWithLineHeight(
                      text: 'Success',
                      textColor: black,
                      fontSize: 23,
                      fontWeight: boldFont,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      child: BodyTextPrimaryWithLineHeight(
                        text: 'Your withdrawal has been successfully  placed',
                        textColor: black,
                        fontWeight: semiBoldFont,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(child: Consumer2<WalletProvider, AuthProvider>(
                        builder: (ctx, walletProvider, authProvider, child) {
                      return MainButton('Done', fontSize: 14, () {
                        authProvider.getProfile(context: context);
                        walletProvider.getTransactions(context: context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      });
                    })),
                  ],
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}

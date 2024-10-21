import 'package:canine_castle_mobile/providers/auth_provider.dart';
import 'package:canine_castle_mobile/resources/constants/dimension_constants.dart';
import 'package:canine_castle_mobile/utils/constants.dart';
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

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
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
          return walletProvider.verifyingTransaction
              ? const Center(child: CupertinoActivityIndicator())
              : !walletProvider.transactionVerified
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.38),
                          child: Column(
                            children: [
                              SvgPicture.asset(success),
                              const CustomText(
                                text: 'UnSuccessful',
                                textColor: black,
                                fontSize: 23,
                                fontWeight: boldFont,
                              ),
                              const CustomText(
                                text: 'Transaction failed',
                                textColor: black,
                                fontWeight: semiBoldFont,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: horizontalPadding.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  child:
                                      MainButton('Try Again', fontSize: 14, () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              })),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.38),
                          child: Column(
                            children: [
                              SvgPicture.asset(success),
                              const CustomText(
                                text: 'Success',
                                textColor: black,
                                fontSize: 23,
                                fontWeight: boldFont,
                              ),
                              CustomText(
                                text:
                                    'You added a sum of NGN${moneyFormat.format(double.parse(walletProvider.amountController.text.replaceAll(",", "")))} to your wallet',
                                textColor: black,
                                fontWeight: semiBoldFont,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: horizontalPadding.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(child:
                                  Consumer2<WalletProvider, AuthProvider>(
                                      builder: (ctx, walletProvider,
                                          authProvider, child) {
                                return MainButton('Done', fontSize: 14, () {
                                  authProvider.getProfile(context: context);
                                  walletProvider.getTransactions(
                                      context: context);
                                  Navigator.pop(context);
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

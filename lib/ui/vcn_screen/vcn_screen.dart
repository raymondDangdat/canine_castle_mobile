import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../resources/constants/color_constants.dart';
import '../../Widgets/title_widget.dart';
import '../../providers/auth_provider.dart';
import '../../resources/constants/dimension_constants.dart';
import '../../widgets/components.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_snack_back.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/label_widget.dart';
import '../../widgets/textfields.dart';
import 'modals/vet_professionals_how_it_works_modal.dart';

class VCNVerificationScreen extends StatefulWidget {
  const VCNVerificationScreen({Key? key}) : super(key: key);
  @override
  State<VCNVerificationScreen> createState() => _VCNVerificationScreenState();
}

class _VCNVerificationScreenState extends State<VCNVerificationScreen> {
  final vcnController = TextEditingController();

  bool obscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: SafeArea(
          bottom: false,
          child: Consumer<AuthProvider>(builder: (ctx, authProvider, child) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (authProvider.resMessage != '') {
                customSnackBar(context, authProvider.resMessage);

                ///Clear the response message to avoid duplicate
                authProvider.clear();
              }
            });
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: topPadding.h,
                ),
                const CustomAppbar(title: "Vet verification"),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: SingleChildScrollView(
                  padding:
                      EdgeInsets.symmetric(horizontal: horizontalPadding.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TitleWidget(
                        title: "Enter VCN",
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      const BodyTextLightWithLineHeight(
                          text:
                              "The Veterinary Council Number (VCN) verifies that you're a licensed vet practicing in Nigeria."),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 16.h,
                          ),
                          const LabelWidget(label: "Enter your VCN"),
                          Row(
                            children: [
                              Expanded(
                                child: CustomField(
                                  "Enter your Veterinary Council Number",
                                  vcnController,
                                  isCapitalizeSentence: false,
                                  type: TextInputType.emailAddress,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 19.h,
                      ),
                      authProvider.isLoading
                          ? const Center(child: CupertinoActivityIndicator())
                          : MainButton(
                              "Submit",
                              () async {
                                if (!authProvider.isDogOwner &&
                                    vcnController.text.trim().length < 4) {
                                  customSnackBar(
                                    context,
                                    "Please enter a valid VCN",
                                  );
                                } else {
                                  showVetProfessionalHowItWorksModal(context);
                                }
                              },
                            ),
                      SizedBox(
                        height: 8.h,
                      ),
                      SizedBox(
                        height: bottomPadding.h,
                      )
                    ],
                  ),
                )),
              ],
            );
          })),
    );
  }
}

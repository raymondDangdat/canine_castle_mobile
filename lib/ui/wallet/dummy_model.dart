import 'dart:ui';

import '../../resources/constants/color_constants.dart';
import '../../resources/constants/image_constant.dart';

class WalletModel {
  final String pic;
  final String title;
  final String subtitle;
  final String amount;
  final Color colorStatus;

  WalletModel({
    required this.pic,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.colorStatus,
  });
}

final List<dynamic> walletData = [
  WalletModel(
      pic: withdrawIcon,
      title: 'Withdrawal',
      subtitle: '01/23/2024    |    3:09 PM',
      amount: '- 150,000',
      colorStatus: red),
  WalletModel(
    pic: depositIcon,
    title: 'Deposit',
    subtitle: '01/23/2024 3:09 PM',
    amount: '+ 150,000',
    colorStatus: greenShade,
  ),
  WalletModel(
    pic: dogImg,
    title: 'Billy',
    subtitle: 'Puppy deal  | 01/23/2024',
    amount: '+ 150,000',
    colorStatus: greenShade,
  ),
  WalletModel(
      pic: dogOliver,
      title: 'Oliver',
      subtitle: 'No puppy deal',
      amount: '- 150,000',
      colorStatus: red),
  WalletModel(
      pic: dogImg,
      title: 'Oliver',
      subtitle: 'Puppy deal',
      amount: '+ 150,000',
      colorStatus: greenShade),
  WalletModel(
      pic: dogOliver,
      title: 'Oliver',
      subtitle: 'No puppy deal',
      amount: '- 150,000',
      colorStatus: red),
  WalletModel(
      pic: dogImg,
      title: 'Oliver',
      subtitle: 'Puppy deal',
      amount: '+ 150,000',
      colorStatus: greenShade),
];

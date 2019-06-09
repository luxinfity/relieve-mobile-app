import 'package:flutter/material.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';
import 'package:relieve_app/res/res.dart';
import 'package:relieve_app/widget/common/relieve_scaffold.dart';
import 'package:relieve_app/widget/common/standard_button.dart';
import 'package:relieve_app/widget/screen/dashboard/dashboard.dart';

class WalkthroughScreen extends StatefulWidget {
  WalkthroughScreen({Key key}) : super(key: key);

  @override
  _WalkthroughScreenState createState() => _WalkthroughScreenState();
}

const WALKTHROUGH_SIZE = 4;

class _WalkthroughScreenState extends State<WalkthroughScreen> {
  int _counter = 1;

  final PageController _controller = PageController();

  void _moveToNext(BuildContext context) {
    if (_counter < WALKTHROUGH_SIZE - 1) {
      _controller.nextPage(
          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (builder) => DashboardScreen()),
      );
    }
  }

  void onPageChanged(int page) {
    if (_counter < WALKTHROUGH_SIZE) {
      setState(() {
        _counter = page;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsets padding = MediaQuery.of(context).padding;
    final walkThroughItem = [
      buildWalkthroughItem(0),
      buildWalkthroughItem(1),
      buildWalkthroughItem(2),
      buildWalkthroughItem(3),
    ];
    return RelieveScaffold(
      crossAxisAlignment: CrossAxisAlignment.start,
      childs: <Widget>[
        Expanded(
          child: PageView(
            controller: _controller,
            scrollDirection: Axis.horizontal,
            onPageChanged: onPageChanged,
            children: walkThroughItem,
          ),
        ),
        Center(
          child: buildPageIndicator(walkThroughItem.length),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: Dimen.x16 + padding.bottom),
          child: buildActionButton(context),
        )
      ],
    );
  }

  PageIndicator buildPageIndicator(int count) {
    return PageIndicator(
      layout: PageIndicatorLayout.WARM,
      size: Dimen.x8,
      controller: _controller,
      count: count,
      color: AppColor.colorEmptyRect,
      activeColor: AppColor.colorPrimary,
    );
  }

  Container buildWalkthroughItem(int position) {
    return Container(
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          fetchImage(position),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimen.x28),
            child: buildWalkthroughTitle(position),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: Dimen.x28, right: Dimen.x28, top: Dimen.x16),
            child: buildWalkthroughText(position),
          ),
        ],
      )),
      width: double.infinity,
    );
  }

  Widget fetchImage(int position) {
    switch (position) {
      case 0:
        return RemoteImage.walkthrough1.toImage(
          height: 350,
          width: 350,
        );
      case 1:
        return RemoteImage.walkthrough2.toImage(
          height: 350,
          width: 350,
        );
      case 2:
        return RemoteImage.walkthrough3.toImage(
          height: 350,
          width: 350,
        );
      default:
        return RemoteImage.walkthrough4.toImage(
          height: 350,
          width: 350,
        );
    }
  }

  Text buildWalkthroughTitle(int position) {
    switch (position) {
      case 0:
        return Text(
          'Pastikan data yang kamu input sudah benar',
          textAlign: TextAlign.center,
          style: CircularStdFont.bold.getStyle(size: Dimen.x18),
        );
      case 1:
        return Text(
          'Tambakan keluarga mu ke dalam daftar kerabat',
          textAlign: TextAlign.center,
          style: CircularStdFont.bold.getStyle(size: Dimen.x18),
        );
      case 2:
        return Text(
          'Laporkan kondisi mu setiap hari!',
          textAlign: TextAlign.center,
          style: CircularStdFont.bold.getStyle(size: Dimen.x18),
        );
      default:
        return Text(
          'Tetap tenang, dalam keadaan darurat',
          textAlign: TextAlign.center,
          style: CircularStdFont.bold.getStyle(size: Dimen.x18),
        );
    }
  }

  Text buildWalkthroughText(int position) {
    switch (position) {
      case 0:
        return Text(
            'Data yang benar dan lengkap dapat mempermudah keluarga mu untuk menghubungi dan mengidetifikasi dirimu',
            textAlign: TextAlign.center);
      case 1:
        return Text(
            'Jangan sampai kamu ketinggalan berita terkini dari keluarga mu, Ayo tambahkan semua dan pantau setiap hari',
            textAlign: TextAlign.center);
      case 2:
        return Text(
            'Selalu berikan berita terkini mengenai dirimu, cukup 3 kali klik dan hilangkan kecemasan keluarga mu',
            textAlign: TextAlign.center);
      default:
        return Text(
            'Semua nomor emergency dapat kamu temukan dalam aplikasi, tetap tenang, tetap semangat! ',
            textAlign: TextAlign.center);
    }
  }

  StandardButton buildActionButton(BuildContext context) {
    return StandardButton(
      text: (_counter < WALKTHROUGH_SIZE - 1) ? 'Mengerti' : 'Ayo mulai!',
      backgroundColor: AppColor.colorPrimary,
      buttonClick: () => _moveToNext(context),
    );
  }
}

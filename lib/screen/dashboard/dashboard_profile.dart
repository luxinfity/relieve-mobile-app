import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../res/res.dart';
import '../../service/model/family.dart';
import '../../widget/item/user_location.dart';
import 'package:relieve_app/screen/boarding/boarding_home.dart';
import '../../utils/preference_utils.dart' as pref;

class DashboardProfileScreen extends StatelessWidget {
  void onLogout(BuildContext context) {
    pref.clearData();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (builder) => BoardingHomeScreen()),
      (_) => false, // clean all back stack
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.all(0),
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                color: AppColor.colorPrimary,
                height: 257,
                margin: EdgeInsets.only(bottom: Dimen.x28),
              ),
              Positioned(
                left: 1,
                right: 1,
                bottom: 1,
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: Dimen.x4,
                          color: Colors.white,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        radius: Dimen.x36 + Dimen.x16,
                        backgroundColor: AppColor.colorAccent,
                        backgroundImage: NetworkImage(
                            'https://blue.kumparan.com/kumpar/image/upload/fl_progressive,fl_lossy,c_fill,q_auto:best,w_640/v1511853177/jedac0gixzhcnuozw7c4.jpg'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: Dimen.x16,
                        bottom: Dimen.x21,
                      ),
                      child: Text(
                        'Muhammad Alif Akbar',
                        style: CircularStdFont.medium.getStyle(
                          size: Dimen.x21,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimen.x21,
                      ),
                      child: UserLocation(
                        location: 'Sukajadi, Bandung',
                        icon: LocalImage.ic_location,
                        personHealth: PersonHealth.None,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          _buildTitle('Pengaturan', 'Ubah pengaturan pada aplikasi relieve'),
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: Dimen.x16,
                    right: Dimen.x8,
                  ),
                  child: _buildButton(LocalImage.ic_user, 'Profil dan password',
                      axis: Axis.vertical),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: Dimen.x16,
                    left: Dimen.x8,
                  ),
                  child: _buildButton(
                      LocalImage.ic_notif, 'Notifkasi dan getar',
                      axis: Axis.vertical),
                ),
              ),
            ],
          ),
          Container(height: Dimen.x14),
          _buildTitle('Lainnya', 'Temukan informasi lainnya tentang relieve'),
          Padding(
            padding: const EdgeInsets.only(
              left: Dimen.x16,
              right: Dimen.x16,
              bottom: Dimen.x8,
            ),
            child: _buildButton(
              LocalImage.ic_faq,
              'Bantuan dan FAQ',
              onClick: () {
                launch('https://github.com/RelieveID/terms-and-conditions/');
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: Dimen.x16,
              right: Dimen.x16,
              bottom: Dimen.x8,
            ),
            child: _buildButton(
              LocalImage.ic_syarat,
              'Syarat-syarat dan kondisi',
              onClick: () {
                launch('https://github.com/RelieveID/terms-and-conditions/');
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: Dimen.x16,
              right: Dimen.x16,
              bottom: Dimen.x8,
            ),
            child: _buildButton(
              LocalImage.ic_privacy,
              'Privasi dan kebijakan',
              onClick: () {
                launch('https://github.com/RelieveID/terms-and-conditions/');
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: Dimen.x16,
              right: Dimen.x16,
              bottom: Dimen.x8,
            ),
            child: _buildButton(
              LocalImage.ic_info_contributor,
              'Tentang relieve dan kontributor',
              onClick: () {
                launch('https://github.com/RelieveID/terms-and-conditions/');
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: Dimen.x16,
              right: Dimen.x16,
              top: Dimen.x24,
              bottom: Dimen.x32,
            ),
            child: _buildButton(
              LocalImage.ic_exit,
              'Keluar',
              isExit: true,
              onClick: () => onLogout(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.all(Dimen.x16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: CircularStdFont.bold.getStyle(
              size: Dimen.x14,
              color: AppColor.colorTextBlack,
            ),
          ),
          Text(
            subtitle,
            style: CircularStdFont.book.getStyle(
              size: Dimen.x11,
              color: AppColor.colorTextGrey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(
    LocalImage icon,
    String title, {
    Axis axis = Axis.horizontal,
    bool isExit = false,
    VoidCallback onClick,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(Dimen.x6),
      onTap: onClick,
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: Dimen.x12, vertical: Dimen.x18),
        decoration: BoxDecoration(
          border: Border.all(
            color: isExit ? AppColor.colorDanger : AppColor.colorEmptyChip,
          ),
          borderRadius: BorderRadius.circular(Dimen.x6),
        ),
        child: Wrap(
          direction: axis,
          spacing: (axis == Axis.horizontal) ? Dimen.x12 : Dimen.x6,
          children: <Widget>[
            icon.toSvg(
              width: Dimen.x18,
              color: isExit ? AppColor.colorDanger : null,
            ),
            Text(
              title,
              style: CircularStdFont.book.getStyle(
                size: Dimen.x12,
                color: isExit ? AppColor.colorDanger : AppColor.colorTextBlack,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../res/res.dart';
import '../../service/model/family.dart';
import '../../widget/item/user_location.dart';

class DashboardProfileScreen extends StatelessWidget {
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
                  child: _buildButton(LocalImage.ic_notif, 'Notifkasi dan getar',
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
            child: _buildButton(LocalImage.ic_faq, 'Bantuan dan FAQ'),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: Dimen.x16,
              right: Dimen.x16,
              bottom: Dimen.x8,
            ),
            child: _buildButton(LocalImage.ic_syarat, 'Syarat-syarat dan kondisi'),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: Dimen.x16,
              right: Dimen.x16,
              bottom: Dimen.x8,
            ),
            child: _buildButton(LocalImage.ic_privacy, 'Privasi dan kebijakan'),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: Dimen.x16,
              right: Dimen.x16,
              bottom: Dimen.x8,
            ),
            child: _buildButton(LocalImage.ic_info_contributor, 'Tentang relieve dan kontributor'),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: Dimen.x16,
              right: Dimen.x16,
              top: Dimen.x24,
              bottom: Dimen.x32,
            ),
            child: _buildButton(LocalImage.ic_exit, 'Keluar',
                isExit: true),
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
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Dimen.x12, vertical: Dimen.x18),
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
    );
  }
}

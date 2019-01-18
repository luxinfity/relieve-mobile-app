import 'package:flutter/material.dart';

import '../../res/res.dart';
import '../../network/model/family.dart';
import '../../widget/relieve_scaffold.dart';
import '../../widget/item/title.dart';
import '../../widget/item/family_item.dart';

class CallScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RelieveScaffold(
      hasBackButton: true,
      backIcon: LocalImage.ic_cross,
      crossAxisAlignment: CrossAxisAlignment.start,
      childs: <Widget>[
        Expanded(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(<Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      left: Dimen.x16,
                      top: Dimen.x16,
                      bottom: Dimen.x12,
                    ),
                    child: ScreenTitle(title: 'Panggilan Darurat'),
                  ),
                  Card(
                    margin: EdgeInsets.symmetric(horizontal: Dimen.x16),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimen.x21,
                        vertical: Dimen.x18,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              'Dago Pakar, Bandung',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          LocalImage.ic_drop_down.toSvg(width: Dimen.x12),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: Dimen.x32),
                    child: ThemedTitle(title: 'Lembaga Penanganan Darurat'),
                  )
                ]),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: Dimen.x16),
                sliver: SliverGrid.count(
                  crossAxisCount: 2,
                  childAspectRatio: 2,
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 6,
                  children: <Widget>[
                    _buildButton(
                      LocalImage.ic_police,
                      'Kantor Polisi',
                    ),
                    _buildButton(
                      LocalImage.ic_ambulance,
                      'Ambulance',
                    ),
                    _buildButton(
                      LocalImage.ic_red_cross,
                      'Palang Merah',
                    ),
                    _buildButton(
                      LocalImage.ic_fire_fighter,
                      'Pemadam Kebakaran',
                    ),
                    _buildButton(
                      LocalImage.ic_sar,
                      'Badan SAR',
                    ),
                    _buildButton(
                      LocalImage.ic_others,
                      'Lainnya',
                      isTintBlue: true,
                    ),
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(<Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: Dimen.x32),
                    child: ThemedTitle(title: 'Panggilan Cepat'),
                  )
                ]),
              ),
              SliverList(
                delegate: SliverChildListDelegate(<Widget>[
                  FamilyItemList(),
                ]),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildButton(
    LocalImage icon,
    String title, {
    bool isTintBlue = false,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimen.x14, vertical: Dimen.x18),
        child: Wrap(
          direction: Axis.vertical,
          spacing: Dimen.x12,
          children: <Widget>[
            icon.toSvg(
              width: Dimen.x18,
              color:
                  isTintBlue ? AppColor.colorPrimary : AppColor.colorTextBlack,
            ),
            Text(
              title,
              style: CircularStdFont.medium.getStyle(
                size: Dimen.x16,
                color: isTintBlue
                    ? AppColor.colorPrimary
                    : AppColor.colorTextBlack,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

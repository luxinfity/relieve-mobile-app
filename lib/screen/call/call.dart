import 'package:flutter/material.dart';

import '../../res/res.dart';
import '../../widget/relieve_scaffold.dart';
import '../../widget/item/title.dart';
import '../../widget/item/family_item.dart';
import '../call/call_list.dart';
import './components/item_button.dart';

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
                  crossAxisSpacing: Dimen.x6,
                  mainAxisSpacing: Dimen.x6,
                  children: <Widget>[
                    ItemButton(
                      icon: LocalImage.ic_police,
                      title: 'Kantor Polisi',
                    ),
                    ItemButton(
                      icon: LocalImage.ic_ambulance,
                      title: 'Ambulance',
                    ),
                    ItemButton(
                      icon: LocalImage.ic_red_cross,
                      title: 'Palang Merah',
                    ),
                    ItemButton(
                      icon: LocalImage.ic_fire_fighter,
                      title: 'Pemadam Kebakaran',
                    ),
                    ItemButton(
                      icon: LocalImage.ic_sar,
                      title: 'Badan SAR',
                    ),
                    ItemButton(
                      icon: LocalImage.ic_others,
                      title: 'Lainnya',
                      isTintBlue: true,
                      onClick: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CallListScreen()));
                      },
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

  // Widget _buildButton(
  //   LocalImage icon,
  //   String title, {
  //   VoidCallback onClick,
  //   bool isTintBlue = false,
  // }) {
  //   return InkWell(
  //     onTap: onClick,
  //     child: Card(
  //       child: Padding(
  //         padding: const EdgeInsets.symmetric(
  //             horizontal: Dimen.x14, vertical: Dimen.x18),
  //         child: Wrap(
  //           direction: Axis.vertical,
  //           spacing: Dimen.x10,
  //           children: <Widget>[
  //             icon.toSvg(
  //               width: Dimen.x18,
  //               color: isTintBlue
  //                   ? AppColor.colorPrimary
  //                   : AppColor.colorTextBlack,
  //             ),
  //             Text(
  //               title,
  //               style: CircularStdFont.medium.getStyle(
  //                 size: Dimen.x14,
  //                 color: isTintBlue
  //                     ? AppColor.colorPrimary
  //                     : AppColor.colorTextBlack,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}

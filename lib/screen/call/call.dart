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
                padding: EdgeInsets.all(6),
                sliver: SliverGrid.count(
                  crossAxisCount: 2,
                  childAspectRatio: 2,
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 6,
                  children: <Widget>[
                    _buildButton(
                      LocalImage.ic_user,
                      'Profil dan password',
                      axis: Axis.vertical,
                    ),
                    Container(
                      color: AppColor.colorDanger,
                    ),
                    Container(
                      color: AppColor.colorEmptyChip,
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
    Axis axis = Axis.horizontal,
    bool isExit = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Dimen.x12, vertical: Dimen.x18),
      decoration: BoxDecoration(
        border: Border.all(
          color: isExit ? AppColor.colorDanger : AppColor.colorEmptyChip,
        ),
        color: Colors.green,
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

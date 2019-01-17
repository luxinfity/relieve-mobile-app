import 'package:flutter/material.dart';

import '../../res/res.dart';
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
              SliverGrid.count(
                crossAxisCount: 2,
                children: <Widget>[
                  Container(
                    color: AppColor.colorAccent,
                  ),
                  Container(
                    color: AppColor.colorDanger,
                  ),
                  Container(
                    color: AppColor.colorEmptyChip,
                  ),
                ],
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
}

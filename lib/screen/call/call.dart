import 'package:flutter/material.dart';
import 'package:recase/recase.dart';
import 'package:relieve_app/app_config.dart';
import 'package:relieve_app/screen/call/components/address_bar.dart';
import 'package:relieve_app/service/model/address.dart';

import 'package:relieve_app/res/res.dart';
import 'package:relieve_app/service/source/api/bakau.dart';
import 'package:relieve_app/service/source/api/config.dart';
import 'package:relieve_app/widget/relieve_scaffold.dart';
import 'package:relieve_app/widget/item/title.dart';
import 'package:relieve_app/widget/item/family_item.dart';
import '../call/call_list.dart';
import './components/item_button.dart';

class CallScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CallScreenState();
}

class CallScreenState extends State {
  List<Address> addressList = List();

  void getUserAddress() async {
    final addressResponse =
        await BakauApi(AppConfig.of(context)).getUserAddress();

    if (addressResponse?.status == REQUEST_SUCCESS) {
      setState(() {
        addressList = addressResponse.content;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getUserAddress();
  }

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
                  AddressBar(addressList: addressList),
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
}

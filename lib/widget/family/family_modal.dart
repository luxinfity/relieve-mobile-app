import 'package:flutter/material.dart';
import 'package:relieve_app/widget/common/bottom_modal.dart';
import 'package:relieve_app/widget/family/add_family_modal.dart';

//  void testSheet3(BuildContext context) {
//    createRelieveBottomModal(context, <Widget>[
//      Stack(
//        alignment: Alignment.center,
//        children: <Widget>[
//          SpinKitPulse(
//            color: HexColor(AppColor.colorPrimary.hexColor, transparency: 0.35),
//            size: 300,
//            duration: Duration(seconds: 2),
//          ),
//          SpinKitPulse(
//            color: HexColor(AppColor.colorPrimary.hexColor, transparency: 0.65),
//            size: 200,
//            duration: Duration(seconds: 2),
//          ),
//          SpinKitPulse(
//            size: 110,
//            duration: Duration(seconds: 2),
//            color: HexColor(AppColor.colorPrimary.hexColor, transparency: 0.9),
//          ),
//          FamilyItem.normal(
//            hideName: true,
//            family: Family(
//              fullName: 'Ibu',
//              condition: Condition(health: PersonHealth.Fine),
//              imageUrl:
//                  'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b1/Suzy_Bae_at_fansigning_on_February_3%2C_2018_%284%29.jpg/220px-Suzy_Bae_at_fansigning_on_February_3%2C_2018_%284%29.jpg',
//            ),
//          ),
//        ],
//      ),
//      Padding(
//        padding: const EdgeInsets.symmetric(
//            horizontal: Dimen.x16, vertical: Dimen.x18),
//        child: Text(
//          'Ibu ingin mengetahui keadaan kamu, Bagaimana kabar mu?',
//          style: CircularStdFont.black.getStyle(size: Dimen.x18),
//        ),
//      ),
//      Row(
//        children: <Widget>[
//          Container(width: Dimen.x16),
//          Expanded(
//            child: RaisedButton(
//              onPressed: () {},
//              padding: EdgeInsets.only(
//                top: Dimen.x12,
//                bottom: Dimen.x12,
//              ),
//              shape: RoundedRectangleBorder(
//                borderRadius: BorderRadius.circular(Dimen.x4),
//              ),
//              child: Text(
//                'Sakit',
//                style: CircularStdFont.medium
//                    .getStyle(size: Dimen.x14, color: Colors.white),
//              ),
//              elevation: 1,
//              highlightElevation: 1,
//              color: AppColor.colorDanger,
//            ),
//          ),
//          Container(width: Dimen.x10),
//          Expanded(
//            child: RaisedButton(
//              onPressed: () {},
//              padding: EdgeInsets.only(
//                top: Dimen.x12,
//                bottom: Dimen.x12,
//              ),
//              shape: RoundedRectangleBorder(
//                borderRadius: BorderRadius.circular(Dimen.x4),
//              ),
//              child: Text(
//                'Sehat',
//                style: CircularStdFont.medium
//                    .getStyle(size: Dimen.x14, color: Colors.white),
//              ),
//              elevation: 1,
//              highlightElevation: 1,
//              color: AppColor.colorPrimary,
//            ),
//          ),
//          Container(width: Dimen.x16),
//        ],
//      )
//    ]);
//  }

//  void testSheet2(BuildContext context) {
//    createRelieveBottomModal(context, <Widget>[
//      Stack(
//        alignment: Alignment.center,
//        children: <Widget>[
//          SpinKitPulse(
//            color: HexColor(AppColor.colorPrimary.hexColor, transparency: 0.35),
//            size: 300,
//            duration: Duration(seconds: 2),
//          ),
//          SpinKitPulse(
//            color: HexColor(AppColor.colorPrimary.hexColor, transparency: 0.65),
//            size: 200,
//            duration: Duration(seconds: 2),
//          ),
//          SpinKitPulse(
//            size: 110,
//            duration: Duration(seconds: 2),
//            color: HexColor(AppColor.colorPrimary.hexColor, transparency: 0.9),
//          ),
//          FamilyItem.normal(
//            hideName: true,
//            family: Family(
//              fullName: 'Alif',
//              imageUrl:
//                  'https://www.sbs.com.au/popasia/sites/sbs.com.au.popasia/files/styles/full/public/twice-tzuyu-7.jpg',
//            ),
//          ),
//        ],
//      ),
//      Container(height: Dimen.x10),
//      StandardButton(
//        isHollow: true,
//        text: 'Menunggu Respons...',
//        textColor: AppColor.colorPrimary,
//        backgroundColor: AppColor.colorPrimary,
//        buttonClick: () => testSheet2(context),
//        isCenteredIcon: true,
//      ),
//    ]);
//  }

//  void testSheet(BuildContext context) {
//    createRelieveBottomModal(context, <Widget>[
//      Row(
//        children: <Widget>[
//          Container(width: Dimen.x12),
//          FamilyItem.normal(
//            hideName: true,
//            family: Family(
//              fullName: 'Mama',
//              imageUrl:
//                  'https://www.sbs.com.au/popasia/sites/sbs.com.au.popasia/files/styles/full/public/twice-tzuyu-7.jpg',
//            ),
//          ),
//          Container(width: Dimen.x10),
//          Text(
//            'Mama',
//            style: CircularStdFont.black.getStyle(size: Dimen.x24),
//          ),
//          Container(width: Dimen.x12),
//        ],
//      ),
//      Container(height: Dimen.x16),
//      Row(
//        children: <Widget>[
//          Container(width: Dimen.x16),
//          Expanded(
//            flex: 4,
//            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
//                Row(
//                  children: <Widget>[
//                    LocalImage.ic_address_sign.toSvg(width: Dimen.x12),
//                    Container(width: Dimen.x4),
//                    Text(
//                      'Tempat terakhir',
//                      style: CircularStdFont.book.getStyle(
//                          size: Dimen.x12, color: AppColor.colorTextGrey),
//                    )
//                  ],
//                ),
//                Container(height: Dimen.x8),
//                Text('Dayeuhkolot, Bandung'),
//              ],
//            ),
//          ),
//          Expanded(
//            flex: 2,
//            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
//                Row(
//                  children: <Widget>[
//                    LocalImage.ic_clock.toSvg(width: Dimen.x12),
//                    Container(width: Dimen.x4),
//                    Text(
//                      'Kondisi terakhir',
//                      style: CircularStdFont.book.getStyle(
//                          size: Dimen.x12, color: AppColor.colorTextGrey),
//                    )
//                  ],
//                ),
//                Container(height: Dimen.x8),
//                Row(
//                  children: <Widget>[
//                    Container(
//                      padding: const EdgeInsets.symmetric(
//                          horizontal: Dimen.x16, vertical: Dimen.x6),
//                      decoration: BoxDecoration(
//                          color: HexColor(AppColor.colorPrimary.hexColor,
//                              transparency: 0.15),
//                          borderRadius: BorderRadius.circular(Dimen.x16)),
//                      child: Text(
//                        'Aman',
//                        style: CircularStdFont.bold.getStyle(
//                            size: Dimen.x12, color: AppColor.colorPrimary),
//                      ),
//                    ),
//                    Container(
//                      margin: const EdgeInsets.only(left: Dimen.x6),
//                      padding: const EdgeInsets.symmetric(
//                          horizontal: Dimen.x8, vertical: Dimen.x6),
//                      decoration: BoxDecoration(
//                          color: HexColor(AppColor.colorEmptyRect.hexColor,
//                              transparency: 0.50),
//                          borderRadius: BorderRadius.circular(Dimen.x16)),
//                      child: Text(
//                        '24h',
//                        style: CircularStdFont.bold.getStyle(
//                            size: Dimen.x12, color: AppColor.colorTextBlack),
//                      ),
//                    )
//                  ],
//                ),
//              ],
//            ),
//          ),
//          Container(width: Dimen.x16),
//        ],
//      ),
//      Container(height: Dimen.x16),
//      StandardButton(
//        text: 'PING',
//        svgIcon: LocalImage.ic_ping,
//        backgroundColor: AppColor.colorPrimary,
//        buttonClick: () => testSheet2(context),
//        isCenteredIcon: true,
//      ),
//    ]);
//  }

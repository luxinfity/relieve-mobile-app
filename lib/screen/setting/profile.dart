import 'package:flutter/material.dart';

import 'package:relieve_app/res/res.dart';
import 'package:relieve_app/widget/item/standard_button.dart';
import 'package:relieve_app/widget/item/title.dart';
import 'package:relieve_app/widget/relieve_scaffold.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileScreenState();
  }
}

class ProfileScreenState extends State {
  Widget createPictureCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimen.x16,
        vertical: Dimen.x21,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            radius: Dimen.x42,
            backgroundColor: AppColor.colorAccent,
            backgroundImage: NetworkImage(
              'https://blue.kumparan.com/kumpar/image/upload/fl_progressive,fl_lossy,c_fill,q_auto:best,w_640/v1511853177/jedac0gixzhcnuozw7c4.jpg',
            ),
          ),
          Container(width: Dimen.x12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Ubah foto profil',
                  style: CircularStdFont.bold.getStyle(size: Dimen.x14),
                ),
                Container(height: Dimen.x12),
                Row(                   
                  children: <Widget>[
                    Expanded(
                      child: OutlineButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            LocalImage.ic_gallery.toSvg(width: Dimen.x16),
                            Container(width: Dimen.x16),
                            Text(
                              'Galeri',
                              style: CircularStdFont.book
                                  .getStyle(size: Dimen.x12),
                            ),
                          ],
                        ),
                        highlightedBorderColor: AppColor.colorEmptyChip,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Dimen.x6),
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Container(width: Dimen.x12),
                    Expanded(
                      child: OutlineButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            LocalImage.ic_camera.toSvg(width: Dimen.x16),
                            Container(width: Dimen.x16),
                            Text(
                              'Kamera',
                              style: CircularStdFont.book
                                  .getStyle(size: Dimen.x12),
                            ),
                          ],
                        ),
                        highlightedBorderColor: AppColor.colorEmptyChip,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Dimen.x6),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                // Expanded(
                //   child: Container(height: 20, color: Colors.green,),
                // ),

                // Row(
                //   children: <Widget>[

                //     OutlineButton(
                //       child: Row(
                //         children: <Widget>[
                //           LocalImage.ic_camera.toSvg(width: Dimen.x16),
                //           Text(
                //             'Kamera',
                //             style: CircularStdFont.book.getStyle(size: Dimen.x12),
                //           ),
                //         ],
                //       ),
                //       highlightedBorderColor: AppColor.colorEmptyChip,
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(Dimen.x6),
                //       ),
                //       onPressed: () {},
                //     ),
                //   ],
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsets padding = MediaQuery.of(context).padding;
    return RelieveScaffold(
      hasBackButton: true,
      crossAxisAlignment: CrossAxisAlignment.start,
      childs: <Widget>[
        ThemedTitle(
          title: 'Profil dan password',
          subtitle: 'Ubah peraturan pada profil dan password',
        ),
        Container(height: Dimen.x12, color: AppColor.colorStandardBackgroud),
        createPictureCard(),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(height: 20, color: Colors.brown),
            ),
            Expanded(
              child: Container(height: 20, color: Colors.cyan),
            ),
          ],
        ),
      ],
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(bottom: padding.bottom),
        child: StandardButton(
          text: 'Simpan',
          backgroundColor: AppColor.colorPrimary,
          buttonClick: () {},
        ),
      ),
    );
  }
}

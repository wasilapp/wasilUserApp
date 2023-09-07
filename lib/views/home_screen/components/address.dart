import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../../../providers/darktheme.dart';

import '../../../services/AppLocalizations.dart';
import '../../../utils/size.dart';
import '../../../utils/text.dart';
import '../../../utils/theme/theme.dart';
import '../../address/address.dart';

class AddressWidget extends StatefulWidget {
  const AddressWidget({super.key});

  @override
  State<AddressWidget> createState() => _AddressWidgetState();
}

class _AddressWidgetState extends State<AddressWidget> {

  late ThemeData themeData;
  late CustomAppTheme customAppTheme;
  @override
  Widget build(BuildContext context) {
    return      Consumer<AppThemeNotifier>(
        builder: (BuildContext context, AppThemeNotifier value, Widget? child) {
      int themeType = value.themeMode();
      themeData = AppTheme.getThemeFromThemeMode(themeType);
      customAppTheme = AppTheme.getCustomAppTheme(themeType);
      return GestureDetector(
      onTap: () {


      },
      child: Container(
        padding: Spacing.x(8),
        margin: Spacing.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: customAppTheme.bgLayer4, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: <Widget>[

                Expanded(
                  child: Container(
                    margin: Spacing.left(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          "Arjan" ,
                          style: AppTheme.getTextStyle(
                              themeData.textTheme.bodyText2,
                              color: themeData.colorScheme.onBackground,
                              fontWeight: 600),
                        ),
                        Text(
                          "Amman -6",
                          style: AppTheme.getTextStyle(
                              themeData.textTheme.caption,
                              fontSize: 15,
                              color: themeData.colorScheme.onBackground
                                  .withAlpha(150),
                              fontWeight: 500),
                        ),
                      ],
                    ),
                  ),
                ),
                PopupMenuButton(
                  //   key: _addressSelectionKey,
                  icon: Icon(
                    MdiIcons.chevronDown,
                    color: themeData.colorScheme.onBackground,
                    size: 20,
                  ),
                  onSelected: (dynamic value) async {
                    if (value == -1) {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddAddressScreen()));
                    } else {
                      setState(() {
                        //        selectedAddress = value;
                      });
                      // _refresh();
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    var list = <PopupMenuEntry<Object>>[];

                    for (int i = 0; i <TextUtils.listMap.length; i++) {
                      list.add(PopupMenuItem(
                        value: i,
                        child: Container(
                          margin: Spacing.vertical(2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(TextUtils.listMap![i]['address'],
                                  style: AppTheme.getTextStyle(
                                    themeData.textTheme.bodyText2,
                                    fontWeight: 600,
                                    color: themeData.colorScheme.onBackground,
                                  )),
                              Container(
                                margin: Spacing.top(2),
                                child: Text(
                                    TextUtils.listMap![i]['city']   +
                                        " - " ,

                                    style: AppTheme.getTextStyle(
                                      themeData.textTheme.caption,
                                      color: themeData.colorScheme.onBackground,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ));
                      list.add(
                        PopupMenuDivider(
                          height: 10,
                        ),
                      );
                    }
                    list.add(PopupMenuItem(
                      value: -1,
                      child: Container(
                        margin: Spacing.vertical(4),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              MdiIcons.plus,
                              color: themeData.colorScheme.onBackground,
                              size: 20,
                            ),
                            Container(
                              margin: Spacing.left(4),
                              child: Text(
                                  Translator.translate("add_new_address"),
                                  style: AppTheme.getTextStyle(
                                    themeData.textTheme.bodyText2,
                                    color: themeData.colorScheme.onBackground,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ));
                    return list;
                  },
                  color: themeData.backgroundColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  });}
}

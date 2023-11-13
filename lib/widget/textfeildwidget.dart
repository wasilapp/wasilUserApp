import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/darktheme.dart';

import '../../../services/AppLocalizations.dart';
import '../utils/helper/size.dart';
import '../utils/theme/theme.dart';
class TextFeildWidget extends StatelessWidget {
final String hintText;
final IconData prefixIconData;
final  suffixIconData;
final bool isPassword;
final TextInputType keyBoard;
final TextEditingController controller;
final Function()? onPrefixIconPress;
final  showPassword;
final Function()? fun;

const TextFeildWidget({
Key? key,

required this.hintText,
required this.controller,
required this.keyBoard,
required this.prefixIconData,
  this.showPassword=false,
this.suffixIconData ,
this.onPrefixIconPress,
this.isPassword = false,
  this.fun,
}) : super(key: key);


  @override
  Widget build(BuildContext context) {

  late ThemeData themeData;
  late CustomAppTheme customAppTheme;
  return Consumer<AppThemeNotifier>(
      builder: (BuildContext context, AppThemeNotifier value, Widget? child) {
    int themeType = value.themeMode();
    themeData = AppTheme.getThemeFromThemeMode(themeType);
    customAppTheme = AppTheme.getCustomAppTheme(themeType);
    return
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        obscureText: showPassword,
validator: (value) {
  if(value!.isEmpty){
      return "kkk";
  }

},
        style: AppTheme.getTextStyle(
            themeData.textTheme.bodyText1,
            letterSpacing: 0.1,
            color: themeData
                .colorScheme.onBackground,
            fontWeight: 500),
        decoration: InputDecoration(

          suffixIcon:suffixIconData ,
            hintText: Translator.translate(
                hintText),
            hintStyle: AppTheme.getTextStyle(
                themeData.textTheme.subtitle2,
                letterSpacing: 0.1,
                color: themeData
                    .colorScheme.onBackground,
                fontWeight: 500),
            border:  OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
                borderSide: BorderSide(color: customAppTheme.bgLayer4, width: 1.5)),
            enabledBorder:  OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
                borderSide: BorderSide(color: customAppTheme.bgLayer4, width: 1.5)),
            focusedBorder:  OutlineInputBorder(
            borderRadius: const BorderRadius.all(
            Radius.circular(8),
      ),
        borderSide: BorderSide(color: customAppTheme.bgLayer4, width: 1.5)),
            prefixIcon: Icon(
              prefixIconData   ,
              size: MySize.size22,
            ),
            isDense: true,
            contentPadding: Spacing.zero),
        keyboardType: keyBoard,
        autofocus: false,
        textCapitalization:
        TextCapitalization.sentences,
        controller:controller,
      ),
    );
});}}
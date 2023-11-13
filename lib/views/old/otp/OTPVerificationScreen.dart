// import 'dart:developer';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:userwasil/config/custom_package.dart';
// import '../../../utils/theme/theme.dart';
// import '../../home/home_view/home_screen.dart';
//
//
// class OtpVerificationScreen extends StatefulWidget {
//   const OtpVerificationScreen({super.key});
//
//
//   @override
//   OtpVerificationScreenState createState() => OtpVerificationScreenState();
// }
//
// class OtpVerificationScreenState extends State<OtpVerificationScreen> {
//   late ThemeData themeData;
//
//   final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
//
//   TextEditingController? _numberController;
//   TextEditingController? _otpController;
//   FocusNode otpFN = FocusNode();
//   String? number;
//
//   String? _verificationId;
//   int selectedCountryCode = 0;
//   List<PopupMenuEntry<Object>>? countryList;
//   List<dynamic> countryCode = TextUtils.countryCode;
//
//   final List<bool> _dataExpansionPanel = [true, false];
//
//   @override
//   void initState() {
//     super.initState();
//     getNumber();
//     _numberController = TextEditingController();
//     _otpController = TextEditingController();
//     WidgetsBinding.instance!.addPostFrameCallback((_) {
//       showMessage(message: "Please verify your phone number");
//     });
//   }
//
//   getNumber()async{
//     final prefs = await SharedPreferences.getInstance();
//     log("i am in get");
//     log("${prefs.getString('mobile')}");
//     number = "+${prefs.getString('mobile')}";
//     sendOTP();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _numberController!.dispose();
//   }
//
//   Future<void> sendOTP() async {
//     if (number == null) {
//       return;
//     }
//     MyResponse myResponse = await AuthController.verifyMobileNumber(number!);
//     if (!myResponse.success) {
//
//       showMessage(message: "This is used phone number ");
//       return;
//     }
//     await FirebaseAuth.instance.verifyPhoneNumber(
//
//       phoneNumber: number,
//       timeout: const Duration(milliseconds: 500000000000),
//       verificationCompleted:  (PhoneAuthCredential credential) {      verifiedComplete(number);},
//       verificationFailed:  (FirebaseAuthException error) {
//         if (error.code == 'invalid-phone-number') {
//           showMessage(message: "Please use [country code] then [number] format");
//         }
//         showMessage(message: error.code);},
//       codeSent:  (String verificationId, int? resendToken){
//         setState(() {
//           _dataExpansionPanel[1] = true;
//           otpFN.requestFocus();
//         });
//         _verificationId = verificationId;
//       },
//       codeAutoRetrievalTimeout:(String verificationId) {   log('codeAutoRetrievalTimeout');},
//     );
//   }
//
//
//
//   onOTPVerify() async {
//     String otp = _otpController!.text.trim();
//     if (number!.contains("+")) {
//       showMessage(message: "Please enter number properly+");
//       return null;
//     }
//
//     if (number!.length <= 6) {
//       showMessage(message: "Please enter number properly");
//       return null;
//     }
//     if (otp.isEmpty) {
//       showMessage(message: "Please fill OTP");
//     } else if (otp.length != 6) {
//       showMessage(message: "Your OTP is not 6 digit");
//     } else {
//       try {
//        PhoneAuthCredential credential= PhoneAuthProvider.credential(
//           verificationId: _verificationId!,
//           smsCode: otp,
//         );
//         await  FirebaseAuth.instance.signInWithCredential(credential);
//         verifiedComplete(number);
//       } catch (e) {
//         showMessage(message: "Your verification code is wrong");
//       }
//     }
//   }
//
//   verifiedComplete(String? number) async {
//
//
//     try {
//
//
//       AuthType authType = await AuthController.userAuthType();
//
//
//
//       if (authType == AuthType.VERIFIED) {
//
//         Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
//             builder: (context) => HomeScreen()), (Route route) => false);
//       } else if (authType == AuthType.LOGIN) {
//         print('kk');
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (BuildContext context) => OtpVerificationScreen(),
//           ),
//         );
//       } else {
//         await AuthController.logoutUser();
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (BuildContext context) => SignInScreen(),
//           ),
//         );
//       }
//     } catch (e) {}
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     themeData = Theme.of(context);
//     return Consumer<AppThemeNotifier>(
//       builder: (BuildContext context, AppThemeNotifier value, Widget? child) {
//         return Scaffold(
//
//                 body: Center(
//                   child: Column(
//
//                     children: [
//                       const SizedBox(height: 150,),
//                       const LogoAsset(),
//                       const SizedBox(height: 150,),
//
//                       const UserText(title: 'Cod will be sent to your mobile phone ',fontSize: 12,fontWeight: FontWeight.bold,),
//                       const SizedBox(height: 15,),
//                       const UserText(title: 'Enter otp',fontSize: 12,fontWeight: FontWeight.bold,),
//
//                       SizedBox(
//                           width: MediaQuery.of(context).size.width-100,
//                           child:
//                           PinCodeTextField(
//
//                             length: 6,
//                             obscureText: false,
//                             animationType: AnimationType.fade,
//                             pinTheme: PinTheme(
//                               inactiveColor: Colors.grey,
//                               selectedColor: Colors.greenAccent,
//                               activeColor: Colors.greenAccent,
//                               errorBorderColor: Colors.greenAccent,
//                               shape: PinCodeFieldShape.box,
//                               borderRadius: BorderRadius.circular(5),
//                               fieldHeight: 50,
//                               fieldWidth: 40,
//
//                               activeFillColor: Colors.white,
//                             ),
//                             enablePinAutofill:false,
//                             autovalidateMode:AutovalidateMode.disabled,
//                             cursorColor: Colors.green,
//                             autoFocus: false,
//                             autoUnfocus: false,
//                             animationDuration: Duration(milliseconds: 300),
//                             enableActiveFill: false,
//                             autoDisposeControllers: false,
//                             onAutoFillDisposeAction:AutofillContextAction.cancel,
//                             // errorAnimationController: errorController,
//                             controller: _otpController,
//                             onCompleted: (v) {
//                               log("Completed");
//                               // otp =v;
//                             },
//                             onChanged: (value) {
//                               log(value);
//                               setState(() {
//                                 // otp = value;
//                               });
//                             },
//
//                             appContext: context,
//                           )
//
//
//                       ),
//                    CommonViews().createButton(title: 'Confirm', onPressed: () {
//                      onOTPVerify();
//                    },),
//                       const Spacer(),
//
//                     ],
//                   ),
//                 ));
//       },
//     );
//   }
//
//   void showMessage({String message = "Something wrong", Duration? duration}) {
//     if (duration == null) {
//       duration = Duration(seconds: 3);
//     }
//     _scaffoldMessengerKey.currentState!.showSnackBar(
//       SnackBar(
//         duration: duration,
//         content: Text(message,
//             style: AppTheme.getTextStyle(themeData.textTheme.subtitle2,
//                 letterSpacing: 0.4, color: themeData.colorScheme.onPrimary)),
//         backgroundColor: themeData.colorScheme.primary,
//         behavior: SnackBarBehavior.fixed,
//       ),
//     );
//   }
//
//   List<PopupMenuEntry<Object>> getCountryList() {
//     if (countryList != null) return countryList!;
//     countryList = <PopupMenuEntry<Object>>[];
//     for (int i = 0; i < countryCode.length; i++) {
//       countryList!.add(PopupMenuItem(
//         value: i,
//         child: Container(
//           margin: Spacing.vertical(2),
//           child: Text(
//               countryCode[i]['name'] + " ( " + countryCode[i]['code'] + " )",
//               style: AppTheme.getTextStyle(
//                 themeData.textTheme.subtitle2,
//                 color: themeData.colorScheme.onBackground,
//               )),
//         ),
//       ));
//       countryList!.add(
//         PopupMenuDivider(
//           height: 10,
//         ),
//       );
//     }
//     return countryList!;
//   }
// }

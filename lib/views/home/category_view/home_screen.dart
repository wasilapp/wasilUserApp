

import '../../../config/custom_package.dart';
import '../../old/detail/order_detail.dart';
import 'components/address_widget.dart';
import '../../category/category.dart';
import 'components/drawer.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      drawer: const Drawer(
        backgroundColor: AppColors.primaryColor,
        width: 250,
        child: DrawerWidget(),
      ),
      appBar: AppBar(backgroundColor: AppColors.backgroundColor,actionsIconTheme: IconThemeData(color: Colors.black),
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0, actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,),
          child: InkWell(
              onTap: () {
                UserNavigator.of(context).push( const OrderDetail());
              },
              child: const Icon(Icons.shopping_bag)),
        ),
      ]),
      body: Column(
        children: [

          AddressWidget(),

          Padding(
            padding: Spacing.all(1.0),
            child: Image.asset(
              'assets/images/img1.png',
              fit: BoxFit.cover,
              height: 140,
              width: double.infinity,
            ),
          ),
          const SizedBox(height: 50,),
         const CategoryWidget(),
          const Spacer(),
          InkWell(
            onTap: () {
              FirestoreServices().test();
            },
            child: Container(
                width: 390,
                height: 74,
                decoration: const BoxDecoration(
                    color: Color(0xff15cb95))
            ),
          )
        ],
      ),
    ));
  }
}

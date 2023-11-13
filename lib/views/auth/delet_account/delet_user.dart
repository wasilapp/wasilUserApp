import 'package:get/get.dart';

import '../../../config/custom_package.dart';
import 'delete_user_controller.dart';

class DeleteUserDialog extends StatelessWidget {
  const DeleteUserDialog({super.key});

  @override
  Widget build(BuildContext context) {
    DeleteUser controller=Get.put(DeleteUser());
    return AlertDialog(
      content:      Text("Are you sure you want to Delete account?".tr,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,)),

      actions: [
        // hide

        TextButton(
            onPressed: () async {

controller.deleteUser();
            },
            child:  Text("Delete".tr.tr,style: TextStyle(color: Colors.red),)),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child:  Text("Cancel".tr)),
      ],
      shadowColor: Colors.black,
      elevation: 20,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)),
      backgroundColor: Colors.white,

      // ctrl space, command space
    );
  }

}

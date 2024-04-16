import 'package:contact_app53/cubit/contacts/contact_cubit.dart';
import 'package:contact_app53/view/widgets/default_form_field.dart';
import 'package:contact_app53/view/widgets/default_phone_form.dart';
import 'package:contact_app53/view/widgets/default_text.dart';
import 'package:contact_app53/view/widgets/default_text_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../utilities/constant.dart';

class EditingContacts extends StatelessWidget {
  final Map contactModel;
  const EditingContacts({super.key, required this.contactModel});

  bool get mounted => false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DefaultFormField(
              controller: nameController,
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Name Cant be empty ";
                }
                return null;
              },
              textColor: Colors.white,
              prefixIcon: Icon(Icons.title),
              hintText: "Contacts Name",
            ),
            DefaultPhoneFormField(
              controller: phoneController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "phone number must not be empty ";
                }
                return null;
              },
              label: "Phone Number",
              textColor: Colors.white,
              onChange: (countryCode) {
                myCountry = countryCode;
              },
              hintText: "Contact Phone Number",
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: DefaultTextButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        await ContactCubit.get(context).updateContact(
                            name: nameController.text,
                            number:
                                "${myCountry.dialCode}${phoneController.text}",
                            id: contactModel['id']);
                        Fluttertoast.showToast(
                          msg: "Contact Editing Successfully",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 3,
                          backgroundColor: Colors.grey,
                          textColor: Colors.purple,
                          fontSize: 12.sp,
                        );
                          Navigator.pop(context);
                      }
                    },
                    child: DefaultText(
                      text: "Save",
                      color: Colors.purple,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                Flexible(
                  child: DefaultTextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: DefaultText(
                      text: "Cancel",
                      color: Colors.pinkAccent,
                      fontSize: 12.sp,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

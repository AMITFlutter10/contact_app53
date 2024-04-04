
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';


class DefaultPhoneFormField extends StatelessWidget{
  final TextEditingController controller;
  final   String? Function(String?)? validator;
  final   Color? textColor;
  final   Color? labelColor;
  final void Function(CountryCode)? onChange;
  final String? hintText;
  final String? label;
  const DefaultPhoneFormField({super.key,
    required this.controller,
    this.validator,
    this.textColor,
    this.labelColor,
    this.onChange,
    this.hintText ='EG .10192',
    this.label,
  });
  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      controller:  controller,
      validator: validator,
      keyboardType:  TextInputType.phone,
      style: TextStyle(
        color:  textColor,
      ),
      decoration: InputDecoration(
          prefixIcon: CountryCodePicker(
            onChanged: onChange,
            initialSelection: 'EG',
            favorite: const ['+02','EG'],
          ),
          hintText: hintText,
          hintStyle:const TextStyle(
            //  color:  AppTheme.gray2
          ),
          labelText: label ,
          labelStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: labelColor
          )
      ),

    );
  }

}
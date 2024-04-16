import 'package:contact_app53/cubit/contacts/contact_cubit.dart';
import 'package:contact_app53/utilities/styles/color.dart';
import 'package:contact_app53/view/widgets/default_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'edit_contacts.dart';

class ContactsListBuilder extends StatelessWidget{
  final List<Map> contacts;
  final String contactType;
  final  String noContacts;

  const ContactsListBuilder({super.key,
    required this.contacts,
    required this.contactType,
    required this.noContacts,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: contacts.isNotEmpty,
      replacement: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.no_accounts,
              size: 60.sp,
              color: Colors.white,
            ),
            DefaultText(text: noContacts,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,

            )
          ],),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.h),
        child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index)=> ContactsListItems(
              contactsModel: contacts[index],),
            separatorBuilder: (context, index) => Divider(height: 1.h, color: Colors.transparent,),
            itemCount: contacts.length),
      ),
    );
  }
}

class ContactsListItems extends StatelessWidget{
  Map contactsModel ;

  ContactsListItems({super.key,
    required this.contactsModel,
  });

  @override
  Widget build(BuildContext context) {
     return
    Dismissible(
      key: UniqueKey(),
      onDismissed: (direction)async{
        await ContactCubit.get(context).deleteContact(
            id: contactsModel['id']);

        Fluttertoast.showToast(msg: "Contact Deleted Successfully!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.grey,
          textColor: Colors.purple,
          fontSize: 12.sp,
        );
      },
     child:
    InkWell(
        onTap: (){
          Fluttertoast.showToast(msg: "Long touch for contact editing,swipe left or"
              " right to delete , double click dor calling contact",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor:Colors.grey,
            textColor: Colors.purple,
            fontSize: 12.sp,
          );
        },
        onLongPress: (){
          showDialog(context: context,
              barrierDismissible: false,
              builder: (context)=> EditingContacts(contactModel: contactsModel,));
        },
        onDoubleTap: ()async{
          final Uri launchUri =
          Uri(
              scheme: 'tel',
              path: contactsModel['number']
          );
          await launchUrl(launchUri);
        },
        child:
     Container(
          margin: EdgeInsets.symmetric(horizontal: 2.w),
          padding: EdgeInsets.symmetric(horizontal: 2.w ,vertical: 2.h ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient:  LinearGradient(
                  begin: AlignmentDirectional.centerStart,
                  end: AlignmentDirectional.bottomEnd,
                  colors: [
                    // AppTheme.primaryColor,
                    // AppTheme.secondColor,
                    // AppTheme.darkGray,
                  Colors.white24,
                    Colors.pinkAccent,
                    Colors.purple
                  ]
              )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: 2.w),
                    child: Flexible(
                      child: DefaultText(
                        text: contactsModel['name'],
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        color: AppTheme.kPrimaryColor,

                      ),
                    ),
                  ),
                  Flexible(
                    child: DefaultText(
                      text:contactsModel['number'],
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Visibility(
                visible:contactsModel['type']=="Favorite" ,
                replacement:
                IconButton(
                    onPressed: ()async{
                      await ContactCubit.get(context).updateFavorite(
                          type: 'Favorite',
                          id: contactsModel['id']);
                    },
                    icon: const Icon(Icons.favorite_border,
                      color: Colors.grey,)),

                child: IconButton(
                    onPressed: ()async{
                      await ContactCubit.get(context).updateFavorite(
                          type: 'all',
                          id: contactsModel['id']);
                    },
                    icon: const Icon(Icons.favorite,
                      color: Colors.red,)),
              )
            ],
          ),

    )));
  }

}
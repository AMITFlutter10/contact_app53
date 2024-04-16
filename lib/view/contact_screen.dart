import 'package:contact_app53/cubit/contacts/contact_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'contact_builder.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactCubit, ContactState>(
      builder: (context, state) {
        return ContactsListBuilder(
          contacts: ContactCubit
              .get(context)
              .contactList,
          contactType: 'All',
          noContacts: 'No Contact',

        );
      },
    );

}}

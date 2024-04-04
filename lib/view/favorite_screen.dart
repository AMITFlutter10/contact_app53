import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/contacts/contact_cubit.dart';
import 'contact_builder.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactCubit, ContactState>(
      builder: (context, state) {
        return ContactsListBuilder(
          contacts: ContactCubit
              .get(context)
              .favoriteList,
          contactType: 'All',
          noContacts: 'No Favorite',

        );
      },
    );
  }
}

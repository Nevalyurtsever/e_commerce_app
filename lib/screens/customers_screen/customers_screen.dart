import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/user/user.dart';
import 'providers/customers_provider.dart';

class CustomersScreen extends ConsumerStatefulWidget {
  static String routeName = "/customers";

  const CustomersScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomersScreenState();
}

class _CustomersScreenState extends ConsumerState<CustomersScreen> {
  @override
  Widget build(BuildContext context) {
    List<AppUser> customers = ref.watch(customersProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(context.localizations!.customers),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
            itemCount: customers.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) => ListTile(
              leading: CircleAvatar(
                backgroundImage: customers[index].photoURL != null
                    ? CachedNetworkImageProvider(customers[index].photoURL!)
                    : null,
                child: customers[index].photoURL == null
                    ? const Icon(Icons.person)
                    : null,
              ),
              title: Text(customers[index].createFullName()),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/global_providers/role_provider.dart';
import '../core/global_providers/user_state_provider.dart';
import '../core/models/user/address.dart';
import '../core/models/user/user.dart';
import 'widgets/custom_image_picker.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  static String routeName = "/edit-profile";

  const EditProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String? name,
      lastName,
      phoneNumber,
      country,
      state,
      city,
      town,
      street,
      zipcode,
      no,
      additionalAddress,
      tax,
      website;
  bool bussy = false;

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userStateProvider);

    if (user == null) return const SizedBox.shrink();

    if (bussy) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      const BackButton(),
                      Expanded(
                        child: Center(
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: user.photoURL != null
                                      ? DecorationImage(
                                          image: CachedNetworkImageProvider(
                                            user.photoURL!,
                                          ),
                                          fit: BoxFit.cover)
                                      : null,
                                ),
                                child: user.photoURL == null
                                    ? const Icon(Icons.person, size: 56)
                                    : null,
                              ),
                              IconButton.filled(
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) => CustomImagePicker(
                                      callbackImage: (File? v) {
                                        if (v != null) {
                                          ref
                                              .read(userStateProvider.notifier)
                                              .updateProfilePhoto(v.path);
                                        }
                                      },
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.edit),
                              )
                            ],
                          ),
                        ),
                      ),
                      const IconButton(onPressed: null, icon: SizedBox())
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: context.theme.appColors.cardColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        TextFormField(
                          readOnly: true,
                          initialValue: user.email,
                          decoration: InputDecoration(
                              hintText: user.email,
                              labelText: context.localizations!.email),
                        ),
                        if (ref.read(roleStateProvider) == Role.company)
                          const SizedBox(height: 10),
                        if (ref.read(roleStateProvider) == Role.company)
                          TextFormField(
                            initialValue: user.marketName,
                            decoration: InputDecoration(
                              hintText: user.marketName,
                              labelText: context.localizations!.market_name,
                            ),
                            onSaved: (v) => name = v,
                          ),
                        if (ref.read(roleStateProvider) != Role.company)
                          const SizedBox(height: 10),
                        if (ref.read(roleStateProvider) != Role.company)
                          TextFormField(
                            initialValue: user.name,
                            decoration: InputDecoration(
                              hintText: user.name,
                              labelText: context.localizations!.name,
                            ),
                            onSaved: (v) => name = v,
                          ),
                        if (ref.read(roleStateProvider) != Role.company)
                          const SizedBox(height: 10),
                        if (ref.read(roleStateProvider) != Role.company)
                          TextFormField(
                            initialValue: user.lastName,
                            decoration: InputDecoration(
                              hintText: user.name,
                              labelText: context.localizations!.lastname,
                            ),
                            onSaved: (v) => lastName = v,
                          ),
                        const SizedBox(height: 10),
                        TextFormField(
                          initialValue: user.phoneNumber,
                          decoration: InputDecoration(
                            hintText: user.phoneNumber,
                            labelText: context.localizations!.phone_number,
                          ),
                          onSaved: (v) => phoneNumber = v,
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          initialValue: user.taxNumber,
                          decoration: InputDecoration(
                            hintText: user.taxNumber,
                            labelText: context.localizations!.tax,
                          ),
                          onSaved: (v) => tax = v,
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          initialValue: user.website,
                          decoration: InputDecoration(
                            hintText: user.website,
                            labelText: context.localizations!.website,
                          ),
                          onSaved: (v) => website = v,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: context.theme.appColors.cardColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(context.localizations!.address),
                        const SizedBox(height: 10),
                        TextFormField(
                          initialValue: user.address?.country,
                          decoration: InputDecoration(
                            hintText: user.address?.country,
                            labelText: context.localizations!.country,
                          ),
                          onSaved: (v) => country = v,
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          initialValue: user.address?.state,
                          decoration: InputDecoration(
                            hintText: user.address?.state,
                            labelText: context.localizations!.state,
                          ),
                          onSaved: (v) => state = v,
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          initialValue: user.address?.city,
                          decoration: InputDecoration(
                            hintText: user.address?.city,
                            labelText: context.localizations!.city,
                          ),
                          onSaved: (v) => city = v,
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          initialValue: user.address?.town,
                          decoration: InputDecoration(
                            hintText: user.address?.town,
                            labelText: context.localizations!.town,
                          ),
                          onSaved: (v) => town = v,
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          initialValue: user.address?.street,
                          decoration: InputDecoration(
                            hintText: user.address?.street,
                            labelText: context.localizations!.street,
                          ),
                          onSaved: (v) => street = v,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                initialValue: user.address?.zipcode,
                                decoration: InputDecoration(
                                  hintText: user.address?.zipcode,
                                  labelText: context.localizations!.zipcode,
                                ),
                                onSaved: (v) => zipcode = v,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                initialValue: user.address?.no,
                                decoration: InputDecoration(
                                  hintText: user.address?.zipcode,
                                  labelText: context.localizations!.address_no,
                                ),
                                onSaved: (v) => no = v,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          initialValue: user.address?.additionalAddress,
                          decoration: InputDecoration(
                            hintText: user.address?.additionalAddress,
                            labelText:
                                context.localizations!.additional_address,
                          ),
                          onSaved: (v) => additionalAddress = v,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          late Address? address;
                          if (user.address == null) {
                            address = Address(
                                country: country,
                                state: state,
                                city: city,
                                street: street,
                                no: no,
                                zipcode: zipcode,
                                town: town,
                                additionalAddress: additionalAddress);
                          } else {
                            address = user.address!.copyWith(
                                country: country,
                                state: state,
                                city: city,
                                street: street,
                                no: no,
                                zipcode: zipcode,
                                town: town,
                                additionalAddress: additionalAddress);
                          }

                          AppUser newUser = user.copyWith(
                              name: name,
                              lastName: lastName,
                              phoneNumber: phoneNumber,
                              address: address,
                              website: website,
                              taxNumber: tax,
                              marketName: name);

                          bool result = await ref
                              .read(userStateProvider.notifier)
                              .updateUser(newUser, context);

                          if (result && context.mounted) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog.adaptive(
                                title: Text(context.localizations!.success),
                                content: Text(context.localizations!
                                    .your_profile_has_been_successfully_updated),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Ok'),
                                  ),
                                ],
                              ),
                            );
                          }
                        }
                      },
                      child: Text(context.localizations!.update),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

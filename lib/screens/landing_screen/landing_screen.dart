import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/global_providers/auth_state_provider.dart';
import '../../core/global_providers/customer_provider.dart';
import '../../core/global_providers/role_provider.dart';
import '../../core/global_providers/user_state_provider.dart';
import '../../core/models/user/user.dart';
import '../cart_screen/cart_screen.dart';
import '../cart_screen/providers/cart_provider.dart';
import '../controller_home_screen/controller_home_screen.dart';
import '../customers_screen/customers_screen.dart';
import '../customers_screen/providers/customers_provider.dart';
import '../favorites_screen/favorites_screen.dart';
import '../home_screen/home_screen.dart';
import '../orders_screen/orders_screen.dart';
import '../packaged_orders_screen/packaged_orders_screen.dart';
import '../profile_screen.dart';
import '../ready_orders_screen/ready_orders_screen.dart';
import '../reminders_screen/reminders_screen.dart';
import '../warehousepersone_home_screen/warehouseperson_home_screen.dart';
import '../on_sale_products_screen/on_sale_products_screen.dart';
import '../settings_screen/settings_screen.dart';

GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class LandingScreen extends ConsumerWidget {
  final String path;
  const LandingScreen({super.key, required this.path});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Role? role = ref.watch(roleStateProvider);
    AppUser? customer = ref.watch(customerStateProvider);
    AppUser? user = ref.read(userStateProvider);

    if (role == Role.admin) {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(context.localizations!
                  .you_are_an_admin_please_go_to_admin_dashboard),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                final Uri url = Uri.parse('https://wholesaler-admin.web.app');
                ref.read(authStateProvider.notifier).signOut();

                if (!await launchUrl(url)) {
                  throw Exception('Could not launch $url');
                }
              },
              child: const Text('Go'),
            )
          ],
        ),
      );
    }

    if (role == Role.salesResponsible && customer == null) {
      List<AppUser> customers = ref.watch(customersProvider);
      return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(context.localizations!.please_select_a_customer),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration:
                      InputDecoration(labelText: context.localizations!.search),
                  onChanged: (v) {
                    ref.watch(customersProvider.notifier).search(v);
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: customers.length,
                  itemBuilder: (context, index) => ListTile(
                    onTap: () {
                      ref
                          .watch(customerStateProvider.notifier)
                          .updateState(customers[index]);
                      ref.read(cartProvider.notifier).getCart();
                    },
                    leading: CircleAvatar(
                      backgroundImage: customers[index].photoURL != null
                          ? CachedNetworkImageProvider(
                              customers[index].photoURL!)
                          : null,
                      child: customers[index].photoURL == null
                          ? const Icon(Icons.person)
                          : null,
                    ),
                    title: Text(
                      customers[index].createFullName(),
                    ),
                    subtitle: Text(customers[index].email),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }

    return LayoutBuilder(builder: (context, boxconstraints) {
      return Scaffold(
        key: _scaffoldKey,
        appBar: path == '/'
            ? AppBar(
                title: Text(role == Role.salesResponsible
                    ? 'title - ${ref.read(customerStateProvider)?.createFullName()}'
                    : "title"),
                actions: [
                  if (role == Role.salesResponsible)
                    IconButton(
                      onPressed: () => ref
                          .read(customerStateProvider.notifier)
                          .updateState(null),
                      icon: const Icon(Icons.exit_to_app),
                    ),
                  if ((role == Role.company || role == Role.salesResponsible) &&
                      context.width > 601)
                    IconButton(
                      onPressed: () => context.go(CartScreen.routeName),
                      icon: const Icon(Icons.shopping_cart_checkout),
                    ),
                ],
              )
            : null,
        drawer: context.width < 600
            ? null
            : Drawer(
                child: ListView(
                  children: [
                    if (user != null)
                      ListTile(
                        leading: user.photoURL != null
                            ? CachedNetworkImage(
                                imageUrl: user.photoURL!, fit: BoxFit.cover)
                            : const Icon(Icons.person),
                        title: Text(user.createFullName()),
                        subtitle: Text(user.email),
                      ),
                    // DrawerHeader(
                    //   child: Column(
                    //     children: [
                    //       if (ref.read(authStateProvider)?.photoURL != null)
                    //         Expanded(
                    //           child: Container(
                    //             decoration: BoxDecoration(
                    //               image: DecorationImage(
                    //                   image: CachedNetworkImageProvider(ref
                    //                       .read(authStateProvider)!
                    //                       .photoURL!),
                    //                   fit: BoxFit.cover),
                    //             ),
                    //           ),
                    //         ),
                    //       Text(
                    //           'Welcome ${ref.read(authStateProvider)?.displayName}'),
                    //     ],
                    //   ),
                    // ),
                    ListTile(
                      leading: const Icon(Icons.home),
                      title: Text(context.localizations!.home),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        context.go('/');
                        _scaffoldKey.currentState!.openEndDrawer();
                      },
                    ),
                    if (ref.read(roleStateProvider) == Role.warehouseperson)
                      const Divider(),
                    if (ref.read(roleStateProvider) == Role.warehouseperson)
                      ListTile(
                        leading: const Icon(Icons.receipt_long),
                        title: Text(context.localizations!.order_history),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          context.go(ReadyOrdersScreen.routeName);
                          _scaffoldKey.currentState!.openEndDrawer();
                        },
                      ),
                    if (ref.read(roleStateProvider) == Role.controller)
                      const Divider(),
                    if (ref.read(roleStateProvider) == Role.controller)
                      ListTile(
                        leading: const Icon(Icons.receipt_long),
                        title: Text(context.localizations!.order_history),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          context.go(PackagedOrdersScreen.routeName);
                          _scaffoldKey.currentState!.openEndDrawer();
                        },
                      ),
                    if (ref.read(roleStateProvider) == Role.salesResponsible)
                      const Divider(),
                    if (ref.read(roleStateProvider) == Role.salesResponsible)
                      ListTile(
                        leading: const Icon(Icons.circle_notifications),
                        title: Text(context.localizations!.reminders),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          _scaffoldKey.currentState!.openEndDrawer();
                          context.go(RemindersScreen.routeName);
                        },
                      ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.person_pin),
                      title: Text(context.localizations!.profile),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        context.go(ProfileScreen.routeName);
                        _scaffoldKey.currentState!.openEndDrawer();
                      },
                    ),
                    if (ref.read(roleStateProvider) == Role.salesResponsible ||
                        ref.read(roleStateProvider) == Role.company)
                      const Divider(),
                    if (ref.read(roleStateProvider) == Role.salesResponsible ||
                        ref.read(roleStateProvider) == Role.company)
                      ListTile(
                        leading: const Icon(Icons.sell),
                        title: Text(context.localizations!.on_sale),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          context.push(OnSaleProductsScreen.routeName);
                          _scaffoldKey.currentState!.openEndDrawer();
                        },
                      ),
                    if (ref.read(roleStateProvider) == Role.salesResponsible)
                      const Divider(),
                    if (ref.read(roleStateProvider) == Role.salesResponsible)
                      ListTile(
                        leading: const Icon(Icons.groups),
                        title: Text(context.localizations!.customers),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          context.go(CustomersScreen.routeName);
                          _scaffoldKey.currentState!.openEndDrawer();
                        },
                      ),
                    if (ref.read(roleStateProvider) == Role.salesResponsible ||
                        ref.read(roleStateProvider) == Role.company)
                      const Divider(),
                    if (ref.read(roleStateProvider) == Role.salesResponsible ||
                        ref.read(roleStateProvider) == Role.company)
                      ListTile(
                        leading: const Icon(Icons.favorite),
                        title: Text(context.localizations!.favorites),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          context.go(FavoritesScreen.routeName);
                          _scaffoldKey.currentState!.openEndDrawer();
                        },
                      ),
                    if (ref.read(roleStateProvider) == Role.salesResponsible ||
                        ref.read(roleStateProvider) == Role.company)
                      const Divider(),
                    if (ref.read(roleStateProvider) == Role.salesResponsible ||
                        ref.read(roleStateProvider) == Role.company)
                      ListTile(
                        leading: const Icon(Icons.receipt_long),
                        title: Text(context.localizations!.order_history),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          context.go(OrdersScreen.routeName);
                          _scaffoldKey.currentState!.openEndDrawer();
                        },
                      ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.settings),
                      title: Text(context.localizations!.settings),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        context.go(SettingsScreen.routeName);
                        _scaffoldKey.currentState!.openEndDrawer();
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.exit_to_app),
                      title: Text(context.localizations!.log_out),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      tileColor: context.theme.appColors.danger,
                      onTap: () {
                        ref.read(authStateProvider.notifier).signOut();
                      },
                    ),
                    const Divider(),
                  ],
                ),
              ),
        bottomNavigationBar:
            context.width > 700 ? null : buildbottomMenu(context, ref, role),
        body: Row(
          children: [
            if (boxconstraints.maxWidth > 600)
              SingleChildScrollView(
                child: ConstrainedBox(
                  constraints:
                      BoxConstraints(minHeight: boxconstraints.maxHeight),
                  child: IntrinsicHeight(
                    child:
                        buildNavigationRail(boxconstraints, context, ref, role),
                  ),
                ),
              ),
            Expanded(
              child: _buildBoddy(role),
            )
          ],
        ),
      );
    });
  }

  NavigationRail buildNavigationRail(BoxConstraints boxconstraints,
      BuildContext context, WidgetRef ref, Role? role) {
    if (role == Role.company || role == Role.salesResponsible) {
      return NavigationRail(
        extended: boxconstraints.maxWidth > 900,
        onDestinationSelected: (index) {
          switch (index) {
            case 0:
              context.go('/');
              break;
            case 1:
              context.go(OrdersScreen.routeName);
              break;
            case 2:
              context.go(CartScreen.routeName);
              break;
            case 3:
              context.go(FavoritesScreen.routeName);
              break;
            case 4:
              context.go(ProfileScreen.routeName);
              break;
            case 5:
              ref.read(authStateProvider.notifier).signOut();
              break;
            default:
              context.go('/');
          }
        },
        destinations: [
          NavigationRailDestination(
            icon: SvgPicture.asset(
              "assets/images/shop.svg",
              colorFilter: ColorFilter.mode(
                context.theme.appColors.svgIconColor,
                BlendMode.srcIn,
              ),
            ),
            label: Text(context.localizations!.home),
            selectedIcon: SvgPicture.asset(
              "assets/images/shop.svg",
            ),
          ),
          NavigationRailDestination(
            label: Text(context.localizations!.order_history),
            icon: SvgPicture.asset(
              "assets/images/orders.svg",
              colorFilter: ColorFilter.mode(
                context.theme.appColors.svgIconColor,
                BlendMode.srcIn,
              ),
            ),
            selectedIcon: SvgPicture.asset(
              "assets/images/orders.svg",
              colorFilter: ColorFilter.mode(
                context.theme.appColors.primary,
                BlendMode.srcIn,
              ),
            ),
          ),
          NavigationRailDestination(
            icon: Badge(
              backgroundColor: context.theme.primaryColor,
              isLabelVisible: ref.watch(cartProvider).isNotEmpty,
              label: Text(ref.watch(cartProvider).length.toString()),
              offset: const Offset(10, -10),
              child: SvgPicture.asset(
                "assets/images/cart.svg",
                colorFilter: ColorFilter.mode(
                  context.theme.appColors.svgIconColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
            selectedIcon: Badge(
              backgroundColor: context.theme.primaryColor,
              isLabelVisible: ref.watch(cartProvider).isNotEmpty,
              label: Text(ref.watch(cartProvider).length.toString()),
              offset: const Offset(10, -10),
              child: SvgPicture.asset(
                "assets/images/cart.svg",
              ),
            ),
            label: Text(context.localizations!.cart),
          ),
          NavigationRailDestination(
            icon: SvgPicture.asset(
              "assets/images/favorite.svg",
              colorFilter: ColorFilter.mode(
                context.theme.appColors.svgIconColor,
                BlendMode.srcIn,
              ),
            ),
            selectedIcon: SvgPicture.asset(
              "assets/images/favorite.svg",
            ),
            label: Text(context.localizations!.favorites),
          ),
          NavigationRailDestination(
            icon: SvgPicture.asset(
              "assets/images/user.svg",
              colorFilter: ColorFilter.mode(
                context.theme.appColors.svgIconColor,
                BlendMode.srcIn,
              ),
            ),
            selectedIcon: SvgPicture.asset(
              "assets/images/user.svg",
            ),
            label: Text(context.localizations!.profile),
          ),
          NavigationRailDestination(
            icon: const Icon(Icons.exit_to_app),
            label: Text(context.localizations!.log_out),
          ),
        ],
        selectedIndex: findBottomNavbarIndex(role),
      );
    } else {
      return NavigationRail(
        extended: boxconstraints.maxWidth > 900,
        onDestinationSelected: (index) {
          switch (index) {
            case 0:
              context.go('/');
              break;

            case 1:
              context.go(ProfileScreen.routeName);
              break;
            case 2:
              ref.read(authStateProvider.notifier).signOut();
              break;
            default:
              context.go('/');
          }
        },
        destinations: [
          NavigationRailDestination(
            icon: SvgPicture.asset(
              "assets/images/shop.svg",
              colorFilter: ColorFilter.mode(
                context.theme.appColors.svgIconColor,
                BlendMode.srcIn,
              ),
            ),
            label: Text(context.localizations!.home),
            selectedIcon: SvgPicture.asset(
              "assets/images/shop.svg",
            ),
          ),
          NavigationRailDestination(
            icon: SvgPicture.asset(
              "assets/images/user.svg",
              colorFilter: ColorFilter.mode(
                context.theme.appColors.svgIconColor,
                BlendMode.srcIn,
              ),
            ),
            selectedIcon: SvgPicture.asset(
              "assets/images/user.svg",
            ),
            label: Text(context.localizations!.profile),
          ),
          NavigationRailDestination(
            icon: const Icon(Icons.exit_to_app),
            label: Text(context.localizations!.log_out),
          ),
        ],
        selectedIndex: findBottomNavbarIndex(role),
      );
    }
  }

  Widget? buildbottomMenu(BuildContext context, WidgetRef ref, Role? role) {
    if (role == Role.company || role == Role.salesResponsible) {
      return NavigationBar(
        selectedIndex: findBottomNavbarIndex(role),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        onDestinationSelected: (index) {
          switch (index) {
            case 0:
              context.go('/');
              break;
            case 1:
              context.go(OrdersScreen.routeName);
              break;
            case 2:
              context.go(CartScreen.routeName);
              break;
            case 3:
              context.go(FavoritesScreen.routeName);
              break;
            case 4:
              context.go(ProfileScreen.routeName);
              break;
            default:
              context.go('/');
          }
        },
        destinations: [
          NavigationDestination(
            icon: SvgPicture.asset(
              "assets/images/shop.svg",
              colorFilter: ColorFilter.mode(
                context.theme.appColors.svgIconColor,
                BlendMode.srcIn,
              ),
            ),
            selectedIcon: SvgPicture.asset(
              "assets/images/shop.svg",
            ),
            label: 'Shop',
          ),
          NavigationDestination(
            icon: SvgPicture.asset(
              "assets/images/orders.svg",
              colorFilter: ColorFilter.mode(
                context.theme.appColors.svgIconColor,
                BlendMode.srcIn,
              ),
            ),
            selectedIcon: SvgPicture.asset(
              "assets/images/orders.svg",
              colorFilter: ColorFilter.mode(
                context.theme.appColors.primary,
                BlendMode.srcIn,
              ),
            ),
            label: context.localizations!.order_history,
          ),
          NavigationDestination(
            icon: Badge(
              backgroundColor: context.theme.primaryColor,
              isLabelVisible: ref.watch(cartProvider).isNotEmpty,
              label: Text(ref.watch(cartProvider).length.toString()),
              offset: const Offset(10, -10),
              child: SvgPicture.asset(
                "assets/images/cart.svg",
                colorFilter: ColorFilter.mode(
                  context.theme.appColors.svgIconColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
            selectedIcon: Badge(
              backgroundColor: context.theme.primaryColor,
              isLabelVisible: ref.watch(cartProvider).isNotEmpty,
              label: Text(ref.watch(cartProvider).length.toString()),
              offset: const Offset(10, -10),
              child: SvgPicture.asset(
                "assets/images/cart.svg",
              ),
            ),
            label: context.localizations!.cart,
          ),
          NavigationDestination(
            icon: SvgPicture.asset(
              "assets/images/favorite.svg",
              colorFilter: ColorFilter.mode(
                context.theme.appColors.svgIconColor,
                BlendMode.srcIn,
              ),
            ),
            selectedIcon: SvgPicture.asset(
              "assets/images/favorite.svg",
            ),
            label: 'Favorites',
          ),
          NavigationDestination(
            icon: SvgPicture.asset(
              "assets/images/user.svg",
              colorFilter: ColorFilter.mode(
                context.theme.appColors.svgIconColor,
                BlendMode.srcIn,
              ),
            ),
            selectedIcon: SvgPicture.asset(
              "assets/images/user.svg",
            ),
            label: context.localizations!.profile,
          ),
        ],
      );
    } else if (role == Role.warehouseperson || role == Role.controller) {
      return NavigationBar(
        selectedIndex: findBottomNavbarIndex(role),
        onDestinationSelected: (index) {
          switch (index) {
            case 0:
              context.go('/');
              break;

            case 1:
              context.go(ProfileScreen.routeName);
              break;
            default:
              context.go('/');
          }
        },
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home),
            selectedIcon: Icon(
              Icons.home,
              color: context.theme.appColors.primary,
            ),
            label: 'Shop',
          ),
          NavigationDestination(
            icon: SvgPicture.asset(
              "assets/images/user.svg",
              colorFilter: ColorFilter.mode(
                context.theme.appColors.svgIconColor,
                BlendMode.srcIn,
              ),
            ),
            selectedIcon: SvgPicture.asset(
              "assets/images/user.svg",
            ),
            label: context.localizations!.profile,
          ),
        ],
      );
    } else {
      return null;
    }
  }

  Widget _buildBoddy(Role? role) {
    switch (path) {
      case '/':
        if (role == Role.warehouseperson) {
          return const WarehousePersonHomeScreen();
        } else if (role == Role.controller) {
          return const ControllerHomeScreen();
        }

        return const HomeScreen();

      case '/profile':
        return const ProfileScreen();
      case '/reminders':
        return const RemindersScreen();
      case '/settings':
        return const SettingsScreen();
      case '/customers':
        return const CustomersScreen();
      case '/favorites':
        return const FavoritesScreen();
      case '/orders':
        return const OrdersScreen();
      case ReadyOrdersScreen.routeName:
        return const ReadyOrdersScreen();
      case PackagedOrdersScreen.routeName:
        return const PackagedOrdersScreen();
      case CartScreen.routeName:
        return const CartScreen();

      default:
        return const HomeScreen();
    }
  }

  int findIndex() {
    switch (path) {
      case '/':
        return 0;

      case '/reminders':
        return 1;

      case '/profile':
        return 2;
      case '/customers':
        return 4;
      case '/favorites':
        return 5;
      case '/orders':
        return 6;

      case '/settings':
        return 8;

      default:
        return 0;
    }
  }

  int findBottomNavbarIndex(Role? role) {
    if (role == Role.company || role == Role.salesResponsible) {
      switch (path) {
        case '/':
          return 0;
        case '/orders':
          return 1;
        case '/cart':
          return 2;
        case '/favorites':
          return 3;
        case '/profile':
          return 4;
        default:
          return 0;
      }
    } else if (role == Role.warehouseperson || role == Role.controller) {
      switch (path) {
        case '/':
          return 0;
        case '/profile':
          return 1;
        default:
          return 0;
      }
    } else {
      return 0;
    }
  }
}

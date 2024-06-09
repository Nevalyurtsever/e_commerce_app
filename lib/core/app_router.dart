import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../screens/cart_screen/cart_screen.dart';
import '../screens/customers_screen/customers_screen.dart';
import '../screens/edit_profile_screen.dart';
import '../screens/email_verify_screen.dart';
import '../screens/favorites_screen/favorites_screen.dart';
import '../screens/landing_screen/landing_screen.dart';
import '../screens/new_arrivals_screen/new_arrivals_screen.dart';
import '../screens/on_sale_products_screen/on_sale_products_screen.dart';
import '../screens/order_details_screen/order_details_screen.dart';
import '../screens/order_details_screen/order_details_warepersone_screen.dart';
import '../screens/order_success_screen.dart';
import '../screens/orders_screen/orders_screen.dart';
import '../screens/packaged_orders_screen/packaged_orders_screen.dart';
import '../screens/privaciy_policy.dart';
import '../screens/product_screen/product_screen.dart';
import '../screens/products_screen/products_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/ready_orders_screen/ready_orders_screen.dart';
import '../screens/reminders_screen/new_reminder_screen.dart';
import '../screens/reminders_screen/reminders_screen.dart';
import '../screens/settings_screen/settings_screen.dart';
import '../screens/sign_in_screen.dart';
import 'global_providers/auth_state_provider.dart';
import 'models/product.dart';

final GlobalKey<NavigatorState> rootNavigator =
    GlobalKey<NavigatorState>(debugLabel: 'Main Navigator');
final GlobalKey<NavigatorState> shellNavigator =
    GlobalKey<NavigatorState>(debugLabel: 'Shell Navigator');

final goRouterProvider = Provider<GoRouter>((ref) {
  final router = RouterNotifier(ref);

  return GoRouter(
      refreshListenable: router,
      routes: router._routes,
      navigatorKey: rootNavigator,
      initialLocation: '/');
});

class RouterNotifier extends ChangeNotifier {
  final Ref _ref;
  User? user;

  RouterNotifier(this._ref) {
    _ref.listen<User?>(
      authStateProvider,
      (previus, next) {
        user = next;

        notifyListeners();
      },
    );
  }

  List<RouteBase> get _routes => [
        GoRoute(
          path: LoginScreen.routeName,
          parentNavigatorKey: rootNavigator,
          builder: (context, state) => const LoginScreen(),
          redirect: (context, state) {
            if (user == null) {
              return null;
            } else {
              if (user!.emailVerified) {
                return "/";
              } else {
                return EmailVerifyScreen.routeName;
              }
            }
          },
        ),
        GoRoute(
          path: EmailVerifyScreen.routeName,
          parentNavigatorKey: rootNavigator,
          builder: (context, state) => const EmailVerifyScreen(),
          redirect: (context, state) {
            if (user == null) {
              return LoginScreen.routeName;
            } else {
              if (user!.emailVerified) {
                return "/";
              } else {
                return null;
              }
            }
          },
        ),
        GoRoute(
          path: NewReminderScreen.routeName,
          parentNavigatorKey: rootNavigator,
          builder: (context, state) => const NewReminderScreen(),
          redirect: (context, state) {
            if (user == null) {
              return LoginScreen.routeName;
            } else {
              if (!user!.emailVerified) {
                return EmailVerifyScreen.routeName;
              } else {
                return null;
              }
            }
          },
        ),
        GoRoute(
          path: OnSaleProductsScreen.routeName,
          parentNavigatorKey: rootNavigator,
          builder: (context, state) => const OnSaleProductsScreen(),
          redirect: (context, state) {
            if (user == null) {
              return LoginScreen.routeName;
            } else {
              if (!user!.emailVerified) {
                return EmailVerifyScreen.routeName;
              } else {
                return null;
              }
            }
          },
        ),
        GoRoute(
          path: NewArrivalsScreen.routeName,
          parentNavigatorKey: rootNavigator,
          builder: (context, state) => const NewArrivalsScreen(),
          redirect: (context, state) {
            if (user == null) {
              return LoginScreen.routeName;
            } else {
              if (!user!.emailVerified) {
                return EmailVerifyScreen.routeName;
              } else {
                return null;
              }
            }
          },
        ),
        GoRoute(
          path: '${ProductScreen.routeName}/:productId',
          parentNavigatorKey: rootNavigator,
          builder: (context, state) {
            Product? product = state.extra as Product?;
            return ProductScreen(
              productId: state.pathParameters['productId'].toString(),
              product: product,
            );
          },
          redirect: (context, state) {
            if (user == null) {
              return LoginScreen.routeName;
            } else {
              if (!user!.emailVerified) {
                return EmailVerifyScreen.routeName;
              } else {
                return null;
              }
            }
          },
        ),
        GoRoute(
          path: OrderSuccessScreen.routeName,
          parentNavigatorKey: rootNavigator,
          builder: (context, state) {
            Map? details = state.extra as Map?;
            return OrderSuccessScreen(details: details);
          },
        ),
        GoRoute(
          path: '${OrderDetailsScreen.routeName}/:orderId',
          parentNavigatorKey: rootNavigator,
          builder: (context, state) {
            return OrderDetailsScreen(
              orderId: state.pathParameters['orderId'].toString(),
            );
          },
          redirect: (context, state) {
            if (user == null) {
              return LoginScreen.routeName;
            } else {
              if (!user!.emailVerified) {
                return EmailVerifyScreen.routeName;
              } else {
                return null;
              }
            }
          },
        ),
        GoRoute(
          path: '${OrderDetailsWarePersonScreen.routeName}/:orderId',
          parentNavigatorKey: rootNavigator,
          builder: (context, state) {
            return OrderDetailsWarePersonScreen(
              orderId: state.pathParameters['orderId'].toString(),
            );
          },
          redirect: (context, state) {
            if (user == null) {
              return LoginScreen.routeName;
            } else {
              if (!user!.emailVerified) {
                return EmailVerifyScreen.routeName;
              } else {
                return null;
              }
            }
          },
        ),
        GoRoute(
          path: EditProfileScreen.routeName,
          parentNavigatorKey: rootNavigator,
          builder: (context, state) => const EditProfileScreen(),
          redirect: (context, state) {
            if (user == null) {
              return LoginScreen.routeName;
            } else {
              if (!user!.emailVerified) {
                return EmailVerifyScreen.routeName;
              } else {
                return null;
              }
            }
          },
        ),
        GoRoute(
          path: RemindersScreen.routeName,
          parentNavigatorKey: rootNavigator,
          builder: (context, state) => const RemindersScreen(),
          redirect: (context, state) {
            if (user == null) {
              return LoginScreen.routeName;
            } else {
              if (!user!.emailVerified) {
                return EmailVerifyScreen.routeName;
              } else {
                return null;
              }
            }
          },
        ),
        GoRoute(
          path: CustomersScreen.routeName,
          parentNavigatorKey: rootNavigator,
          builder: (context, state) => const CustomersScreen(),
          redirect: (context, state) {
            if (user == null) {
              return LoginScreen.routeName;
            } else {
              if (!user!.emailVerified) {
                return EmailVerifyScreen.routeName;
              } else {
                return null;
              }
            }
          },
        ),
        GoRoute(
          path: ProductsScreen.routeName,
          parentNavigatorKey: rootNavigator,
          builder: (context, state) => const ProductsScreen(),
        ),
        GoRoute(
          path: PrivacyPolicyScreen.routeName,
          parentNavigatorKey: rootNavigator,
          builder: (context, state) => const PrivacyPolicyScreen(),
        ),
        ShellRoute(
          navigatorKey: shellNavigator,
          builder: (BuildContext context, GoRouterState state, Widget child) {
            return LandingScreen(path: state.fullPath.toString());
          },
          routes: [
            GoRoute(
                path: '/',
                parentNavigatorKey: shellNavigator,
                builder: (context, state) =>
                    LandingScreen(path: state.path.toString()),
                redirect: (context, state) {
                  if (user == null) {
                    return LoginScreen.routeName;
                  } else {
                    if (!user!.emailVerified) {
                      return EmailVerifyScreen.routeName;
                    } else {
                      return null;
                    }
                  }
                }),
            GoRoute(
              path: ProfileScreen.routeName,
              parentNavigatorKey: shellNavigator,
              builder: (context, state) => const ProfileScreen(),
              redirect: (context, state) {
                if (user == null) {
                  return LoginScreen.routeName;
                } else {
                  if (!user!.emailVerified) {
                    return EmailVerifyScreen.routeName;
                  } else {
                    return null;
                  }
                }
              },
            ),
            GoRoute(
              path: CartScreen.routeName,
              parentNavigatorKey: shellNavigator,
              builder: (context, state) => const CartScreen(),
              redirect: (context, state) {
                if (user == null) {
                  return LoginScreen.routeName;
                } else {
                  if (!user!.emailVerified) {
                    return EmailVerifyScreen.routeName;
                  } else {
                    return null;
                  }
                }
              },
            ),
            GoRoute(
              path: SettingsScreen.routeName,
              parentNavigatorKey: shellNavigator,
              builder: (context, state) => const SettingsScreen(),
              redirect: (context, state) {
                if (user == null) {
                  return LoginScreen.routeName;
                } else {
                  if (!user!.emailVerified) {
                    return EmailVerifyScreen.routeName;
                  } else {
                    return null;
                  }
                }
              },
            ),
            GoRoute(
              path: FavoritesScreen.routeName,
              parentNavigatorKey: shellNavigator,
              builder: (context, state) => const FavoritesScreen(),
              redirect: (context, state) {
                if (user == null) {
                  return LoginScreen.routeName;
                } else {
                  if (!user!.emailVerified) {
                    return EmailVerifyScreen.routeName;
                  } else {
                    return null;
                  }
                }
              },
            ),
            GoRoute(
              path: OrdersScreen.routeName,
              parentNavigatorKey: shellNavigator,
              builder: (context, state) => const OrdersScreen(),
              redirect: (context, state) {
                if (user == null) {
                  return LoginScreen.routeName;
                } else {
                  if (!user!.emailVerified) {
                    return EmailVerifyScreen.routeName;
                  } else {
                    return null;
                  }
                }
              },
            ),
            GoRoute(
              path: ReadyOrdersScreen.routeName,
              parentNavigatorKey: shellNavigator,
              builder: (context, state) => const ReadyOrdersScreen(),
              redirect: (context, state) {
                if (user == null) {
                  return LoginScreen.routeName;
                } else {
                  if (!user!.emailVerified) {
                    return EmailVerifyScreen.routeName;
                  } else {
                    return null;
                  }
                }
              },
            ),
            GoRoute(
              path: PackagedOrdersScreen.routeName,
              parentNavigatorKey: shellNavigator,
              builder: (context, state) => const PackagedOrdersScreen(),
              redirect: (context, state) {
                if (user == null) {
                  return LoginScreen.routeName;
                } else {
                  if (!user!.emailVerified) {
                    return EmailVerifyScreen.routeName;
                  } else {
                    return null;
                  }
                }
              },
            ),
          ],
        ),
      ];
}

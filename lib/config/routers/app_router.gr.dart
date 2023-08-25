// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:xmed/features/documents_managment/presentation/pages/documents_managment_page.dart'
    as _i1;
import 'package:xmed/features/login/presentation/pages/login.view.dart' as _i2;

abstract class $AppRouter extends _i3.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    DocumentsManagmentRoute.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.DocumentsManagmentPage(),
      );
    },
    LoginView.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.LoginView(),
      );
    },
  };
}

/// generated route for
/// [_i1.DocumentsManagmentPage]
class DocumentsManagmentRoute extends _i3.PageRouteInfo<void> {
  const DocumentsManagmentRoute({List<_i3.PageRouteInfo>? children})
      : super(
          DocumentsManagmentRoute.name,
          initialChildren: children,
        );

  static const String name = 'DocumentsManagmentRoute';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
}

/// generated route for
/// [_i2.LoginView]
class LoginView extends _i3.PageRouteInfo<void> {
  const LoginView({List<_i3.PageRouteInfo>? children})
      : super(
          LoginView.name,
          initialChildren: children,
        );

  static const String name = 'LoginView';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
}

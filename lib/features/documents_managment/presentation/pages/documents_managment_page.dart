import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xmed/features/documents_managment/presentation/cubits/documents/documents_cubit.dart';
import 'package:xmed/features/documents_managment/presentation/widgets/documents_list_tablet_page.dart';

import '../../../../config/routers/app_router.dart';
import '../../../../config/routers/app_router.gr.dart';
import '../../../login/presentation/cubits/login/login_cubit.dart';
import '../widgets/documents_list_mobile_page.dart';

@RoutePage()
class DocumentsManagmentPage extends StatelessWidget {
  const DocumentsManagmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          final loginCubitState = context.read<LoginCubit>().state;
          if (loginCubitState is NotLoggedState) {
            // WHEN LOGGED NAVIGATE TO DOCUMENTS VIEW Layout
            appRouter.replace(const LoginView());
          }
        },
        child: BlocProvider(
          create: (context) => DocumentsListCubit()..sync([]),
          child: LayoutBuilder(builder: (builder, constraints) {
            if (constraints.maxWidth > 1024)
              return DocumentsListTabletLayout();
            else
              return DocumentsListMobileLayout();
          }),
        ));
  }
}

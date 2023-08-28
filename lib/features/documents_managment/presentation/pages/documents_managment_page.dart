import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xmed/features/documents_managment/data/repositories/documents_managment_repository_impl.dart';
import 'package:xmed/features/documents_managment/domain/repositories/documents_managment_repository.dart';
import 'package:xmed/features/documents_managment/presentation/cubits/documents/documents_cubit.dart';
import 'package:xmed/features/documents_managment/presentation/widgets/documents_list_tablet_page.dart';
import 'package:xmed/features/whitelabeling/data/repositories/theme_repository_impl.dart';
import 'package:xmed/features/whitelabeling/domain/entities/theme.dart';
import 'package:xmed/features/whitelabeling/domain/repositories/theme_repository.dart';
import 'package:xmed/features/whitelabeling/presentation/cubits/theme/theme_cubit.dart';

import '../../../../config/routers/app_router.dart';
import '../../../../config/routers/app_router.gr.dart';
import '../../../login/presentation/cubits/login/login_cubit.dart';
import '../widgets/documents_list_mobile_page.dart';

@RoutePage()
class DocumentsManagmentPage extends StatefulWidget {
  // REPOSITORY DECLARATION
  late final ThemeRepository themeRepository;
  late final DocumentsManagmentRepository documentsRepository;

  // CUBITS DECLARATION
  late final DocumentsListCubit documentsCubit;
  late final ThemeCubit themeCubit;

  DocumentsManagmentPage({super.key});

  @override
  State<DocumentsManagmentPage> createState() => _DocumentsManagmentPageState();
}

class _DocumentsManagmentPageState extends State<DocumentsManagmentPage> {
  @override
  void initState() {
    super.initState();
    // REPOSITORY INITIALIZATION
    widget.documentsRepository = DocumentsManagmentRepositoryImpl();
    widget.themeRepository = ThemeRepositoryImpl();

    // CUBITS INITIALIZATION
    widget.documentsCubit = DocumentsListCubit(
        documentsRepository: widget.documentsRepository,
        currentUser: context.read<LoginCubit>().currentUser);
    widget.themeCubit = ThemeCubit(
        themeRepository: widget.themeRepository,
        loginCubit: context.read<LoginCubit>());

    // INIT FUNCTIONS
    widget.documentsCubit.onInit();
    widget.themeCubit.synch(theme: XmedTheme.defaultTheme());
  }

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
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => widget.documentsCubit,
            ),
            BlocProvider(
              create: (context) => widget.themeCubit,
            ),
          ],
          child: LayoutBuilder(builder: (builder, constraints) {
            if (constraints.maxWidth > 1024) {
              return const DocumentsListTabletLayout();
            } else {
              return const DocumentsListMobileLayout();
            }
          }),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}

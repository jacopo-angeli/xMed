import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xmed/features/documents_managment/data/repositories/documents_managment_repository_impl.dart';
import 'package:xmed/features/documents_managment/domain/repositories/documents_managment_repository.dart';
import 'package:xmed/features/documents_managment/domain/repositories/namirial_documents_repository.dart';
import 'package:xmed/features/documents_managment/presentation/cubits/documents/documents_cubit.dart';
import 'package:xmed/features/documents_managment/presentation/widgets/documents_list_tablet_page.dart';
import 'package:xmed/features/license/data/repositories/license_repository_impl.dart';
import 'package:xmed/features/license/data/repositories/namirial_sdk_repository_impl.dart';
import 'package:xmed/features/license/domain/repositories/license_repository.dart';
import 'package:xmed/features/license/domain/repositories/namirial_sdk_repository.dart';
import 'package:xmed/features/license/presentation/cubits/license_cubit.dart';
import 'package:xmed/features/whitelabeling/presentation/cubits/theme/theme_cubit.dart';

import '../../../../config/routers/app_router.dart';
import '../../../../config/routers/app_router.gr.dart';
import '../../../connection/presentation/cubits/internet/internet_cubit.dart';
import '../../../login/presentation/cubits/login/login_cubit.dart';
import '../../data/repositories/namirial_documentation_repository_impl.dart';
import '../widgets/documents_list_mobile_page.dart';

@RoutePage()
class DocumentsManagmentPage extends StatefulWidget {
  // REPOSITORY DECLARATION
  late final DocumentsManagmentRepository documentsRepository;
  late final LicenseRepository licenseRepository;
  late final NamirialSDKLicenseRepository namirialSKDLicenseRepository;
  late final NamirialSDKDocumentsRepository namirialSDKDocumentsRepository;

  // CUBITS DECLARATION
  late final DocumentsListCubit documentsCubit;
  late final InternetCubit internetCubit;
  late final LicenseCubit licenseCubit;
       // ignore: prefer_const_constructors_in_immutables
       DocumentsManagmentPage({super.key}); //! Modificare sto const che si rimette in automatico idem in Main line 55

  @override
  State<DocumentsManagmentPage> createState() => _DocumentsManagmentPageState();
}

class _DocumentsManagmentPageState extends State<DocumentsManagmentPage> {
  @override
  void initState() {
    super.initState();
    // REPOSITORY INITIALIZATION
    widget.documentsRepository = DocumentsManagmentRepositoryImpl();
    widget.licenseRepository = LicenseRepositoryImpl();
    widget.namirialSKDLicenseRepository = NamirialSDKLicenseRepositoryImpl();
    widget.namirialSDKDocumentsRepository =
        NamirialSDKDocumentsRepositoryImpl();

    // CUBITS INITIALIZATION
    widget.documentsCubit = DocumentsListCubit(
        documentsRepository: widget.documentsRepository,
        internetCubit: InternetCubit(
            connectivity: context.read<InternetCubit>().connectivity),
        currentUser: context.read<LoginCubit>().currentUser);
    widget.licenseCubit = LicenseCubit(
        licenseRepository: widget.licenseRepository,
        currentUser: context.read<LoginCubit>().currentUser,
        namirialRepository: widget.namirialSKDLicenseRepository);

    // INIT FUNCTIONS
    context
        .read<ThemeCubit>()
        .synch(currentTheme: context.read<ThemeCubit>().state.currentTheme);
    widget.licenseCubit.setup();
    widget.documentsCubit.sync();
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
              create: (context) => widget.licenseCubit,
            ),
          ],
          child: BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return LayoutBuilder(builder: (builder, constraints) {
                if (constraints.maxWidth > 1024) {
                  return DocumentsListTabletLayout(
                    namirialSDKDocumentsRepository:
                        widget.namirialSDKDocumentsRepository,
                    documentsManagmentRepository: widget.documentsRepository,
                    currentUser: context.read<LoginCubit>().currentUser,
                  );
                } else {
                  return DocumentsListMobileLayout(
                    namirialSDKDocumentsRepository:
                        widget.namirialSDKDocumentsRepository,
                    documentsManagmentRepository: widget.documentsRepository,
                    currentUser: context.read<LoginCubit>().currentUser,
                  );
                }
              });
            },
          ),
        ));
  }

  @override
  void dispose() {
    widget.documentsCubit.close();
    super.dispose();
  }
}

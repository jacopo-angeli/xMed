import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

/// La classe principale di configurazione dei percorsi per l'app.
@AutoRouterConfig() // Utilizzo di AutoRoute.
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.cupertino();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginView.page, initial: true),
        AutoRoute(page: DocumentsManagmentRoute.page),
      ];
}

// Creazione di un'istanza della classe di configurazione dei percorsi.
final appRouter = AppRouter();

/// La classe [AppRouter] gestisce la navigazione e la gestione dei percorsi all2'interno dell'app.
///
/// Questa classe estende la classe generata `_$AppRouter`, creata tramite
/// il processo di generazione del codice AutoRoute. Configura il comportamento
/// di navigazione e definisce l'elenco dei percorsi disponibili nell'app.
///
/// Per utilizzare questo router, crea semplicemente un'istanza di [AppRouter] e usa i suoi
/// metodi per navigare tra le diverse schermate.
///
/// Esempio di utilizzo:
/// appRouter.navigateTo(LoginRoute()); // Naviga alla pagina di accesso.
///
/// Per il comportamento di navigazione predefinito, [defaultRouteType] è impostato su
/// [RouteType.adaptive()], consentendo all'app di adattarsi tra diversi
/// stili di navigazione in base alla piattaforma.
///
/// L'elenco [routes] definisce i percorsi disponibili nell'app. Attualmente,
/// è definita solo la pagina [LoginView] come percorso iniziale, ma puoi
/// aggiungere ulteriori percorsi secondo necessità.

/// L'istanza [appRouter] fornisce un accesso singleton all'[AppRouter].
///
/// (AI generated)

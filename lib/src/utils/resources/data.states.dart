import 'package:dio/dio.dart';

/// Rappresenta lo stato dei dati generico.
///
/// Da questa classe vengono generate due classi più specifiche che rappresentano i due
/// risultati possibili di una chiamata ad un servizio web. Il risultato può essere
/// un successo o un fallimento.
///
/// La classe viene templatizzata per l'utilizzo con qualsiasi tipologia di dati.
abstract class DataState<T> {
  final T? data; // Dati generici di tipo T
  final DioException? error; // Possibile eccezione di tipo DioException

  /// Costruttore della classe astratta DataState.
  ///
  /// [data]: I dati che lo stato di success conterrà.
  /// [error]: L'eccezione che lo stato di fallimento conterrà.
  const DataState({this.data, this.error});
}

/// Rappresenta uno stato di successo dei dati.
///
/// Questa classe rappresenta uno stato in cui i dati sono stati ottenuti con successo.
class DataSuccess<T> extends DataState<T> {
  /// Costruttore per uno stato di successo.
  ///
  /// [data]: I dati associati a questo stato di successo.
  const DataSuccess(T data) : super(data: data);
}

/// Rappresenta uno stato di fallimento dei dati.
///
/// Questa classe rappresenta uno stato in cui si è verificato un errore durante
/// il recupero dei dati, e contiene l'eccezione corrispondente.
class DataFailed<T> extends DataState<T> {
  /// Costruttore per uno stato di fallimento.
  ///
  /// [error]: L'eccezione associata a questo stato di fallimento.
  const DataFailed(DioException error) : super(error: error);
}

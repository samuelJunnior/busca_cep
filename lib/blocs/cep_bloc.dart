import 'package:busca_cep/models/cep_model.dart';
import 'package:busca_cep/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class CepBloc {
  final _repository = Repository();

  final _cepFetcher = PublishSubject<CepModel>();
  final _loading = PublishSubject<bool>();

  Stream<CepModel> get lastFetchAddress => _cepFetcher.stream;
  Stream<bool> get loading => _loading.stream;

  fetchAddress ({required String byCep}) async {
    if (byCep.length == 8 ){
      _loading.sink.add(true);
      final fetchAddress = await _repository.fetchAddress(byCep);
      _cepFetcher.sink.add(fetchAddress);
      _loading.sink.add(false);
    }
  }

  disposse() {
    _cepFetcher.close();
    _loading.close();
  }
}
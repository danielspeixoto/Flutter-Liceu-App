import 'package:app/domain/boundary/LocalBoundary.dart';
import 'package:app/domain/boundary/ReportBoundary.dart';

class SubmitReportUseCase implements ISubmitReportUseCase {
  final ILocalRepository _localRepository;
  final IReportRepository _reportRepository;

  SubmitReportUseCase(this._localRepository, this._reportRepository);

  Future<void> run(String message, List<String> tags) async {
    final accessToken = await this._localRepository.getCredentials();
    await this._reportRepository.submit(accessToken, message, tags);
  }
}

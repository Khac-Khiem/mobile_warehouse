import 'package:mobile_cha_warehouse/domain/entities/good_issue.dart';
import 'package:mobile_cha_warehouse/domain/repositories/issue_repository.dart';

class IssueUseCase {
  final IssuesRepo _issuesRepo;
  IssueUseCase(this._issuesRepo);
  Future<List<GoodsIssue>> getAllIssues(String startDate) async {
    final goodsissues = await _issuesRepo.getGoodsIssues(startDate);
    return goodsissues;
  }

  Future<GoodsIssue> getIssueById(String id) async {
    final goodsIssue = await _issuesRepo.getGoodsIssueById(id);
    return goodsIssue;
  }

  Future<int> confirmContainer(String containerId, int quantity) async {
   final container = await _issuesRepo.confirmContainer(containerId, quantity);
    return container;
  }

  Future<void> patchConfirmIssueEntry(
      String goodIssueId, List<GoodsIssueEntry> entry) async {
    _issuesRepo.patchConfirmIssueEntry(goodIssueId, entry);
  }
}

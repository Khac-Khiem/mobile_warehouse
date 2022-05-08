import 'package:mobile_cha_warehouse/domain/entities/good_issue.dart';
import 'package:mobile_cha_warehouse/domain/repositories/issue_repository.dart';

class IssueUseCase {
  final IssuesRepo _issuesRepo;
  IssueUseCase(this._issuesRepo);
  Future<List<GoodsIssue>> getAllIssues() async {
    final goodsissues = await _issuesRepo.getGoodsIssues();
    return goodsissues;
  }

  Future<GoodsIssue> getIssueById(String id) async {
    final goodsIssue = _issuesRepo.getGoodsIssueById(id);
    return goodsIssue;
  }

  Future<void> patchConfirmIssueEntry(
      String goodIssueId, List<GoodsIssueEntry> entry) async {
     _issuesRepo.patchConfirmIssueEntry(goodIssueId, entry);
  }
}

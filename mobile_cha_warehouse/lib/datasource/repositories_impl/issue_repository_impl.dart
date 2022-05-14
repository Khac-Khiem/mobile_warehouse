import 'package:mobile_cha_warehouse/datasource/service/issue_service.dart';
import 'package:mobile_cha_warehouse/domain/entities/good_issue.dart';
import 'package:mobile_cha_warehouse/domain/repositories/issue_repository.dart';

class IssueRepoImpl implements IssuesRepo {
  IssueService issueService;
  IssueRepoImpl(this.issueService);
  @override
  Future<List<GoodsIssue>> getGoodsIssues(String startDate) {
    // TODO: implement getIssues
    final issues = issueService.getGoodsIssue(startDate);
    return issues;
  }

  @override
  Future<GoodsIssue> getGoodsIssueById(String goodsIssueId) {
    // TODO: implement getGoodsIssueById
    final issue = issueService.getGoodsIssueById(goodsIssueId);
    return issue;
  }

  @override
  Future patchConfirmIssueEntry(
      String goodsIssueId, List<GoodsIssueEntry> listIssueEntry) {
    // TODO: implement patchConfirmBasket
    throw UnimplementedError();
  }

  @override
  Future<int> confirmContainer(String containerId, int quantity) {
    // TODO: implement confirmContainer
    final container = issueService.confirmContainer(containerId, quantity);
    return container;
  }
}

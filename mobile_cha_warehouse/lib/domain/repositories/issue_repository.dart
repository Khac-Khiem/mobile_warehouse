import 'package:mobile_cha_warehouse/domain/entities/good_issue.dart';

abstract class IssuesRepo {
  Future<List<GoodsIssue>> getGoodsIssues(String startDate);
  Future<GoodsIssue> getGoodsIssueById(String goodsIssueId);
  Future<int> confirmContainer(String containerId, int quantity);
  Future<void> patchConfirmIssueEntry(
      String goodsIssueId, List<GoodsIssueEntry> listIssueEntry);
}

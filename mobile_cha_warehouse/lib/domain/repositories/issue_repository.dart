import 'package:mobile_cha_warehouse/domain/entities/good_issue.dart';

abstract class IssuesRepo {
  Future<List<GoodsIssue>> getGoodsIssues();
  Future<GoodsIssue> getGoodsIssueById(String goodsIssueId);
  Future patchConfirmIssueEntry(String goodsIssueId, List<GoodsIssueEntry> listIssueEntry);

}

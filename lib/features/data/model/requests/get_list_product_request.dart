class GetListProductRequest {
  final int limit;
  final int skip;

  GetListProductRequest({required this.limit, required this.skip});

  Map<String, dynamic> toJson() => {'limit': limit, 'skip': skip};
}

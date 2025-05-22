class GetListProductSearchRequest {
  final String q;

  GetListProductSearchRequest({
    required this.q,
  });

  Map<String, dynamic> toJson() => {
        'q': q,
      };
}

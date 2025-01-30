class PaginateModel<T> {
  T? paginatedData;
  int? totalCount;

  PaginateModel({
    required this.paginatedData,
    required this.totalCount,
  });

  factory PaginateModel.fromJson(
    String key,
    Map<String, dynamic> object,
    T? Function(dynamic)? fromJsonT,
  ) {
    return PaginateModel(
      paginatedData: object[key] != null && fromJsonT != null
          ? fromJsonT(object[key])
          : null,
      totalCount: object['totalCount'],
    );
  }
}

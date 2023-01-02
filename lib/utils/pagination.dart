class Pagination {
  static const limit = 20;

  static int totalPages(int total) {
    int result = (total / limit).ceil();
    return result;
  }
}

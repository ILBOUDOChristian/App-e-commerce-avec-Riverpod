enum ProductSortOption {
  featured,
  priceAscending,
  priceDescending,
  highestRated,
  nameAlphabetical,
}

class ProductFilter {
  final String searchQuery;
  final String selectedCategory;
  final ProductSortOption sortOption;

  const ProductFilter({
    this.searchQuery = '',
    this.selectedCategory = 'Tous',
    this.sortOption = ProductSortOption.featured,
  });

  ProductFilter copyWith({
    String? searchQuery,
    String? selectedCategory,
    ProductSortOption? sortOption,
  }) {
    return ProductFilter(
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      sortOption: sortOption ?? this.sortOption,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductFilter &&
          runtimeType == other.runtimeType &&
          searchQuery == other.searchQuery &&
          selectedCategory == other.selectedCategory &&
          sortOption == other.sortOption;

  @override
  int get hashCode => Object.hash(searchQuery, selectedCategory, sortOption);
}

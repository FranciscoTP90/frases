import '../../models/category_model.dart';
import '../../providers/providers.dart';
import '../../theme/colors.dart';
import '../../utils/assets_location.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: AppBarWidget(title: "Categorias"), body: _CategoryList());
  }
}

class _CategoryList extends StatefulWidget {
  const _CategoryList();

  @override
  State<_CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<_CategoryList> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => _loadCategories());

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        _loadCategories();
      }
    });
  }

  _loadCategories() async {
    await context.read<CategoriesProvider>().loadCategories();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categories = context.watch<CategoriesProvider>().getCategories;
    final hasMore = context.watch<CategoriesProvider>().getHasMore;

    return ListView.builder(
      itemCount: categories.length + (hasMore ? 1 : 0),
      controller: scrollController,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        if (index == categories.length) {
          return const CircularProgressWidget();
        }
        return _CategoryItem(category: categories[index]);
      },
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final Category category;
  const _CategoryItem({required this.category});

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.shortestSide > 600;
    return GestureDetector(
      onTap: () {
        Navigator.push(context, PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return PhrasesByCategoryScreen(category: category);
          },
        ));
      },
      child: Container(
        height: 100,
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.only(left: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: ColorsApp.greyLight),
        child: Row(
          children: [
            Expanded(
              child: CachedNetworkImage(
                imageUrl: category.icon,
                fit: isTablet ? BoxFit.contain : BoxFit.cover,
                placeholder: (context, url) => ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    AssetsLocation.placeholder,
                    fit: isTablet ? BoxFit.contain : BoxFit.cover,
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            const SizedBox(width: 15.0),
            Text(category.name),
            const Spacer(),
            const Expanded(child: Icon(Icons.chevron_right))
          ],
        ),
      ),
    );
  }
}

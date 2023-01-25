import '../../providers/providers.dart';
import '../../routes/routes.dart';
import '../../theme/colors.dart';
import '../../widgets/widgets.dart';
import 'components/app_bar_home.dart';
import 'components/categories_home.dart';
import 'components/landscape_view.dart';
import 'components/phrases_home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RefreshController _refreshController = RefreshController();
  bool _connection = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    checkInternet();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarHome(),
        body: SmartRefresher(
          physics: const BouncingScrollPhysics(),
          controller: _refreshController,
          header: WaterDropHeader(
            waterDropColor: ColorsApp.blue,
            failed: TextButton.icon(
                onPressed: null,
                icon: const Icon(Icons.error, color: ColorsApp.red),
                label: const Text("Error")),
            complete: TextButton.icon(
                onPressed: null,
                icon: const Icon(
                  Icons.check_circle,
                  color: ColorsApp.green,
                ),
                label: const Text("Éxito")),
          ),
          onRefresh: _onRefresh,
          child: Builder(builder: (context) {
            if (_isLoading) {
              return const CircularProgressWidget();
            }
            if (!_connection) {
              return const _NoConnection();
            }
            return LayoutBuilder(
              builder: (context, boxConstraints) {
                final isPortrait =
                    MediaQuery.of(context).orientation == Orientation.portrait;
                final double widthSize = MediaQuery.of(context).size.width;

                if (isPortrait) {
                  return Column(
                    children: [
                      _TitleAndMore(
                          title: "Categorias",
                          onPressed: () {
                            Navigator.pushNamed(context, RoutesApp.categories);
                          }),
                      const CategoriesHome(),
                      const SizedBox(height: 10.0),
                      _TitleAndMore(
                          title: "Frases Recientes",
                          onPressed: () {
                            Navigator.pushNamed(context, RoutesApp.phrases);
                          }),
                      const PhrasesHome(),
                      const SizedBox(height: 10.0),
                    ],
                  );
                } else {
                  return LandscapeView(widthSize: widthSize);
                }
              },
            );
          }),
        ));
  }

  Future<bool> checkInternet() async {
    try {
      await http.get(Uri.parse("https://www.google.com/"));
      setState(() {
        _connection = true;
        _isLoading = false;
      });
      return true;
    } catch (e) {
      setState(() {
        _connection = false;
        _isLoading = false;
        print("CONNECTION $_connection");
      });
      return false;
    }
  }

  Future<void> _onRefresh() async {
    final catProv = Provider.of<CategoriesProvider>(context, listen: false);
    final frasesProv = Provider.of<PhrasesProvider>(context, listen: false);

    catProv.reset();
    frasesProv.reset();

    await Future.wait([catProv.loadCategories(), frasesProv.loadPhrases()]);

    final isOk = await checkInternet();
    if (isOk) {
      _refreshController.refreshCompleted();
    } else {
      _refreshController.refreshFailed();
    }
  }
}

class _TitleAndMore extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  const _TitleAndMore({Key? key, required this.title, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18.0),
          ),
          TextButton(
              onPressed: onPressed,
              child: const Text("Ver más",
                  style: TextStyle(color: ColorsApp.blue)))
        ]));
  }
}

class _NoConnection extends StatelessWidget {
  const _NoConnection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(height: size.height * 0.1),
        const Text(
          "Deslice hacia abajo para recargar",
          style: TextStyle(fontSize: 16.0),
        ),
        const Icon(Icons.arrow_downward),
        SizedBox(height: size.height * 0.2),
        const FloatingActionButton.large(
          heroTag: "wifi",
          elevation: 0.0,
          onPressed: null,
          backgroundColor: ColorsApp.blue,
          child: Icon(Icons.wifi_off, size: 60),
        ),
        const SizedBox(height: 10.0),
        const Text(
          "Conéctate a Internet",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10.0),
        const Text(
          "No estás conectado. Comprueba \nla conexión.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18.0),
        )
      ],
    );
  }
}

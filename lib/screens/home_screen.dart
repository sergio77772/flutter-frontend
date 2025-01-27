import 'package:app_distribuidora/screens/categorias_screen.dart';
import 'package:app_distribuidora/services/categorias_service.dart';
import 'package:app_distribuidora/widgets/widget_search_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CategoriasService _categoriasService = CategoriasService();
  List<dynamic> _categories = [];
  int _page = 1;
  final int _limit = 10;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _fetchCategorias();
  }

  Future<void> _fetchCategorias() async {
    if (!_hasMore) return;

    try {
      final newCategories =
          await _categoriasService.fetchCategorias(_page, _limit);
      setState(() {
        _categories.addAll(newCategories);
        _page++;
        if (newCategories.length < _limit) _hasMore = false;
      });
    } catch (error) {
      print('Error al cargar categorías: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
  color: const Color(0xFFF5F5F5),
  height: height,
  width: width,
  child: Column(
    children: [
      widget_search_home(), // Widget de búsqueda.
      const SizedBox(height: 10),
      Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 130,
                width: 330,
                color: Colors.white, // Placeholder para otro contenido.
              ),
              const SizedBox(height: 10),
              Categorias(
                categories: _categories,
              ),
              SizedBox(height: 10,),
              Productos(
                categories: _categories,
              ),
               SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    ],
  ),
)
    );
  }
}



class Categorias extends StatelessWidget {
  final List categories; // Lista de categorías.

  const Categorias({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    // Limita las categorías a un máximo de 10.
    final displayedCategories = categories.take(8).toList();

    return Container(
      height: 118,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              height: 23,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      'Categorias',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => CategoriasScreen(),
                          ));
                    },
                    child: Container(
                      child: Text(
                        'Ver más',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[400]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 92, // Altura total del contenedor.
            child: ListView.builder(
              scrollDirection: Axis.horizontal, // Scroll horizontal.
              itemCount: displayedCategories
                  .length, // Solo las primeras 10 categorías.
              itemBuilder: (context, index) {
                var categoria = displayedCategories[index]; // Categoría actual.
                return Padding(
                  padding: const EdgeInsets.only(right: 5,left: 5),
                  child: Container(
                    padding: EdgeInsets.only(top: 5),
                    width: 70,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          
                          clipBehavior: Clip.antiAlias,
                          
                           padding: EdgeInsets.all(5),
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 2,
                                spreadRadius: 1,
                                color: Colors.black.withOpacity(0.05),
                              )
                            ],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.network(
                            'https://distribuidoraassefperico.com.ar${categoria['imagen']}', // Concatenar correctamente la URL base con la ruta de la imagen
                            fit: BoxFit.cover,
                            
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                         
                          child: Text(
                            categoria['nombre'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[500]),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Productos extends StatelessWidget {
  final List categories; // Lista de categorías.

  const Productos({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    // Limita las categorías a un máximo de 10.
    final displayedCategories = categories.take(8).toList();

    return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: Container(
      
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(
              color: const Color.fromARGB(255, 202, 202, 202), width: 0.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.09),
              blurRadius: 6,
              spreadRadius: 1,
            )
          ]),
      child: Column(
        children: [
          
          Wrap(
            children: List.generate(
              categories.take(16).length, // Toma 4 productos aleatorios
              (index) {
                final categoria = categories[index];

                return GestureDetector(
                  onTap: () {
                  },
                  child: Container(
                    width: 170,
                    height: 240, // 2 elementos por fila
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                      border: Border.all(
                          color: const Color.fromARGB(255, 202, 202, 202),
                          width: 0.2),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 8,right: 8),
                          child: Container(
                            child: Image.network(
                            'https://distribuidoraassefperico.com.ar${categoria['imagen']}', // Concatenar correctamente la URL base con la ruta de la imagen
                            fit: BoxFit.cover,
                            
                          ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 5, top: 5, right: 5),
                          child: Container(
                            width: double.infinity,
                            child: Text(
                              categoria['nombre'] ?? 'Sin nombre',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  '\$${categoria['price'].toString()}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
  }
}

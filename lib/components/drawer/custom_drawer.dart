import 'package:flutter/material.dart';
import 'package:teste_tecnico/components/drawer/checkbox_item.dart';
import 'package:teste_tecnico/components/drawer/filtro_item.dart';

class CustomDrawer extends StatefulWidget {
  final void Function(
    Map<String, bool> departamentosChecked,
    Map<String, bool> materialChecked,
    Map<String, bool> categoriaChecked,
    String precoMax,
    String precoMin,
  ) onApplyFilters;

  const CustomDrawer({super.key, required this.onApplyFilters});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final TextEditingController precoMinController = TextEditingController();
  final TextEditingController precoMaxController = TextEditingController();
  final List<String> departamentos = [
    'Baby',
    'Beauty',
    'Books',
    'Clothing',
    'Computers',
    'Electronics',
    'Games',
    'Garden',
    'Grocery',
    'Health',
    'Home',
    'Industrial',
    'Jewelery',
    'Kids',
    'Movies',
    'Music',
    'Outdoors',
    'Shoes',
    'Sports',
    'Tools',
    'Toys',
    'teste'
  ];

  final List<String> material = [
    'Metal',
    'Granite',
    'Frozen',
    'Rubber',
    'Cotton',
    'Steel',
    'Soft',
    'Plastic',
    'Wooden',
    'Concrete',
    'Fresh',
    'Malha',
    'Bronze',
  ];

  final List<String> categoria = [
    'Fantastic',
    'Refined',
    'Practical',
    'Small',
    'Sleek',
    'Generic',
    'Handmade',
    'Gorgeous',
    'Licensed',
    'Unbranded',
    'Rustic',
    'Intelligent',
    'Incredible',
    'Awesome',
    'Tasty',
    'Handcrafted',
    'Roupas',
    'Bespoke',
    'Recycled',
    'Electronic',
    'Oriental',
    'Luxurious',
    'Modern',
    'Elegant',
  ];

  final Map<String, bool> departamentosChecked = {};

  final Map<String, bool> materialChecked = {};

  final Map<String, bool> categoriaChecked = {};

  String precoMax = '';
  String precoMin = '';

  @override
  void initState() {
    super.initState();
    for (var departamento in departamentos) {
      departamentosChecked[departamento] = false;
    }
    for (var material in material) {
      materialChecked[material] = false;
    }
    for (var categoria in categoria) {
      categoriaChecked[categoria] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[800],
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: 130,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.grey[900],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: FiltroItem(
                      text: ' Filtros',
                    ),
                  ),
                ],
              ),
            ),
          ),
          const FiltroItem(
            text: ' Preço',
          ),
          const Padding(
            padding: EdgeInsets.only(left: 9.5),
            child: Divider(
              thickness: 0.5,
              height: 0.5,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 80,
                width: 120,
                child: TextField(
                  controller: precoMinController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'R\$ Mínimo',
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    prefixText: 'Ex : ',
                    hintText: '100',
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300
                    ),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  onChanged: (value) {
                    precoMin = precoMinController.text;
                  },
                  onTapOutside: (event) {
                     FocusScope.of(context).unfocus();
                  },
                  onSubmitted: (value) {
                     FocusScope.of(context).unfocus();
                  },
                ),
              ),
              SizedBox(
                height: 80,
                width: 120,
                child: TextField(
                  controller: precoMaxController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'R\$ Máximo',
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    prefixText: 'Ex: ',
                    hintText: '1000',
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    ),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  onChanged: (value) {
                    precoMax = precoMaxController.text;
                  },
                  onTapOutside: (event) {
                     FocusScope.of(context).unfocus();
                  },
                  onSubmitted: (value) {
                     FocusScope.of(context).unfocus();
                  },
                ),
              ),
            ],
          ),
          const FiltroItem(
            text: ' Departamento',
          ),
          const Padding(
            padding: EdgeInsets.only(left: 9.5),
            child: Divider(
              thickness: 0.5,
              height: 0.5,
              color: Colors.white,
            ),
          ),
          for (int i = 0; i < departamentos.length; i += 2)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CheckboxItem(
                    text: departamentos[i],
                    value: departamentosChecked[departamentos[i]]!,
                    onChanged: (bool? value) {
                      setState(() {
                        departamentosChecked[departamentos[i]] = value!;
                      });
                    },
                  ),
                  if (i + 1 < departamentos.length)
                    CheckboxItem(
                      text: departamentos[i + 1],
                      value: departamentosChecked[departamentos[i + 1]]!,
                      onChanged: (bool? value) {
                        setState(() {
                          departamentosChecked[departamentos[i + 1]] = value!;
                        });
                      },
                    ),
                ],
              ),
            ),
          const FiltroItem(
            text: ' Material',
          ),
          const Padding(
            padding: EdgeInsets.only(left: 9.5),
            child: Divider(
              thickness: 0.5,
              height: 0.5,
              color: Colors.white,
            ),
          ),
          for (int i = 0; i < material.length; i += 2)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CheckboxItem(
                    text: material[i],
                    value: materialChecked[material[i]]!,
                    onChanged: (bool? value) {
                      setState(() {
                        materialChecked[material[i]] = value!;
                      });
                    },
                  ),
                  if (i + 1 < material.length)
                    CheckboxItem(
                      text: material[i + 1],
                      value: materialChecked[material[i + 1]]!,
                      onChanged: (bool? value) {
                        setState(() {
                          materialChecked[material[i + 1]] = value!;
                        });
                      },
                    ),
                ],
              ),
            ),
          const FiltroItem(
            text: ' Categoria',
          ),
          const Padding(
            padding: EdgeInsets.only(left: 9.5),
            child: Divider(
              thickness: 0.5,
              height: 0.5,
              color: Colors.white,
            ),
          ),
          for (int i = 0; i < categoria.length; i += 2)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CheckboxItem(
                    text: categoria[i],
                    value: categoriaChecked[categoria[i]]!,
                    onChanged: (bool? value) {
                      setState(() {
                        categoriaChecked[categoria[i]] = value!;
                      });
                    },
                  ),
                  if (i + 1 < categoria.length)
                    CheckboxItem(
                      text: categoria[i + 1],
                      value: categoriaChecked[categoria[i + 1]]!,
                      onChanged: (bool? value) {
                        setState(() {
                          categoriaChecked[categoria[i + 1]] = value!;
                        });
                      },
                    ),
                ],
              ),
            ),
          const Divider(
            thickness: 0.5,
            height: 0.5,
            color: Colors.white,
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: TextButton(
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.blue),
              ),
              onPressed: () {
                widget.onApplyFilters(departamentosChecked, materialChecked,
                    categoriaChecked, precoMin, precoMax);
                Navigator.pop(context);
              },
              child: const Text(
                'Aplicar Filtros',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 90),
        ],
      ),
    );
  }
}

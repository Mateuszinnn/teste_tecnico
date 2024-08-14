import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  final bool isExpanded;
  final VoidCallback onExpand;
  final VoidCallback onCollapse;
  final void Function(
    String nomeProduto,
  ) searchFilters;
  final void Function() cancelSearch;

  const CustomSearchBar({
    super.key,
    required this.isExpanded,
    required this.onExpand,
    required this.onCollapse,
    required this.searchFilters,
    required this.cancelSearch,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController searchController = TextEditingController();
  bool isSearchBarExpanded = false;
  String nomeProduto = '';

  @override
  void initState() {
    super.initState();
    isSearchBarExpanded = widget.isExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: searchController,
            onChanged: (value) {
              nomeProduto = searchController.text;
            },
            onTapOutside: (event) {
              setState(() {
                isSearchBarExpanded = false;
              });
              FocusScope.of(context).unfocus();
            },
            onTap: () {
              widget.onExpand();
              setState(() {
                isSearchBarExpanded = true;
              });
            },
            onSubmitted: (value) {
              widget.searchFilters(value);

              FocusScope.of(context).unfocus();
            },
            style: const TextStyle(
              color: Colors.black,
            ),
            decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              hintText: 'Pesquisar',
              hintStyle: TextStyle(
                color: Colors.black,
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        if (isSearchBarExpanded)
          TextButton(
            onPressed: () {
              setState(() {
                isSearchBarExpanded = false;
                searchController.clear();
              });
              widget.onCollapse();
              widget.cancelSearch();
            },
            child: const Text(
              'Cancelar',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
      ],
    );
  }
}

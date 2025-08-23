class Menu {
  final int id;
  final String title;
  final String? description;

  Menu({required this.id, required this.title, this.description});
}

extension RadioMenu on Menu {

  static List<Menu> getRadioBuilderMenu() {
    return [
      Menu(id: 0, title: "Simple Text Radio Buttons", description: "Built-in default widget option with label text & text style."),
      Menu(id: 1, title: "Custom Radio Builder", description: "Custom radio item builder to design your own widget."),
      Menu(id: 2, title: "Custom Multi Checkbox Builder", description: "Custom Checkbox Builder with Multi Selection."),
      Menu(id: 3, title: "Radio Bottom Sheet Example", description: "Builder Example with Bottom Sheet with Scroll Example."),
      Menu(id: 3, title: "CheckBox Bottom Sheet Example", description: "Builder Example with Bottom Sheet with Scroll Example.")
    ];
  }
}
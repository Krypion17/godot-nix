{
  description = "Empty godot project with flake";

  outputs = { ... }: {
    defaultTemplate = {
      path = ./godot;
      description = "Empty godot project";
    };
  };
}

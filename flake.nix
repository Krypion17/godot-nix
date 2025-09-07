{
  description = "Game in godot";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    godot-git-plugin.url = "https://github.com/godotengine/godot-git-plugin/releases/latest/download/godot-git-plugin-v3.2.0.zip";
    godot-git-plugin.flake = false;
  };

  outputs = { self, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = inputs.nixpkgs.legacyPackages.${system};
  in
  {

    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [
        godot-mono
        omnisharp-roslyn
        dotnet-sdk_9
        gh
      ];

      godotgitplugin = inputs.godot-git-plugin;

      shellHook = ''
        SHELL=zsh
        ls addons && echo "" || ln -s $godotgitplugin/addons addons
        godot-mono project.godot &> /dev/null &
        nvim
      '';
    };
  };
}

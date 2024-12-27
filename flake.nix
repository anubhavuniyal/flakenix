{
  description = "Nixos config flake";

  inputs = {
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    catppuccin.url = "github:catppuccin/nix";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
         url = "github:hyprwm/hyprland-plugins";
         inputs.hyprland.follows = "hyprland";
    };
    hyprpanel = {
         url = "github:Jas-SinghFSU/HyprPanel";
         inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, catppuccin, stylix, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {

      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          catppuccin.nixosModules.catppuccin
          stylix.nixosModules.stylix
          ./hosts/default/configuration.nix
          inputs.home-manager.nixosModules.default
          { nixpkgs.overlays = [
            inputs.hyprpanel.overlay
                ];
            }
        ];
      };

    };
}

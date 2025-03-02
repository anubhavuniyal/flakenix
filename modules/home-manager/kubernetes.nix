{ inputs, pkgs,	...}:
{
  home = {
    	packages = with pkgs; [
    		minikube
        kubectl
        kubernetes-helm
    ];
	};
	programs = {
      k9s = {
        enable = true;
      };
    };
}

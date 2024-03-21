{ inputs, pkgs,	...}: 
{
  home = {
	packages = with pkgs; [
		nmap
		dnsx
		subfinder
		masscan
		rustscan
		openvpn
		ghidra-bin
		metasploit
		feroxbuster
		wfuzz
		curl
		wget
		hashcat
		hashcat-utils
		netcat-gnu
		crunch
		john
		seclists
		sqlmap
		gobuster
		ffuf
    python3
    python311Packages.pip
    rockyou
    burpsuite
  ];
	file = {
		"wordlists".source = pkgs.seclists;
    "rockyou".source = pkgs.rockyou;
		};
	};
	}

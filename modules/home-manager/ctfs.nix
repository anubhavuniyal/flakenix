{ inputs, pkgs,	...}: 
{
  home.packages = with pkgs; [
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
  ];
	}

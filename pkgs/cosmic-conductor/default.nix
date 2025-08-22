{lib, pkgs, pkg-config, stdenv, fetchFromGitHub, rustPlatform}:
let 
    version = "v0.2.1";
    proc-bin = member: rustPlatform.buildRustPackage rec {
       pname = "cosmic-conductor";
       inherit version;
   
       src = fetchFromGitHub {
           owner = "Wasabi375";
           repo = pname;
           rev = version;
           hash = "sha256-JsyyqDWHWhS8kV4wcvHCDkb3wz341myaI5FeER5JiDg=";
       };
       
       cargoHash = "sha256-NHdHU1VivCyN61MRyMd9kLauKwmESke4h0ubUPGI0FA=";

       nativeBuildInputs = [
           pkg-config
       ];
   
       buildInputs = with pkgs; [
           libxkbcommon
           wayland
       ];

       buildAndTestSubdir = "${member}";
    };
    conductor = proc-bin "";
    xtask = proc-bin "xtask";
in stdenv.mkDerivation {
    pname = "cosmic-conductor";
    inherit version;

    unpackPhase = ''
        runHook preUnpack
        runHook postUnpack
    '';

    installPhase = ''
        runHook preInstall
        
        mkdir -p $out/bin
        ln -s ${conductor}/bin/cosmic-conductor $out/bin/cosmic-conductor
      
        mkdir -p $out/share/man/man1
        ${xtask}/bin/xtask --out-dir $out man
        mv $out/man/* $out/share/man/man1
        
        mkdir -p $out/share/bash-completion/completions
        ${xtask}/bin/xtask --out-dir $out completion bash
        mv $out/completions/* $out/share/bash-completion/completions
       
        runHook postInstall
    '';

    meta = with lib; {
        description = "A command line utility to control windows and working groups on the COSMIC desktop";
        homepage = "https://www.github.com/Wasabi375/cosmci-conductor";
        license = licenses.gpl3;
        platforms = platforms.linux;
        mainProgram = "cosmic-conductor";
    };
}

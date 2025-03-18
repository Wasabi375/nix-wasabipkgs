{lib, stdenv, fetchFromGitHub, rustPlatform}:
let 
    version = "v0.6.1";
    proc-bin = member: rustPlatform.buildRustPackage rec {
       pname = "procrastinate";
       inherit version;
   
       src = fetchFromGitHub {
           owner = "Wasabi375";
           repo = pname;
           rev = version;
           hash = "sha256-5VR/k9vSrOnAyszOvXNmaneER9dkOhsevhNQTFNBrDU=";
       };
       
       cargoHash = "sha256-/OzgMkK3Em9SJD7NYUgmOu89E4j/FSAGfHa6Mj1AYnQ=";
   
       buildAndTestSubdir = "${member}";
    };
    cli = proc-bin "procrastinate";
    xtask = proc-bin "xtask";
    daemon = proc-bin "daemon";
    work = proc-bin "work";
in stdenv.mkDerivation {
    pname = "procrastinate";
    inherit version;

    unpackPhase = ''
        runHook preUnpack
        runHook postUnpack
    '';

    installPhase = ''
        runHook preInstall
        
        mkdir -p $out/bin
        ln -s ${cli}/bin/procrastinate $out/bin/procrastinate
        ln -s ${daemon}/bin/procrastinate-daemon $out/bin/procrastinate-daemon
        ln -s ${work}/bin/procrastinate-work $out/bin/procrastinate-work
      
        mkdir -p $out/share/man/man1
        ${xtask}/bin/xtask --out-dir $out man
        mv $out/man/* $out/share/man/man1
        
        mkdir -p $out/share/bash-completion/completions
        ${xtask}/bin/xtask --out-dir $out completion bash
        mv $out/completions/* $out/share/bash-completion/completions
       
        runHook postInstall
    '';

    meta = with lib; {
        description = "A suite of programs to send time delayed notifications";
        homepage = "https://www.github.com/Wasabi375/procrastinate";
        license = licenses.mit;
        platforms = platforms.linux;
        mainProgram = "procrastinate";
    };
}

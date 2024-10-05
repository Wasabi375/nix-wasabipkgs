{lib, fetchFromGitHub, rustPlatform}:

rustPlatform.buildRustPackage rec {
    pname = "procrastinate";
    version = "v0.5.0";

    src = fetchFromGitHub {
        owner = "Wasabi375";
        repo = pname;
        rev = version;
        hash = "sha256-PEyvG/E0CiJqJIHMPMFFJhCADrbEfn84g3y8VoSKoKQ=";
    };
    
    cargoHash = "sha256-vc8THTNTpYXWy2THlYkTOFdvLjy92LYY8omm1IfN7sc=";

    meta = with lib; {
        description = "A suite of programs to send time delayed notifications";
        homepage = "https://www.github.com/Wasabi375/procrastinate";
        license = licenses.mit;
        platforms = platforms.linux;
        mainProgram = "procrastinate";
    };
}

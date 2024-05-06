{lib, fetchFromGitHub, rustPlatform}:

rustPlatform.buildRustPackage rec {
    pname = "procrastinate";
    version = "0.2.0";

    src = fetchFromGitHub {
        owner = "Wasabi375";
        repo = pname;
        rev = version;
        hash = "sha256-XQmKVY+XuhUY+hMm1+S/O8jC1uJmqSfsnSt52TqfT6A=";
    };
    
    cargoHash = "sha256-nKbszDnlQknGY5aqLehIHbB73hmzxwRHdKTFVpMleKk=";

    meta = with lib; {
        description = "A suite of programs to send time delayed notifications";
        homepage = "https://www.github.com/Wasabi375/procrastinate";
        license = licenses.mit;
        platforms = platforms.linux;
        mainProgram = "procrastinate";
    };
}

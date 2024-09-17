{lib, fetchFromGitHub, rustPlatform}:

rustPlatform.buildRustPackage rec {
    pname = "procrastinate";
    version = "v0.4.0";

    src = fetchFromGitHub {
        owner = "Wasabi375";
        repo = pname;
        rev = version;
        hash = "sha256-KvPAyFIg9PmT8MuPix3DvDUH2ebXSkW4iKlBRMlhn0M=";
    };
    
    cargoHash = "sha256-Tpev2lRjLO9rOVxkxojppmVUVRgidicW1Tck2pRBmAQ=";

    meta = with lib; {
        description = "A suite of programs to send time delayed notifications";
        homepage = "https://www.github.com/Wasabi375/procrastinate";
        license = licenses.mit;
        platforms = platforms.linux;
        mainProgram = "procrastinate";
    };
}

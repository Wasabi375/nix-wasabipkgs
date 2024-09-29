{lib, fetchFromGitHub, rustPlatform}:

rustPlatform.buildRustPackage rec {
    pname = "procrastinate";
    version = "v0.4.1";

    src = fetchFromGitHub {
        owner = "Wasabi375";
        repo = pname;
        rev = version;
        hash = "sha256-5Pd5os8p8x50UNrk4hCBjeGZtBHsDU/ct1UyqJR8glU=";
    };
    
    cargoHash = "sha256-SZyssWOHvH/qShsVUyUDRcmRjYNDUW97ubNmUzbAZws=";

    meta = with lib; {
        description = "A suite of programs to send time delayed notifications";
        homepage = "https://www.github.com/Wasabi375/procrastinate";
        license = licenses.mit;
        platforms = platforms.linux;
        mainProgram = "procrastinate";
    };
}

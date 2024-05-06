{lib, fetchFromGitHub, rustPlatform}:

rustPlatform.buildRustPackage rec {
    pname = "procrastinate";
    version = "0.1.0";

    src = fetchFromGitHub {
        owner = "Wasabi375";
        repo = pname;
        rev = version;
        hash = "sha256-s9WeWjnwY0M7a1uVIx3nSTZ+s0RUxTOTCZVP8pPl+/I=";
    };
    
    cargoHash = "sha256-eepcRVafpMLIaESqLY5GqcWuTIx/MXlOxc6YPvoS1NA=";

    meta = with lib; {
        description = "A suite of programs to send time delayed notifications";
        homepage = "https://www.github.com/Wasabi375/procrastinate";
        license = licenses.mit;
        platforms = platforms.linux;
        mainProgram = "procrastinate";
    };
}

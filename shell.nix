{ sources ? import ./nix/sources.nix, pkgs ? import <nixpkgs> { } }:

with pkgs;
let inherit (lib) optional optionals;

in mkShell {
  LOCALE_ARCHIVE_2_27 = "${glibcLocales}/lib/locale/locale-archive";
  buildInputs = [ (import ./nix/default.nix { inherit pkgs; }) niv ]
    ++ optional stdenv.isLinux inotify-tools
    ++ optional stdenv.isDarwin terminal-notifier ++ optionals stdenv.isDarwin
    (with darwin.apple_sdk.frameworks; [ CoreFoundation CoreServices ]);

  shellHook = ''
    export PGHOST=$PWD/postgres
    export PGDATA=$PWD/postgres_data
    export PGDATABASE=postgres
    export PGPORT=5433

    export DATABASE_URL="postgresql:///$PGDATABASE?host=$PGHOST&port=$PGPORT"

    export LOG_PATH=$PWD/postgres/LOG

    if [ ! -d $PGHOST ]; then
      mkdir -p $PGHOST
    fi

    if [ ! -d $PGDATA ]; then
      initdb --auth=trust --no-locale --encoding=UTF8
    fi

    postgres_start() {
      pg_ctl start -l $LOG_PATH -o "-c unix_socket_directories='$PGHOST'"
    }
  '';
}

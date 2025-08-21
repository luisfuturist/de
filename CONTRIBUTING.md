# Contributing

// TODO: add contributing guidelines

1. Clone the repository

    ```bash
    git clone https://github.com/luisfuturist/de.git
    cd de
    ```

## Installing

Before you can start the development mode, you need to prepare the configuration files.

```bash
./scripts/prepare.sh
```

This will copy the configuration files to the `~/.config/` directory.

## Development Mode

To start the development mode, run the following command:

```bash
./scripts/dev.sh
```

This will watch for changes in the `config/` directory and apply them to the system.

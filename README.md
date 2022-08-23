# dataclassconfig

[![License](https://img.shields.io/pypi/l/dataclassconfig.svg)](https://pypi.python.org/pypi/dataclassconfig/)
[![Version](https://img.shields.io/pypi/v/dataclassconfig.svg)](https://pypi.python.org/pypi/dataclassconfig/)
[![Python versions](https://img.shields.io/pypi/pyversions/dataclassconfig.svg)](https://pypi.python.org/pypi/dataclassconfig/)
[![Code style: black](https://img.shields.io/badge/code%20style-black-000000.svg)](https://github.com/ambv/black)

The simplest interface for working with configuration files. Describe the structure of your configuration file as a dataclass. Use inheritance and composition to describe the complex hierarchical structure of a configuration file.

## Installation

```bash
pip install dataclassconfig
```

## Requirements

Minimum Python version supported by `dataclassconfig` is 3.6

## Usage

Describe the structure of your config file like a `dataclass` and inherit it from `Сonfig`

```python
from dataclassconfig import Config

class Socket(Config):
    host: str
    port: int

class DatabaseConnection(Socket):
    database: str
    username: str
    password: str

class ServerConfig(Config):
    root: str
    db: DatabaseConnection
```

Create a configuration file according to the described structure in YML or JSON format

```yaml
# server-config.yml
root: ~/server
db:
  host: localhost
  port: 1234
  database: database
  username: demouser
  password: demopassword
```

```json
# server-config.json
{
    "root": "~/server",
    "db": {
        "host": "localhost",
        "port": 1234,
        "database": "database",
        "username": "demouser",
        "password": "demopassword",
    },
}
```

Load the config file using your class

```python
config = ServerConfig.load("server-config.yml")
```

or

```python
config = ServerConfig.load("server-config.json")
```

The `load` method will check the completeness of the provided data in the configuration file and strictly match the data types. The result will be the same in both cases, the config object contains fields defined in the class

```bash
config :- ServerConfig(
    root='~/server',
    db=DatabaseConnection(
        host='localhost',
        port=1234,
        database='database',
        username='demouser',
        password='demopassword'
    )
)

config.db.username :- 'demouser'
```

## Gratitude

This module works thanks to the implementation in the [dacite](https://github.com/konradhalas/dacite) project

## Authors

Created by Vladislav A. Proskurov

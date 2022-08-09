# Noso Data Tool
[![Build Status](https://github.com/Friends-Of-Noso/nosodatatool/workflows/build/badge.svg?branch=main)](https://github.com/Friends-Of-Noso/nosodatatool/actions)
[![Supports Windows](https://img.shields.io/badge/support-Windows-blue?logo=Windows)](https://github.com/Friends-Of-Noso/nosodatatool/releases/latest)
[![Supprts Linux](https://img.shields.io/badge/support-Linux-yellow?logo=Linux)](https://github.com/Friends-Of-Noso/nosodatatool/releases/latest)
[![Supports macOS](https://img.shields.io/badge/support-macOS-black?logo=macOS)](https://github.com/Friends-Of-Noso/nosodatatool/releases/latest)
[![License](https://img.shields.io/github/license/Friends-Of-Noso/nosodatatool)](https://github.com/Friends-Of-Noso/nosodatatool/blob/master/LICENSE)
[![Latest Release](https://img.shields.io/github/v/release/Friends-Of-Noso/nosodatatool?label=latest%20release)](https://github.com/Friends-Of-Noso/nosodatatool/releases/latest)
[![Downloads](https://img.shields.io/github/downloads/Friends-Of-Noso/nosodatatool/total)](https://github.com/Friends-Of-Noso/nosodatatool/releases)

A CLI application to show contents of data inside:

- The Blocks

## Usage

```
  nosodatatool block <block#>
  nosodatatool -h|--help
  nosodatatool -v|--version

Commands:
  block  displays the content of <block#>

Options:
  -h|--help  displays this message
  -v|--version  displays the version
```

## Cloning repository and compiling project

Since this project depends on another from the organization [Friend of Noso](https://github.com/Friends-Of-Noso), you need to clone the repository with `--recurse-submodules`:

```console
$ git clone --recurse-submodules git@github.com:Friends-Of-Noso/nosodatatool.git
```

**OR**

```console
$ git clone --recurse-submodules https://github.com/Friends-Of-Noso/nosodatatool.git
```

Once that is done, you can then just compile as usual under Lazarus, or use `lazbuild`:

```console
$ lazbuild -B --bm=Release src/nosodatatool.lpi
```

## To do

1. Complete `JSON` output of the `TBlock` from [NosoData](https://github.com/Friends-Of-Noso/NosoData) to enable `JSON` output

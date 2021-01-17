# GitHub Action LaTeX | LaTeX document compiler

![Test GitHub Action](https://github.com/Sakul6499/GitHub-Action-LaTeX/workflows/Test%20GitHub%20Action/badge.svg?branch=main)

View on [Marketplace](https://github.com/marketplace/actions/latex-document-compiler).  

## Versions

| Branch/Tag | Preview | Release | Description                                                    |
| ---------- | ------- | ------- | -------------------------------------------------------------- |
| `main` (branch)     | yes     | no      | The main branch. All release changes will be merged into here. |
| `v1.0.0` (tag)   | **no**  | yes     | The first release version. Does include everything needed.     |
| `v0.0.3` (tag)   | yes     | yes     | Added better script output                                     |
| `v0.0.2` (tag)   | yes     | yes     | README updates / Clearer usage                                 |
| `v0.0.1` (tag)   | yes     | yes     | First preview version. Does include everything needed.         |


## Basic usage

To use this GitHub Action, simply create a `.yml` file under `.github/workflows` (`.github/workflows/latex.yml`) and insert the following:

```yaml
name: Test GitHub Action
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - name: Set up Git repository
        uses: actions/checkout@v2

      - name: Compile LaTeX document
        uses: Sakul6499/GitHub-Action-LaTeX@v0.0.1
        with:
          latex_main_file: my_latex_file.tex
```

You can also upload the PDF as an artifact afterwards using [actions/upload-artifact@master](https://github.com/marketplace/actions/upload-a-build-artifact):  

```yaml
name: Build LaTeX Document
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - name: Set up Git repository
        uses: actions/checkout@v2

      - name: Compile LaTeX document
        uses: Sakul6499/GitHub-Action-LaTeX@v0.0.1
        with:
          latex_main_file: my_latex_file.tex

      - name: Upload
        uses: actions/upload-artifact@master
        with:
          name: my_latex_file.pdf
          path: my_latex_project_path/ # Optional
        if: always()
```

## Advanced usage

There are more options available if needed:

```yaml
name: Build LaTeX Document
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - name: Set up Git repository
        uses: actions/checkout@v2

      - name: Compile LaTeX document
        uses: Sakul6499/GitHub-Action-LaTeX@v0.0.1
        with:
          latex_main_file: my_latex_file.tex
          working_directory: my_latex_project/
          latex_compiler: latexmk
          latex_compiler_arguments: "-pdf -file-line-error -halt-on-error -interaction=nonstopmode"
          system_packages: "gcc"
          pre_task: 'echo "''Hello, World!'' from BEFORE compilation."'
          post_task: 'echo "''Hello, World!'' from AFTER compilation."'
```

| Name                     | Required | Description                                                                                                                                                                                                                                                                                                                                                                                                 | Default                                                         |
| ------------------------ | -------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------- |
| latex_main_file          | **yes**  | The filename of your main/root LaTeX document. (Usually where your `\documentclass[...]{...}` is)                                                                                                                                                                                                                                                                                                           |                                                                 |
| working_directory        | no       | Set if your LaTeX files are within a subdirectory (i.e. not the repository root)                                                                                                                                                                                                                                                                                                                            |                                                                 |
| latex_compiler           | no       | If you want or require to use a different compiler                                                                                                                                                                                                                                                                                                                                                          | `latexmk`                                                       |
| latex_compiler_arguments | no       | If you want or require to use different compiler arguments                                                                                                                                                                                                                                                                                                                                                  | `-pdf -file-line-error -halt-on-error -interaction=nonstopmode` |
| system_packages          | no       | In case your LaTeX document requires additional LaTeX or system packages. The Action is build inside ArchLinux, thus always up-to-date, and feature rich. List any package you need and it will be installed. Check the [Arch package list](https://archlinux.org/packages/) for an overview over packages. `texlive-most` is already installed and should cover most of your needs. (This is **not** AUR!) |                                                                 |
| pre_task                 | no       | In case you want or need to run some commands _before_ compiling                                                                                                                                                                                                                                                                                                                                            |                                                                 |
| post_task                | no       | In case you want or need to run some commands _after_ compiling                                                                                                                                                                                                                                                                                                                                             |                                                                 |

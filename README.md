# MPLABX XC8 BUILD ACTION

This project is clone of <a href="https://github.com/nahueespinosa/mplabx-xc8" target="_blank">nahueespinosa/mplabx-xc8</a>

This action builds a MPLAB X IDE v5.30 project with XC8 compiler v2.10.  

# Usage

<!-- start usage -->
```yaml
- uses: dsatsangi/mplab-xc8-build-action@main
  with:
    # Project path relative to repository
    project: path/to/project

    # Configuration of the project.
    configuration: default
```
<!-- end usage -->

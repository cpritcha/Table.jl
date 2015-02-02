# Table

[![Build Status](https://travis-ci.org/cpritcha/Table.jl.svg?branch=master)](https://travis-ci.org/cpritcha/Table.jl)

`Table.jl` is a package for displaying tables in plain text, HTML and LaTeX.

Tables in `Table.jl` have five parts: ranges, styles, data, row heights and column widths.

## Ranges

Ranges describe areas in the table where a style should be applied. They
consist of a box and a style ID.

## Styles

A style text, cell and range level properties.

Text level properties format only the cell text content. They describe how
many digits of precision to print, alignment, whether or not to append an
asterisk to a text based on its value etcetera.

Cell level properties apply to all cells in the range. In HTML, this could be
colour or border information.

## Data

The information being displayed in the table. Tables do not have to display all
the data present in a cell.

## Row Heights / Column Widths

Row height and column width information is either fixed or fit based on the data.

## Documentation

## TODO

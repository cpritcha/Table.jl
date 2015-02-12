# Tables

[![Build Status](https://travis-ci.org/cpritcha/Table.jl.svg?branch=master)](https://travis-ci.org/cpritcha/Table.jl)

`Tables.jl` is a package for displaying tables in plain text, HTML and LaTeX.

Tables in `Tables.jl` consist of data, styles and their associated layouts 
(which are ranges).

## Layouts

Layouts describe areas in the table where a style should be applied or data 
should be located. They consist of a vector of ranges. Ranges have a box and
an ID.

## Styles

A style has text, cell and range level properties.

Text level properties format only the cell text content. They describe how
many digits of precision to print, alignment, whether or not to append an
asterisk to a text based on its value etcetera.

Cell level properties apply to all cells in the range. In HTML, this could be
colour or border information.

A style elements position in the style vector provides an index to look up its
associated range.

## Data

Data is a vector of matrices. Each matrix contains information to be displayed
in the table.

A data elements position in the data vector provides an index to look up its
associated range.

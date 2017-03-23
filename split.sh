#!/bin/bash

IN="bla@some.com/john@home.com/diocane"
arrIN=(${IN//// })

echo ${arrIN[*]}
# Kenya

[![Build Status](https://travis-ci.org/hpoit/Kenya.jl.svg?branch=master)](https://travis-ci.org/hpoit/Kenya.jl)
[![Documentation Status](https://readthedocs.org/projects/kenyajl/badge/?version=latest)](http://kenyajl.readthedocs.org/)
[![Coverage Status](https://img.shields.io/coveralls/hpoit/Kenya.jl.svg?style=flat)](https://coveralls.io/r/hpoit/Kenya.jl?branch=master)
[![License](http://img.shields.io/badge/license-MIT-brightgreen.svg?style=flat)](LICENSE.md)

[Tutorials](http://kenyajl.readthedocs.org/en/latest/#tutorials) | [Documentation](http://kenyajl.readthedocs.org/) | [Release Notes](NEWS.md) | [Roadmap](https://github.com/hpoit/Kenya.jl/issues/1)

Kenya is a distributed [Markov Logic Network](https://en.wikipedia.org/wiki/Markov_logic_network) for [Julia](http://julialang.org/), inspired by the works of Pedro Domingos, Stanford's Tuffy and Felix, Hélène Papadopoulos, and a few others.

Key points will be listed after some code is done.

## Installation

## Hello World

Input, three parts

1. MLN program

Predicate definitions
*Friends(person, person)
Smokes(person)
Cancer(person)

Rule definitions
0.5 !Smokes(a1) v Cancer(a1)
0.4 !Friends(a1,a2) v !Smokes(a1) v Smokes(a2)
0.4 !Friends(a1,a2) v !Smokes(a2) v Smokes(a1)

Evidence
Friends(Anna, Bob)
Friends(Anna, Edward)
Friends(Anna, Frank)
Friends(Edward, Frank)
Friends(Gary, Helen)
!Friends(Gary, Frank)
Smokes(Anna)
Smokes(Edward)

Query
Cancer(x)

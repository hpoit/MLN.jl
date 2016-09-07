# Kenya

[![Build Status](https://travis-ci.org/hpoit/Kenya.jl.svg?branch=master)](https://travis-ci.org/hpoit/Kenya.jl)
[![Documentation Status](https://readthedocs.org/projects/kenyajl/badge/?version=latest)](http://kenyajl.readthedocs.org/)
[![Coverage Status](https://img.shields.io/coveralls/hpoit/Kenya.jl.svg?style=flat)](https://coveralls.io/r/hpoit/Kenya.jl?branch=master)
[![License](http://img.shields.io/badge/license-MIT-brightgreen.svg?style=flat)](LICENSE.md)

[Tutorials](http://kenyajl.readthedocs.org/en/latest/#tutorials) | [Documentation](http://kenyajl.readthedocs.org/) | [Release Notes](NEWS.md) | [Roadmap](https://github.com/hpoit/Kenya.jl/issues/1)

Kenya is a distributed [Markov Logic Network](https://en.wikipedia.org/wiki/Markov_logic_network) for [Julia](http://julialang.org/), inspired by the works of Pedro Domingos, Stanford's Tuffy and Felix, Hélène Papadopoulos, and a few others.

Kenya is a unified learner, and can learn broadly or narrowly from any application.

Key points will be listed after some code is done.

## Installation

## Hello World

Inputs, in three parts

1. MLN program
   * Predicate definitions (constants and variables) (user beliefs) (optional)
   * e.g. Zika reported *and* unreported cases increased after the 2016 Olympics

   * Rule definitions (constants and variables with weights, 0.0-1.0) (optional)
   * e.g. Belief is 0.9 that it did

2. Evidence (observed constants and variables) (optional)
   * e.g. US, Hawaii, Canada, Cuba, Puerto Rico, Haiti, Brazil, Poland, Singapore cases increased

3. MAP Query (user questions about a closed or open world)
   * e.g. Did Zika cases, reported and not, increase for all countries?

   Marginal Query (user questions about an element within a world)
   * e.g. Did Zika unreported cases in Greenland increase?

Outputs, of two types

1. MAP inference (broad learning)
   * e.g. Reported and unreported Zika cases increased for countries x, y, z

2. Marginal inference (narrow learning)
   * e.g. Unreported Zika cases in Greenland increased by a likelihood of 64%

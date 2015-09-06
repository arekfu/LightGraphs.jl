# Inspiration for this code came from EvolvingGraphs:
# https://github.com/weijianzhang/EvolvingGraphs.jl
#
# The EvolvingGraphs.jl package is licensed under the MIT "Expat" License:
# Copyright (c) 2015: Weijian Zhang.
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included
# in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
# OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.#
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
# CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
# OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

"""Calculates the [Katz centrality](https://en.wikipedia.org/wiki/Katz_centrality)
of the graph `g`. The mode can be specified as `:receive` (default) or `:broadcast`
per [http://dx.doi.org/10.1103/PhysRevE.83.046120](http://centaur.reading.ac.uk/19357/1/Coomunicability_accepted.pdf).
"""
function katz_centrality(g::SimpleGraph, α::Real = 0.3, mode=:receive)
    if mode == :receive
        major = :byrow
    elseif mode == :broadcast
        major = :bycol
    else
        error("Mode must be :receive or :broadcast")
    end
    nvg = nv(g)
    v = ones(Float64, nvg)
    spI = speye(Float64, nvg)
    Aα = α * adjacency_matrix(g, major, Real)
    v = (spI - Aα)\v
    v /=  norm(v)
    return v
end

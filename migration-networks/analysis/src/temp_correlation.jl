### Correlation unweighted
function topological_overlap(g1,g2,i;how=degree)
    if how == indegree || how == degree
        tm = Matrix(adjacency_matrix(g1))[:,i]
        tm1 = Matrix(adjacency_matrix(g2))[:,i]
    else
        tm = Matrix(adjacency_matrix(g1))[i,:]
        tm1 = Matrix(adjacency_matrix(g2))[i,:]
    end
    upper = sum(tm .* tm1)
    lower = sqrt(sum(tm)*sum(tm1))
    upper/lower
end

function active_nodes(g;how=degree)
    length(findall(x-> how(g,x) > 0,vertices(g)))
end

function average_topological(g1,g2;kwargs...)
    the_sum = map(x -> topological_overlap(g1,g2,x;kwargs...), vertices(g1)) |>
        x -> replace!(x,NaN=>0) |>
        sum
    max_active = max(active_nodes(g1;kwargs...),active_nodes(g2;kwargs...))
    (1/max_active) * the_sum
end


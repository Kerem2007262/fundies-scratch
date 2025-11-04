use context starter2024
data TaxonomyTree:
    node(rank :: String, name :: String, Children :: List<TaxonomyTree>)
end

#Example

lion = node("Speceis", "Panthera leo", [list: ])
tiger = node("Specicies", "Panthera tigris", [list: ])
leopard = node("Specicies", "Panthera pardus", [list: ])
panthera = node("Genus", "Panthera", [list: lion, tiger, leopard])


house-cat = node("Species", "Felist catus", [list: ])
wildcat = node("Species", "Felis slivestris", [list: ])
felis = node("Genus", "Felis", [list: ])

felidae = node("Family", "Felidae", [list: house-cat, wildcat])


# function 1: prcess one tree

fun count-nodes(t :: TaxonomyTree) -> Number:
1 + coount-nodes-Children(t.children) #Count this node + all children
end

fun coount-nodes-Children(t :: List<TaxonomyTree>) -> Number: 
  cases(List) c:
    |empty => 1 # thid node is a leaf
    | else => count-leaves-children(t.children)
  end
end

fun count-leaves-children(c :: List<TaxonomyTree>) -> Number:
  cases (List) c:
    | empty => 0
    | link(first, rest) => count-leaves(first) + count-leaves-children(rest)
end 
end

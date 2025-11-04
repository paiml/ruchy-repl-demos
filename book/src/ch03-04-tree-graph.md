# Chapter 3.4: Tree and Graph Structures

Trees and graphs are fundamental data structures that represent hierarchical and networked relationships. In Ruchy, we implement these structures using arrays and structs, creating powerful tools for modeling complex data relationships.

## Understanding Trees

### Binary Tree Basics

A tree is a hierarchical data structure with nodes connected by edges. Each tree has a **root node** at the top and **child nodes** below. A **binary tree** restricts each node to at most two children: left and right.

```ruchy
// Binary tree node structure
let node = {
    value: 10,      // The data stored in the node
    left: -1,       // Index of left child (-1 means null)
    right: -1       // Index of right child (-1 means null)
};
```

**Key Tree Terminology:**
- **Root**: The topmost node with no parent
- **Leaf**: A node with no children
- **Parent**: A node with children
- **Child**: A node with a parent
- **Sibling**: Nodes sharing the same parent
- **Height**: Longest path from node to a leaf
- **Depth**: Distance from root to node
- **Level**: All nodes at the same depth

### Building a Binary Tree

```ruchy
// Constructing a tree:
//      10
//     /  \
//    5   15
//   / \
//  3   7

let tree = [
    {value: 10, left: 1, right: 2},    // Index 0: root
    {value: 5, left: 3, right: 4},     // Index 1: left child of root
    {value: 15, left: -1, right: -1},  // Index 2: right child of root
    {value: 3, left: -1, right: -1},   // Index 3: left-left child
    {value: 7, left: -1, right: -1}    // Index 4: left-right child
];

// Accessing nodes
let root = tree[0];
let left_child = tree[root.left];
println(left_child.value);  // Prints: 5
```

**Array-Based Tree Representation:**
- Each node is stored at an array index
- Children are referenced by their indices
- `-1` indicates no child (null pointer)
- This approach avoids pointer complexity while maintaining tree structure

## Tree Traversal Algorithms

Tree traversal is the process of visiting each node in a tree exactly once. Different traversal orders provide different insights into the tree structure.

### Pre-order Traversal (Root → Left → Right)

Visit the current node **before** its children. Useful for creating a copy of the tree or prefix expression evaluation.

```ruchy
// Pre-order traversal using stack
fun preorder_traversal(tree, root_idx) {
    let mut result = [];
    let mut stack = [root_idx];

    while stack.len() > 0 {
        // Pop from stack
        let node_idx = stack[stack.len() - 1];
        let mut new_stack = [];
        let mut i = 0;
        while i < stack.len() - 1 {
            new_stack = new_stack + [stack[i]];
            i = i + 1;
        }
        stack = new_stack;

        // Visit node
        result = result + [tree[node_idx].value];

        // Push right first (so left is processed first)
        if tree[node_idx].right != -1 {
            stack = stack + [tree[node_idx].right];
        }
        if tree[node_idx].left != -1 {
            stack = stack + [tree[node_idx].left];
        }
    }

    result
}

// Example: Pre-order traversal of tree
//      10
//     /  \
//    5   15
// Result: [10, 5, 15]
```

**Use Cases:**
- Tree serialization
- Prefix notation evaluation
- Creating a copy of the tree

### In-order Traversal (Left → Root → Right)

Visit left subtree, then current node, then right subtree. For binary search trees, this produces sorted output.

```ruchy
// In-order traversal (simplified for BST)
fun inorder_traversal_simple(tree, root_idx) {
    let mut result = [];
    let mut stack = [];
    let mut current = root_idx;
    let mut visited = [];

    // Initialize visited array
    let mut i = 0;
    while i < tree.len() {
        visited = visited + [false];
        i = i + 1;
    }

    stack = stack + [current];

    while stack.len() > 0 {
        current = stack[stack.len() - 1];

        // If has left child and not visited, go left
        if tree[current].left != -1 && !visited[tree[current].left] {
            stack = stack + [tree[current].left];
        } else {
            // Pop current
            let mut new_stack = [];
            let mut i = 0;
            while i < stack.len() - 1 {
                new_stack = new_stack + [stack[i]];
                i = i + 1;
            }
            stack = new_stack;

            // Visit
            result = result + [tree[current].value];
            visited[current] = true;

            // If has right child, go right
            if tree[current].right != -1 && !visited[tree[current].right] {
                stack = stack + [tree[current].right];
            }
        }
    }

    result
}

// For BST:
//      10
//     /  \
//    5   15
// Result: [5, 10, 15] (sorted!)
```

**Use Cases:**
- Getting sorted data from BST
- Infix notation evaluation
- Validating BST property

### Post-order Traversal (Left → Right → Root)

Visit children before the current node. Useful for deletion or calculating subtree properties.

```ruchy
// Post-order traversal (visit children before parent)
fun postorder_traversal(tree, root_idx) {
    let mut result = [];
    let mut stack = [{node: root_idx, visited: false}];

    while stack.len() > 0 {
        let current = stack[stack.len() - 1];

        // Pop
        let mut new_stack = [];
        let mut i = 0;
        while i < stack.len() - 1 {
            new_stack = new_stack + [stack[i]];
            i = i + 1;
        }
        stack = new_stack;

        let node = tree[current.node];

        if current.visited {
            // Visit after children processed
            result = result + [node.value];
        } else {
            // Mark as visited and push back
            stack = stack + [{node: current.node, visited: true}];

            // Push children (right first, then left)
            if node.right != -1 {
                stack = stack + [{node: node.right, visited: false}];
            }
            if node.left != -1 {
                stack = stack + [{node: node.left, visited: false}];
            }
        }
    }

    result
}

// Result for tree: [5, 15, 10] (children before parent)
```

**Use Cases:**
- Deleting nodes
- Calculating subtree properties (height, size)
- Postfix notation evaluation

### Level-order Traversal (Breadth-First)

Visit nodes level by level, from left to right. Uses a queue instead of a stack.

```ruchy
// Level-order traversal (BFS)
fun level_order_traversal(tree, root_idx) {
    let mut result = [];
    let mut queue = [root_idx];

    while queue.len() > 0 {
        // Dequeue
        let node_idx = queue[0];
        let mut new_queue = [];
        let mut i = 1;
        while i < queue.len() {
            new_queue = new_queue + [queue[i]];
            i = i + 1;
        }
        queue = new_queue;

        // Visit node
        result = result + [tree[node_idx].value];

        // Enqueue children
        if tree[node_idx].left != -1 {
            queue = queue + [tree[node_idx].left];
        }
        if tree[node_idx].right != -1 {
            queue = queue + [tree[node_idx].right];
        }
    }

    result
}

// For tree:
//      10
//     /  \
//    5   15
//   /
//  3
// Result: [10, 5, 15, 3] (level by level)
```

**Use Cases:**
- Finding shortest path in unweighted tree
- Level-wise processing
- Finding all nodes at a specific level

## Binary Search Trees (BST)

A Binary Search Tree maintains an ordering property: for every node, all values in the left subtree are less than the node's value, and all values in the right subtree are greater.

### BST Search Operation

```ruchy
// Search for value in BST - O(log n) average, O(n) worst case
fun bst_search(tree, root_idx, target) {
    let mut current = root_idx;

    while current != -1 {
        if tree[current].value == target {
            return true;  // Found!
        } else if target < tree[current].value {
            current = tree[current].left;  // Go left
        } else {
            current = tree[current].right;  // Go right
        }
    }

    false  // Not found
}

// Example BST:
//       10
//      /  \
//     5   15
//    / \
//   3   7

let bst = [
    {value: 10, left: 1, right: 2},
    {value: 5, left: 3, right: 4},
    {value: 15, left: -1, right: -1},
    {value: 3, left: -1, right: -1},
    {value: 7, left: -1, right: -1}
];

bst_search(bst, 0, 7);   // true
bst_search(bst, 0, 20);  // false
```

**BST Properties:**
- In-order traversal produces sorted sequence
- Search, insert, delete are O(log n) on balanced trees
- Can degenerate to O(n) if unbalanced (becomes like a linked list)

### Finding Min and Max

```ruchy
// Minimum value (leftmost node)
fun bst_find_min(tree, root_idx) {
    let mut current = root_idx;

    while tree[current].left != -1 {
        current = tree[current].left;
    }

    tree[current].value
}

// Maximum value (rightmost node)
fun bst_find_max(tree, root_idx) {
    let mut current = root_idx;

    while tree[current].right != -1 {
        current = tree[current].right;
    }

    tree[current].value
}
```

## Tree Properties

### Calculating Tree Height

Height is the length of the longest path from root to any leaf.

```ruchy
// Calculate tree height using level-order traversal
fun tree_height(tree, root_idx) {
    let mut max_height = 0;
    let mut queue = [{node: root_idx, level: 0}];

    while queue.len() > 0 {
        let current = queue[0];

        // Dequeue
        let mut new_queue = [];
        let mut i = 1;
        while i < queue.len() {
            new_queue = new_queue + [queue[i]];
            i = i + 1;
        }
        queue = new_queue;

        if current.level > max_height {
            max_height = current.level;
        }

        let node_idx = current.node;
        let node = tree[node_idx];

        if node.left != -1 {
            queue = queue + [{node: node.left, level: current.level + 1}];
        }
        if node.right != -1 {
            queue = queue + [{node: node.right, level: current.level + 1}];
        }
    }

    max_height
}
```

### Calculating Tree Size

```ruchy
// Tree size is simply the number of nodes
fun tree_size(tree) {
    tree.len()
}

// Or count while traversing
fun tree_size_traversal(tree, root_idx) {
    let mut count = 0;
    let mut stack = [root_idx];

    while stack.len() > 0 {
        let node_idx = stack[stack.len() - 1];

        // Pop
        let mut new_stack = [];
        let mut i = 0;
        while i < stack.len() - 1 {
            new_stack = new_stack + [stack[i]];
            i = i + 1;
        }
        stack = new_stack;

        count = count + 1;

        if tree[node_idx].right != -1 {
            stack = stack + [tree[node_idx].right];
        }
        if tree[node_idx].left != -1 {
            stack = stack + [tree[node_idx].left];
        }
    }

    count
}
```

## Understanding Graphs

Graphs are collections of **nodes (vertices)** connected by **edges**. Unlike trees, graphs can have cycles and multiple paths between nodes.

### Graph Terminology

- **Vertex/Node**: A point in the graph
- **Edge**: A connection between two vertices
- **Directed Graph**: Edges have direction (A → B)
- **Undirected Graph**: Edges are bidirectional (A ↔ B)
- **Weighted Graph**: Edges have associated costs/weights
- **Cycle**: A path that starts and ends at the same vertex
- **Connected Graph**: There's a path between any two vertices
- **Degree**: Number of edges connected to a vertex

### Graph Representations

#### Adjacency List (Most Common)

Store each node with its list of neighbors. Efficient for sparse graphs.

```ruchy
// Directed graph: A → B, A → C, B → D, C → D
let graph = [
    {node: "A", neighbors: ["B", "C"]},
    {node: "B", neighbors: ["D"]},
    {node: "C", neighbors: ["D"]},
    {node: "D", neighbors: []}
];

// Check if edge exists
fun has_edge(graph, from, to) {
    for entry in graph {
        if entry.node == from {
            for neighbor in entry.neighbors {
                if neighbor == to {
                    return true;
                }
            }
            break;
        }
    }
    false
}

has_edge(graph, "A", "B");  // true
has_edge(graph, "B", "A");  // false (directed)
```

#### Undirected Graph

For undirected graphs, add edges in both directions.

```ruchy
// Undirected graph: A-B, A-C, B-C
let undirected_graph = [
    {node: "A", neighbors: ["B", "C"]},
    {node: "B", neighbors: ["A", "C"]},  // A appears here too
    {node: "C", neighbors: ["A", "B"]}   // Both A and B
];
```

#### Weighted Graph

Add weight information to edges.

```ruchy
// Weighted directed graph with edge weights
let weighted_graph = [
    {node: "A", edges: [
        {to: "B", weight: 5},
        {to: "C", weight: 3}
    ]},
    {node: "B", edges: [
        {to: "D", weight: 2}
    ]},
    {node: "C", edges: [
        {to: "D", weight: 4}
    ]},
    {node: "D", edges: []}
];

// Get edge weight
fun get_edge_weight(graph, from, to) {
    for entry in graph {
        if entry.node == from {
            for edge in entry.edges {
                if edge.to == to {
                    return edge.weight;
                }
            }
            break;
        }
    }
    -1  // Not found
}

get_edge_weight(weighted_graph, "A", "B");  // 5
```

## Graph Traversal Algorithms

### Breadth-First Search (BFS)

Visit nodes level by level, exploring all neighbors before moving deeper. Uses a queue.

```ruchy
// BFS traversal from start node
fun graph_bfs(graph, start) {
    let mut visited = [];
    let mut queue = [start];

    while queue.len() > 0 {
        // Dequeue
        let current = queue[0];
        let mut new_queue = [];
        let mut i = 1;
        while i < queue.len() {
            new_queue = new_queue + [queue[i]];
            i = i + 1;
        }
        queue = new_queue;

        // Check if already visited
        let mut already_visited = false;
        for v in visited {
            if v == current {
                already_visited = true;
                break;
            }
        }

        if !already_visited {
            visited = visited + [current];

            // Find and enqueue neighbors
            for entry in graph {
                if entry.node == current {
                    for neighbor in entry.neighbors {
                        queue = queue + [neighbor];
                    }
                    break;
                }
            }
        }
    }

    visited
}

// Example graph: A → B, A → C, B → D, C → D
// BFS from A: [A, B, C, D]
```

**BFS Use Cases:**
- Finding shortest path in unweighted graphs
- Level-order processing
- Testing connectivity
- Finding all nodes within k distance

### Depth-First Search (DFS)

Explore as far as possible along each branch before backtracking. Uses a stack.

```ruchy
// DFS traversal from start node
fun graph_dfs(graph, start) {
    let mut visited = [];
    let mut stack = [start];

    while stack.len() > 0 {
        // Pop
        let current = stack[stack.len() - 1];
        let mut new_stack = [];
        let mut i = 0;
        while i < stack.len() - 1 {
            new_stack = new_stack + [stack[i]];
            i = i + 1;
        }
        stack = new_stack;

        // Check if already visited
        let mut already_visited = false;
        for v in visited {
            if v == current {
                already_visited = true;
                break;
            }
        }

        if !already_visited {
            visited = visited + [current];

            // Find neighbors and push to stack
            for entry in graph {
                if entry.node == current {
                    // Push in reverse for left-to-right processing
                    let mut i = entry.neighbors.len();
                    while i > 0 {
                        i = i - 1;
                        stack = stack + [entry.neighbors[i]];
                    }
                    break;
                }
            }
        }
    }

    visited
}

// Example graph: A → B, A → C, B → D, C → D
// DFS from A: [A, B, D, C] (explores B's path first)
```

**DFS Use Cases:**
- Cycle detection
- Topological sorting
- Path finding
- Connected components
- Solving mazes and puzzles

## Graph Algorithms

### Cycle Detection

Detect if a directed graph contains a cycle.

```ruchy
// Simple cycle detection using DFS
fun has_cycle(graph, start) {
    let mut visited = [];
    let mut path = [start];
    let mut has_cycle = false;

    while path.len() > 0 && !has_cycle {
        let current = path[path.len() - 1];

        // Check if already visited (indicates cycle)
        let mut already_visited = false;
        for v in visited {
            if v == current {
                already_visited = true;
                break;
            }
        }

        if already_visited {
            has_cycle = true;
        } else {
            visited = visited + [current];

            // Pop current
            let mut new_path = [];
            let mut i = 0;
            while i < path.len() - 1 {
                new_path = new_path + [path[i]];
                i = i + 1;
            }
            path = new_path;

            // Add neighbors
            for entry in graph {
                if entry.node == current {
                    for neighbor in entry.neighbors {
                        path = path + [neighbor];
                    }
                    break;
                }
            }
        }
    }

    has_cycle
}

// Graph with cycle: A → B → C → A
let cyclic_graph = [
    {node: "A", neighbors: ["B"]},
    {node: "B", neighbors: ["C"]},
    {node: "C", neighbors: ["A"]}
];

has_cycle(cyclic_graph, "A");  // true
```

### Path Finding

Find a path between two nodes using BFS (shortest path in unweighted graph).

```ruchy
// Find path from start to target using BFS
fun find_path(graph, start, target) {
    let mut queue = [{node: start, path: [start]}];
    let mut found_path = [];

    while queue.len() > 0 && found_path.len() == 0 {
        let current = queue[0];

        // Dequeue
        let mut new_queue = [];
        let mut i = 1;
        while i < queue.len() {
            new_queue = new_queue + [queue[i]];
            i = i + 1;
        }
        queue = new_queue;

        if current.node == target {
            found_path = current.path;
        } else {
            // Find neighbors and enqueue with extended path
            for entry in graph {
                if entry.node == current.node {
                    for neighbor in entry.neighbors {
                        let new_path = current.path + [neighbor];
                        queue = queue + [{node: neighbor, path: new_path}];
                    }
                    break;
                }
            }
        }
    }

    found_path
}

// Find path from A to D
let graph = [
    {node: "A", neighbors: ["B", "C"]},
    {node: "B", neighbors: ["D"]},
    {node: "C", neighbors: ["D"]},
    {node: "D", neighbors: []}
];

find_path(graph, "A", "D");  // ["A", "B", "D"] or ["A", "C", "D"]
```

### Connected Components

Find all connected components in an undirected graph.

```ruchy
// Find all connected components
fun connected_components(graph) {
    let mut visited = [];
    let mut components = [];

    for entry in graph {
        let node = entry.node;

        // Check if already visited
        let mut already_visited = false;
        for v in visited {
            if v == node {
                already_visited = true;
                break;
            }
        }

        if !already_visited {
            // Start new component with BFS
            let mut component = [];
            let mut queue = [node];

            while queue.len() > 0 {
                let current = queue[0];

                // Dequeue
                let mut new_queue = [];
                let mut i = 1;
                while i < queue.len() {
                    new_queue = new_queue + [queue[i]];
                    i = i + 1;
                }
                queue = new_queue;

                // Check if already in component
                let mut in_component = false;
                for c in component {
                    if c == current {
                        in_component = true;
                        break;
                    }
                }

                if !in_component {
                    component = component + [current];
                    visited = visited + [current];

                    // Add neighbors
                    for e in graph {
                        if e.node == current {
                            for neighbor in e.neighbors {
                                queue = queue + [neighbor];
                            }
                            break;
                        }
                    }
                }
            }

            components = components + [component];
        }
    }

    components
}
```

## Practical Examples

### Example 1: File System Tree

```ruchy
// File system as tree
let filesystem = [
    {name: "/", type: "dir", children: [1, 2]},
    {name: "home", type: "dir", children: [3, 4]},
    {name: "etc", type: "dir", children: []},
    {name: "user1", type: "dir", children: [5]},
    {name: "user2", type: "dir", children: []},
    {name: "file.txt", type: "file", children: []}
];

// List all files (DFS)
fun list_files(fs, root_idx) {
    let mut files = [];
    let mut stack = [root_idx];

    while stack.len() > 0 {
        let idx = stack[stack.len() - 1];

        // Pop
        let mut new_stack = [];
        let mut i = 0;
        while i < stack.len() - 1 {
            new_stack = new_stack + [stack[i]];
            i = i + 1;
        }
        stack = new_stack;

        let node = fs[idx];

        if node.type == "file" {
            files = files + [node.name];
        }

        // Add children to stack
        for child_idx in node.children {
            stack = stack + [child_idx];
        }
    }

    files
}

list_files(filesystem, 0);  // ["file.txt"]
```

### Example 2: Social Network Graph

```ruchy
// Social network as directed graph (following relationship)
let social_network = [
    {user: "Alice", following: ["Bob", "Charlie"]},
    {user: "Bob", following: ["Charlie", "David"]},
    {user: "Charlie", following: ["David"]},
    {user: "David", following: ["Alice"]}
];

// Find friends of friends (2 hops away)
fun friends_of_friends(network, user) {
    let mut fof = [];

    // Find direct friends
    let mut direct_friends = [];
    for entry in network {
        if entry.user == user {
            direct_friends = entry.following;
            break;
        }
    }

    // Find friends of each direct friend
    for friend in direct_friends {
        for entry in network {
            if entry.user == friend {
                for fof_candidate in entry.following {
                    // Don't include self or direct friends
                    if fof_candidate != user {
                        let mut is_direct = false;
                        for df in direct_friends {
                            if df == fof_candidate {
                                is_direct = true;
                                break;
                            }
                        }

                        if !is_direct {
                            // Check not already in list
                            let mut already_added = false;
                            for existing in fof {
                                if existing == fof_candidate {
                                    already_added = true;
                                    break;
                                }
                            }

                            if !already_added {
                                fof = fof + [fof_candidate];
                            }
                        }
                    }
                }
                break;
            }
        }
    }

    fof
}

friends_of_friends(social_network, "Alice");  // ["David"]
```

### Example 3: Shortest Path in City Map

```ruchy
// City map as weighted graph
let city_map = [
    {location: "Home", roads: [
        {to: "Store", distance: 2},
        {to: "Park", distance: 5}
    ]},
    {location: "Store", roads: [
        {to: "Work", distance: 3}
    ]},
    {location: "Park", roads: [
        {to: "Work", distance: 2}
    ]},
    {location: "Work", roads: []}
];

// Find shortest path with total distance
fun shortest_path_weighted(graph, start, target) {
    let mut queue = [{
        location: start,
        path: [start],
        distance: 0
    }];

    let mut best_path = {path: [], distance: 999999};

    while queue.len() > 0 {
        let current = queue[0];

        // Dequeue
        let mut new_queue = [];
        let mut i = 1;
        while i < queue.len() {
            new_queue = new_queue + [queue[i]];
            i = i + 1;
        }
        queue = new_queue;

        if current.location == target {
            if current.distance < best_path.distance {
                best_path = {
                    path: current.path,
                    distance: current.distance
                };
            }
        } else {
            // Find roads from current location
            for entry in graph {
                if entry.location == current.location {
                    for road in entry.roads {
                        let new_path = current.path + [road.to];
                        let new_distance = current.distance + road.distance;

                        queue = queue + [{
                            location: road.to,
                            path: new_path,
                            distance: new_distance
                        }];
                    }
                    break;
                }
            }
        }
    }

    best_path
}

shortest_path_weighted(city_map, "Home", "Work");
// {path: ["Home", "Store", "Work"], distance: 5}
```

## Performance Considerations

### Time Complexity

| Operation | Tree (Array) | Graph (Adjacency List) |
|-----------|--------------|------------------------|
| Access node | O(1) | O(1) |
| Search | O(n) | O(V + E) |
| BST Search | O(log n) avg | N/A |
| DFS/BFS | O(n) | O(V + E) |
| Insert | O(n) | O(1) |
| Delete | O(n) | O(E) |

Where:
- n = number of nodes in tree
- V = number of vertices in graph
- E = number of edges in graph

### Space Complexity

- **Tree (Array-based)**: O(n) for n nodes
- **Graph (Adjacency List)**: O(V + E) for V vertices and E edges
- **BFS Queue**: O(width) - width of tree/graph
- **DFS Stack**: O(height) - height of tree/graph

### Optimization Tips

1. **Use appropriate representation**:
   - Adjacency list for sparse graphs (few edges)
   - Adjacency matrix for dense graphs (many edges)

2. **Track visited nodes**:
   - Prevents infinite loops in cyclic graphs
   - Improves performance by avoiding re-processing

3. **Choose right traversal**:
   - BFS for shortest path in unweighted graphs
   - DFS for cycle detection and topological sorting

4. **Prune search space**:
   - Use heuristics to avoid exploring unnecessary paths
   - Early termination when target is found

## Common Patterns

### Tree Pattern Checklist

```ruchy
// Tree node structure
// - value field for data
// - left/right (or children array) for connections
// - Use -1 for null pointers

// Common tree operations:
// 1. Traversal (pre/in/post/level-order)
// 2. Search (find node with value)
// 3. Height calculation
// 4. Size calculation (count nodes)
// 5. Validation (e.g., is valid BST?)
```

### Graph Pattern Checklist

```ruchy
// Graph node structure
// - node identifier
// - neighbors array (adjacency list)
// - Optional: edges with weights

// Common graph operations:
// 1. Traversal (BFS/DFS)
// 2. Path finding
// 3. Cycle detection
// 4. Connected components
// 5. Shortest path (weighted/unweighted)

// Always track visited nodes to avoid infinite loops!
```

## Best Practices

1. **Use -1 for null pointers**: Consistent null representation in tree structures

2. **Track visited nodes in graphs**: Essential for preventing infinite loops in cyclic graphs

3. **Choose appropriate data structure**:
   - Trees for hierarchical data
   - Graphs for networked relationships

4. **Use queues for BFS, stacks for DFS**: Match data structure to algorithm

5. **Consider weighted vs unweighted**: Use appropriate structure for edge weights

6. **Validate tree/graph properties**: Check for cycles, connectivity before algorithms

7. **Handle edge cases**:
   - Empty tree/graph
   - Single node
   - Disconnected components
   - Self-loops

## Summary

Trees and graphs are powerful structures for representing hierarchical and networked data. In Ruchy:

- **Trees** are implemented with arrays and struct nodes containing value and child indices
- **Binary trees** restrict each node to two children (left and right)
- **Traversal algorithms** (pre-order, in-order, post-order, level-order) visit nodes in different orders
- **Binary Search Trees** maintain ordering for efficient O(log n) search
- **Graphs** represent networked relationships using adjacency lists
- **BFS** uses queues for level-by-level traversal
- **DFS** uses stacks for depth-first exploration
- **Path finding**, **cycle detection**, and **connected components** are key graph algorithms

These structures enable solving complex problems in routing, AI, databases, social networks, and more!

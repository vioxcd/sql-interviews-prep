-- Link: https://www.hackerrank.com/challenges/binary-search-tree-1
-- Level: Medium
-- Description: You are given a table, BST, containing two columns: N and P, where N represents the value of a node in Binary Tree, and P is the parent of N. Write a query to find the node type of Binary Tree ordered by the value of the node. Output one of the following for each node: Root: If node is root node. Leaf: If node is leaf node. Inner: If node is neither root nor leaf node.
-- Result: https://github.com/vioxcd/sql-interviews-prep/assets/31486724/fbead060-0b69-45d2-ac2c-4951e3ee09a4
select distinct
    bst1.n,
    case
        when bst1.p is null then 'Root'
        when bst2.p is null then 'Leaf'
        else 'Inner'
    end as node_type
from bst bst1
left join bst bst2
    on bst1.n = bst2.p
order by bst1.n
